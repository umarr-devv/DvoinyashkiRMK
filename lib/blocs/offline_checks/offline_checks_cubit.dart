import 'package:app/client/clients.dart';
import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'offline_checks_cubit.g.dart';
part 'offline_checks_state.dart';

class OfflineChecksCubit extends HydratedCubit<OfflineChecksState> {
  OfflineChecksCubit() : super(const OfflineChecksInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  void addCheck(CreateCheckScheme check) {
    final newState = state.copyWith(checks: [...state.checks, check]);
    emit(OfflineChecksUpdate(newState));
  }

  void removeCheck(int index) {
    final newChecks = List<CreateCheckScheme>.from(state.checks)
      ..removeAt(index);
    final newState = state.copyWith(checks: newChecks);
    emit(OfflineChecksUpdate(newState));
  }

  Future<void> sendAll() async {
    if (state.checks.isEmpty) return;
    if (state is OfflineChecksSending) return;
    emit(OfflineChecksSending(state));
    final failedChecks = <CreateCheckScheme>[];
    for (final check in state.checks) {
      try {
        final created = await client.createCheck(data: check);
        await client.postCheck(refKey: created.refKey);
      } catch (exc, st) {
        talker.error(exc, st);
        failedChecks.add(check);
      }
    }
    final newState = state.copyWith(checks: failedChecks);
    if (failedChecks.isEmpty) {
      emit(OfflineChecksSent(newState));
    } else {
      emit(OfflineChecksSendFailure(newState));
    }
  }

  @override
  OfflineChecksState? fromJson(Map<String, dynamic> json) {
    return OfflineChecksState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(OfflineChecksState state) {
    return state.toJson();
  }
}
