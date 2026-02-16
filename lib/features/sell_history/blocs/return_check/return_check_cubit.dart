import 'package:app/blocs/blocs.dart';
import 'package:app/client/clients.dart';
import 'package:app/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uuid/uuid.dart';

part 'return_check_data.dart';
part 'return_check_state.dart';

class ReturnCheckCubit extends Cubit<ReturnCheckState> {
  ReturnCheckCubit(
    this.check,
    this.settingsCubit,
    this.sessionCubit,
    this.authCubit,
  ) : super(ReturnCheckInitial(items: init(check)));

  final DetailCheckScheme check;
  final SettingsCubit settingsCubit;
  final SessionCubit sessionCubit;
  final AuthCubit authCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;
  AuthorScheme? get author => settingsCubit.state.author;
  StructureUnitScheme? get store => settingsCubit.state.store;
  StructureUnitScheme? get subdivision => settingsCubit.state.subdivision;
  UserScheme? get user => authCubit.state.user;
  WorkShiftScheme? get workShift => sessionCubit.state.currentWorkShift;

  Future createCheckReturn() async {
    if (author == null ||
        cashRegister == null ||
        workShift == null ||
        subdivision == null ||
        store == null ||
        user == null) {
      return;
    }

    emit(ReturnCheckLoading(state));
    try {
      final items = state.notEmptyItems;

      final response = await client.createCheckReturn(
        data: CreateReturnCheckScheme(
          date: DateTime.now(),
          authorKey: author!.refKey,
          checkKey: check.refKey,
          cashRegisterKey: cashRegister!.refKey,
          sessionKey: workShift!.refKey,
          subdivisionKey: subdivision!.refKey,
          storeKey: store!.refKey,
          userKey: user!.refKey,
          totalSum: state.totalSum,
          cashPayment: state.totalSum,
          checkOrderId: Uuid().v6(),
          items: items.map((i) {
            final index = items.indexOf(i);
            return CreateReturnCheckItemScheme(
              lineNumber: index + 1,
              key: index + 1,
              nomenclatureKey: i.nomenclatureKey,
              characteristicKey: i.characteristicKey,
              quantity: i.quantity,
              price: i.price,
              totalSum: i.totalSum,
              allSum: i.totalSum,
              unitKey: i.unitKey,
            );
          }).toList(),
        ),
      );
      await client.postCheckReturn(refKey: response.refKey);
      emit(ReturnCheckLoaded(state));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(ReturnCheckFailure(state));
    }
  }

  void update(ReturnCheckItemData item) {
    final List<ReturnCheckItemData> items = List.from(state.items);
    final index = state.items.indexOf(item);
    if (index != -1) {
      items[index] = item;
      final newState = state.copyWith(items);
      emit(ReturnCheckUpdate(newState));
    }
  }

  static List<ReturnCheckItemData> init(DetailCheckScheme check) {
    return check.items.map((item) {
      return ReturnCheckItemData(
        nomenclatureKey: item.nomenclatureKey,
        characteristicKey: item.characteriticKey,
        price: item.price,
        quantity: 0,
        unitKey: item.unitKey,
      );
    }).toList();
  }
}
