import 'package:app/client/client.dart';
import 'package:app/client/second_client.dart';
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
  final secondClient = GetIt.I<SecondRestClient>();
  final talker = GetIt.I<Talker>();

  Future getTransfer(String number) async {
    emit(TransferLoading(state));
    try {
      final path = buildODataQuery({
        '\$filter': 'Number eq \'$number\'',
        '\$top': '1',
        '\$orderby': 'Date desc',
        '\$format': 'json',
      });
      final response1 = await client.getTransfer(fullPath: path);
      final response2 = await secondClient.getTransfer(fullPath: path);
      if (response1.value.isNotEmpty) {
        final newState = state.copyWith(response1.value[0], false);
        emit(TransferLoaded(newState));
      } else if (response2.value.isNotEmpty) {
        final newState = state.copyWith(response2.value[0], true);
        emit(TransferLoaded(newState));
      } else {
        emit(TransferFailure(state));
      }
    } catch (exc, st) {
      talker.error(exc, st);
      emit(TransferFailure(state));
    }
  }

  Future accept() async {
    emit(TransferUpdating(state));
    if (state.transfer == null) return;
    try {
      if (state.isSecondData == true) {
  
        await client.createTransfer(data: state.transfer!);
      }
      await client.updateTransfer(
        refKey: state.transfer!.refKey,
        data: TransferUpdateScheme(
          transferDate: DateTime.now(),
          isAccepted: true,
        ),
      );
      await client.postTransfer(refKey: state.transfer!.refKey);
      emit(TransferUpdated(state));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(TransferUpdateFailure(state));
    }
  }
}
