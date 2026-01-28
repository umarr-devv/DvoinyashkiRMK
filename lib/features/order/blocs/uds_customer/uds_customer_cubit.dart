import 'package:app/client/clients.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/undefined.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

part 'uds_customer_state.dart';

class UdsCustomerCubit extends Cubit<UdsCustomerState> {
  UdsCustomerCubit() : super(UdsCustomerInitial());

  final udsClient = GetIt.I<UDSClient>();
  final talker = GetIt.I<Talker>();

  Future findCustomer(String code) async {
    emit(UdsCustomerLoading(state));
    try {
      final response = await udsClient.getCustomer(code: code);
      final newState = state.copyWith(response);
      emit(UdsCustomerLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(UdsCustomerFailure(state));
    }
  }

  void clear() {
    final newState = state.copyWith(undefined);
    emit(UdsCustomerClear(newState));
  }
}
