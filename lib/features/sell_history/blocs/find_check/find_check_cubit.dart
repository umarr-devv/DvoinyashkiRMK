import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'find_check_state.dart';

class FindCheckCubit extends Cubit<FindCheckState> {
  FindCheckCubit() : super(FindCheckInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future findByNumber(String number) async {
    emit(FindCheckLoading(state));
    await Future.delayed(const Duration(seconds: 1));
    try {
      final Map<String, dynamic> params = {
        '\$top': '1',
        '\$filter': 'Number eq \'$number\'',
        '\$orderby': 'Date desc',
        '\$format': 'json',
      };
      final response = await client.getChecks(
        fullPath: buildODataQuery(params),
      );
      if (response.checks.isNotEmpty) {
        final newState = state.copyWith(response.checks[0]);
        emit(FindCheckLoaded(newState));
      } else {
        emit(FindCheckFailure(state));
      }
    } catch (exc, st) {
      talker.error(exc, st);
      emit(FindCheckFailure(state));
    }
  }

  Future findByRef(String number) async {
    emit(FindCheckLoading(state));
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await client.getCheck(refKey: number);
      final newState = state.copyWith(response);
      emit(FindCheckLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(FindCheckFailure(state));
    }
  }
}
