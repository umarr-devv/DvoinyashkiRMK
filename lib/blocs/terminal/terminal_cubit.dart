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
      final now = DateTime.now();
      final startDate = to1CODataDateTime(
        DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(const Duration(days: 3)),
      );
      final endDate = to1CODataDateTime(
        DateTime(now.year, now.month, now.day, 23, 59, 59),
      );

      final response = await client.getWorkReportItem(
        fullPath: buildODataQuery({
          '\$top': '1',
          '\$orderby': 'Date desc',
          '\$format': 'json',
          '\$filter':
              'Сотрудник_Key eq guid\'${user.refKey}\' and Date ge $startDate and Date le $endDate',
        }),
      );
      if (response.value.isNotEmpty) {
        final workReport = response.value[0];
        if (DateTime(1).difference(workReport.endWork).abs() <
            Duration(seconds: 1)) {
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
    if (state is TerminalUpdating || state is TerminalLoading) return;
    emit(TerminalUpdating(state));
    try {
      final now = DateTime.now();
      final nowTime = DateTime(1, 1, 1, now.hour, now.minute);
      final response = await client.createWorkReport(
        data: WorkReportScheme(
          date: now,
          userKey: user.refKey,
          startWork: nowTime,
          endWork: DateTime(1),
          inn: user.inn ?? '',
          roleKey: user.positionKey,
          continueWork: 0,
          totalWork: 0,
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
    if (state is TerminalUpdating || state is TerminalLoading) return;
    emit(TerminalUpdating(state));
    try {
      final now = DateTime.now();
      final nowTime = DateTime(1, 1, 1, now.hour, now.minute);
      final continueWork =
          nowTime.difference(workReport.startWork).inMinutes.abs() / 60.0;
      await client.updateWorkReport(
        refKey: workReport.refKey!,
        data: UpdateWorkReportScheme(
          endWork: nowTime,
          continueWork: continueWork,
          totalWork: continueWork,
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
