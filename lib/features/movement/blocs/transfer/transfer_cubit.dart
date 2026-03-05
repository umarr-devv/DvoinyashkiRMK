import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/odata_query.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  TransferCubit() : super(TransferInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future getTransfer(String number) async {
    emit(TransferLoading(state));
    try {
      final response = await client.getTransfer(
        fullPath: buildODataQuery({
          '\$filter': 'Number eq \'$number\'',
          '\$top': '1',
          '\$orderby': 'Date desc',
          '\$format': 'json',
        }),
      );
      final newState = state.copyWith(response.value[0]);
      emit(TransferLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(TransferFailure(state));
    }
  }

  Future accept(String refKey) async {
    emit(TransferUpdating(state));
    try {
      await client.updateTransfer(
        refKey: refKey,
        data: TransferUpdateScheme(
          transferDate: DateTime.now(),
          isAccepted: true,
        ),
      );
      emit(TransferUpdated(state));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(TransferUpdateFailure(state));
    }
  }
}
