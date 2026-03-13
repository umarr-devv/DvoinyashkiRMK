import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

part 'terminal_state.dart';

class TerminalCubit extends Cubit<TerminalState> {
  TerminalCubit() : super(TerminalInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

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
    try {
      final now = DateTime.now();
      final response = await client.createWorkReport(
        data: WorkReportScheme(
          employeeKey: user.refKey,
          terminalKey: "787abe65-4db7-11f0-be1f-00155d00f705",
          exitType: "Кируу (Вход)",
          moment: 1,
          minute: now.minute.toString(),
          crossingDate: now,
          status: "",
          fio: user.description,
          updaterKey: null,
          placeKey: user.departmentKey,
          passNumber: null,
        ),
      );
      final newState = state.copyWith(response);
      emit(TerminalUpdated(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(TerminalFailure(state));
    }
  }

  Future leave(UserScheme user) async {
    final workReport = state.workReport;
    if (workReport == null) return;
    if (state is TerminalUpdating || state is TerminalLoading) return;
    emit(TerminalUpdating(state));
    try {
      final now = DateTime.now();
      await client.createWorkReport(
        data: WorkReportScheme(
          employeeKey: user.refKey,
          terminalKey: workReport.terminalKey,
          exitType: "Чыгуу (Выход)",
          moment: 0,
          minute: now.minute.toString(),
          crossingDate: now,
          status: "",
          fio: user.description,
          updaterKey: workReport.updaterKey,
          placeKey: workReport.placeKey,
          passNumber: workReport.passNumber,
        ),
      );
      final newState = state.copyWith(undefined);
      emit(TerminalUpdated(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(TerminalFailure(state));
    }
  }
}
