import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'create_movement_state.dart';
part 'create_movement_data.dart';

class CreateMovementCubit extends Cubit<CreateMovementState> {
  CreateMovementCubit(this.settingsCubit, this.authCubit)
    : super(CreateMovementInitial());

  final SettingsCubit settingsCubit;
  final AuthCubit authCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;
  AuthorScheme? get author => settingsCubit.state.author;
  StructureUnitScheme? get store => settingsCubit.state.store;
  StructureUnitScheme? get subdivision => settingsCubit.state.subdivision;
  UserScheme? get user => authCubit.state.user;

  void update(CreateMovementState newState) {
    emit(CreateMovementUpdate(newState));
  }

  void setItem(CreateMovementItemData item) {
    final List<CreateMovementItemData> items = List.from(state.items);
    final index = items.indexOf(item);
    if (item.quantity == 0) {
      deleteItem(item);
      return;
    }
    if (index != -1) {
      items[index] = item;
    } else {
      items.add(item);
    }
    final newState = state.copyWith(items: items);
    emit(CreateMovementUpdate(newState));
  }

  void deleteItem(CreateMovementItemData item) {
    final List<CreateMovementItemData> items = List.from(state.items);
    final index = items.indexOf(item);
    if (index != -1) {
      items.removeAt(index);
      final newState = state.copyWith(items: items);
      emit(CreateMovementUpdate(newState));
    }
  }

  Future create() async {
    if (author == null || user == null || store == null) {
      return;
    }
    emit(CreateMovementLoading(state));

    try {
      await client.createMovement(
        data: CreateMovementScheme(
          date: DateTime.now(),
          authorKey: author!.refKey,
          userKey: user!.refKey,
          reserveStructureUnitKey: movementWarehouseRef,
          storeKey: store!.refKey,
          movementDate: DateTime.now(),
          orderSum: state.totalSum,
          documentSum: state.totalSum,
          items: state.items.map((i) {
            final int index = state.items.indexOf(i);
            return CreateMovementItemScheme(
              lineNumber: index + 1,
              nomenclatureKey: i.product.nomenclature.refKey,
              characteristicKey: i.product.characteristic?.refKey,
              unitKey: i.product.nomenclature.unitKey,
              quantity: i.quantity,
              price: i.product.sellPrice?.price.price.toDouble() ?? 0,
              totalSum: i.totalSum,
            );
          }).toList(),
        ),
      );
      final newState = state.copyWith(items: []);
      emit(CreateMovementLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(CreateMovementFailure(state));
    }
  }
}
