import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

part 'create_withdraw_state.dart';

class CreateWithdrawCubit extends Cubit<CreateWithdrawState> {
  CreateWithdrawCubit(this.settingsCubit, this.sessionCubit)
    : super(CreateWithdrawInitial());

  final SettingsCubit settingsCubit;
  final SessionCubit sessionCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;
  AuthorScheme? get author => settingsCubit.state.author;
  StructureUnitScheme? get store => settingsCubit.state.store;
  StructureUnitScheme? get subdivision => settingsCubit.state.subdivision;
  WorkShiftScheme? get workShift => sessionCubit.state.currentWorkShift;

  Future create(double documentSum, String? comment) async {
    if (cashRegister == null ||
        author == null ||
        store == null ||
        subdivision == null ||
        workShift == null) {
      return;
    }
    emit(CreateWithdrawLoading(state));
    try {
      final response = await client.createWithdraw(
        data: CreateWithdrawScheme(
          date: DateTime.now(),
          comment: comment,
          cashRegisterKey: cashRegister!.refKey,
          authorKey: author!.refKey,
          subdivisionKey: subdivision!.refKey,
          storeKey: store!.refKey,
          sessionKey: workShift!.refKey,
          documentSum: documentSum,
        ),
      );
      final newState = state.copyWith(response);
      emit(CreateWithdrawLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(CreateWithdrawFailure(state));
    }
  }
}
