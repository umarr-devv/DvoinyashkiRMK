import 'package:app/client/client.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'cash_registers_cubit.g.dart';
part 'cash_registers_state.dart';

class CashRegistersCubit extends HydratedCubit<CashRegistersState> {
  CashRegistersCubit() : super(CashRegistersInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future update() async {
    if (state.update == null ||
        DateTime.now().difference(state.update!) > updateInterval) {
      await forceUpdate();
    }
  }

  Future forceUpdate() async {
    emit(CashRegistersLoading(state));
    try {
      final response = await client.getCashRegisters();
      final newState = state.copyWith(
        cashRegisters: response.cashRegisters,
        update: DateTime.now(),
      );
      emit(CashRegistersLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(CashRegistersFailure(state));
    }
  }

  @override
  CashRegistersState? fromJson(Map<String, dynamic> json) {
    return CashRegistersState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CashRegistersState state) {
    return state.toJson();
  }
}
