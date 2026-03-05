import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  TransferCubit() : super(TransferInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future getTransfer(String refKey) async {
    emit(TransferLoading(state));
    try {
      final response = await client.getTransfer(refKey: refKey);
      final newState = state.copyWith(response);
      emit(TransferLoaded(newState));
    } catch (exc, st){
      talker.error(exc, st);
      emit(TransferFailure(state));

    }
  }
}
