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
          '\$orderby': 'Date desc',
          '\$format': 'json',
          '\$filter': 'Сотрудник_Key eq guid\'${user.refKey}\' and ',
        }),
      );
      if (response.value.isNotEmpty) {
        final workReport = await client.getWorkReport(
          refKey: response.value[0].refKey,
        );
        if (workReport.posted == false) {
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

  Future come(UserScheme user, AuthorScheme author) async {
    emit(TerminalUpdating(state));
    try {
      final now = DateTime.now();
      final nowTime = DateTime(1, 1, 1, now.hour, now.minute);
      final response = await client.createWorkReport(
        data: WorkReportScheme(
          workedTime: [
            WorkedTimeScheme(
              lineNumber: "1",
              employeeKey: user.refKey,
              startTime: nowTime,
              endTime: nowTime.add(Duration(seconds: 1)),
              deduction: 0,
              inn: user.inn ?? '',
              warehouseKey: user.warehouseKey ?? '',
              positionKey: user.positionKey ?? '',
            ),
          ],
          employeeKey: user.refKey,
          responsibleKey: user.refKey,
          workplaceKey: user.warehouseKey ?? '',
          authorKey: author.refKey,
          isClosed: false,
          coefficient: 1,
          worked: "1",
          workShiftKey: '529de239-d16b-11ed-a8d6-18d6c704b66b',
          comment: 'из РМК',
          date: now,
          departmentKey: user.departmentKey ?? '',
          reportDate: now,
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
      final now = DateTime.now();
      final nowTime = DateTime(1, 1, 1, now.hour, now.minute);
      await client.updateWorkReport(
        refKey: workReport.refKey!,
        data: UpdateWorkReportScheme(
          workedTime: [
            WorkedTimeScheme(
              lineNumber: "1",
              employeeKey: user.refKey,
              startTime: workReport.workedTime[0].startTime,
              endTime: nowTime,
              deduction: 0,
              inn: user.inn ?? '',
              warehouseKey: user.warehouseKey ?? '',
              positionKey: user.positionKey ?? '',
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
