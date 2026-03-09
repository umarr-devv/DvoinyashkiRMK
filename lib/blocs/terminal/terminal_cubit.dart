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
    emit(TerminalLoading(state));
    try {
      final response = await client.getWorkReportItem(
        fullPath: buildODataQuery({
          '\$top': '1',
          '\$orderby': 'Date',
          '\$format:': 'json',
          '\$filter':
              'Сотрудник_Key eq guid\'${user.refKey}\' and Posted eq false',
        }),
      );
      if (response.value.isNotEmpty) {
        final workReport = await client.getWorkReport(
          refKey: response.value[0].refKey,
        );
        final newState = state.copyWith(workReport);
        emit(TerminalLoaded(newState));
      } else {
        emit(TerminalLoaded(state));
      }
    } catch (exc, st) {
      talker.error(exc, st);
      emit(TerminalFailure(state));
    }
  }

  Future come(UserScheme user, AuthorScheme author) async {
    emit(TerminalUpdating(state));
    try {
      final response = await client.createWorkReport(
        data: WorkReportScheme(
          workedTime: [
            WorkedTimeScheme(
              lineNumber: '1',
              employeeKey: user.refKey,
              startTime: DateTime.now(),
              endTime: DateTime.now(),
              deduction: 0,
              inn: user.inn ?? '',
              warehouseKey: user.warehouseKey,
              positionKey: user.positionKey,
            ),
          ],
          employeeKey: user.refKey,
          responsibleKey: user.refKey,
          workplaceKey: user.warehouseKey,
          authorKey: author.refKey,
          isClosed: false,
          coefficient: 1,
          worked: "1",
          workShiftKey: '529de239-d16b-11ed-a8d6-18d6c704b66b',
          comment: 'из РМК',
          date: DateTime.now(),
          departmentKey: user.departmentKey,
          reportDate: DateTime.now(),
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
    if (workReport.refKey == null) return;
    emit(TerminalUpdating(state));
    try {
      await client.updateWorkReport(
        refKey: workReport.refKey!,
        data: UpdateWorkReportScheme(
          workedTime: [
            WorkedTimeScheme(
              lineNumber: "1",
              employeeKey: user.refKey,
              startTime: workReport.workedTime[0].startTime,
              endTime: DateTime.now(),
              deduction: 0,
              inn: user.inn ?? '',
              warehouseKey: user.warehouseKey,
              positionKey: user.positionKey,
            ),
          ],
        ),
      );
      await client.postWorkReport(refKey: workReport.refKey!);
      final newState = state.copyWith(undefined);
      emit(TerminalUpdated(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(TerminalFailure(state));
    }
  }
}
