import 'dart:async';

import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'terminal_state.dart';

class TerminalCubit extends HydratedCubit<TerminalState> {
  TerminalCubit(this.settingsCubit, this.connectivityCubit) : super(TerminalInitial()) {
    _connectivitySubscription = connectivityCubit.stream.listen((connState) {
      if (connState is ConnectivityOnline) {
        sendPendingReports();
      }
    });
    if (connectivityCubit.state is ConnectivityOnline) {
      sendPendingReports();
    }
  }

  final SettingsCubit settingsCubit;
  final ConnectivityCubit connectivityCubit;
  StreamSubscription? _connectivitySubscription;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  StructureUnitScheme? get store => settingsCubit.state.store;

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }

  @override
  TerminalState? fromJson(Map<String, dynamic> json) {
    return TerminalState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TerminalState state) {
    return state.toJson();
  }

  Future getWorkReport(UserScheme user) async {
    if (state is TerminalLoading) return;
    emit(TerminalLoading(state));
    try {
      final response = await client.getWorkReportItem(
        fullPath: buildODataQuery({
          '\$top': '1',
          '\$orderby': 'ДатаПересечения desc',
          '\$format': 'json',
          '\$filter':
              'Сотрудник_Key eq guid\'${user.refKey}\'',
        }),
      );
      if (response.value.isNotEmpty) {
        final workReport = response.value[0];
        if (workReport.moment == 1) {
          final newState = state.copyWith(workReport);
          emit(TerminalLoaded(newState));
          return;
        }
      }

      emit(TerminalLoaded(state));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(TerminalFailure(state));
    }
  }

  Future come(UserScheme user) async {
    if (state is TerminalUpdating || state is TerminalLoading) return;
    emit(TerminalUpdating(state));
    final now = DateTime.now();
    final data = WorkReportScheme(
      employeeKey: user.refKey,
      terminalKey: "787abe65-4db7-11f0-be1f-00155d00f705",
      exitType: "Кируу (Вход)",
      moment: 1,
      minute: now.minute.toString(),
      crossingDate: now,
      status: "",
      fio: user.description,
      updaterKey: null,
      placeKey: store?.refKey ?? user.departmentKey,
      passNumber: null,
    );
    try {
      final response = await client.createWorkReport(data: data);
      final newState = state.copyWith(response);
      emit(TerminalUpdated(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      final pending = List<WorkReportScheme>.from(state.pendingReports)..add(data);
      final newState = state.copyWith(data, pendingReports: pending);
      emit(TerminalUpdated(newState));
    }
  }

  Future leave(UserScheme user) async {
    final workReport = state.workReport;
    if (state is TerminalUpdating || state is TerminalLoading) return;
    emit(TerminalUpdating(state));
    final now = DateTime.now();
    final data = WorkReportScheme(
      employeeKey: user.refKey,
      terminalKey: workReport?.terminalKey ?? "787abe65-4db7-11f0-be1f-00155d00f705",
      exitType: "Чыгуу (Выход)",
      moment: 0,
      minute: now.minute.toString(),
      crossingDate: now,
      status: "",
      fio: user.description,
      updaterKey: workReport?.updaterKey,
      placeKey: store?.refKey ?? user.departmentKey,
      passNumber: workReport?.passNumber,
    );
    try {
      await client.createWorkReport(data: data);
      final newState = state.copyWith(undefined);
      emit(TerminalUpdated(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      final pending = List<WorkReportScheme>.from(state.pendingReports)..add(data);
      final newState = state.copyWith(undefined, pendingReports: pending);
      emit(TerminalUpdated(newState));
    }
  }

  Future sendPendingReports() async {
    if (state.pendingReports.isEmpty) return;
    final failedReports = <WorkReportScheme>[];
    for (final report in state.pendingReports) {
      try {
        await client.createWorkReport(data: report);
      } catch (exc, st) {
        talker.error(exc, st);
        failedReports.add(report);
      }
    }
    emit(state.copyWith(null, pendingReports: failedReports));
  }
}
