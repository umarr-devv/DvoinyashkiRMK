import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'session_cubit.g.dart';
part 'session_state.dart';

class SessionCubit extends HydratedCubit<SessionState> {
  SessionCubit(this.settingsCubit, this.authCubit) : super(SessionInitial());

  final SettingsCubit settingsCubit;
  final AuthCubit authCubit;

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  CashRegisterScheme? get cashRegister => settingsCubit.state.cashRegister;
  AuthorScheme? get author => settingsCubit.state.author;
  StructureUnitScheme? get store => settingsCubit.state.store;
  StructureUnitScheme? get subdivision => settingsCubit.state.subdivision;
  UserScheme? get user => authCubit.state.user;

  Future start() async {
    if (cashRegister == null ||
        author == null ||
        store == null ||
        subdivision == null ||
        user == null) {
      return;
    }
    if (state is SessionLoading) return;
    emit(SessionLoading(state));

    try {
      final session = await client.createSession(
        data: CreateSessionScheme(
          date: DateTime.now(),
          cashRegisterKey: cashRegister!.refKey,
          start: DateTime.now(),
          end: DateTime.now().copyWith(hour: 23, minute: 59),
          status: CreateSessionScheme.openStatus,
        ),
      );
      await client.postSession(refKey: session.refKey);
      final workShift = await _getWorkShiftBySession(session.refKey);

      await client.patchWorkShift(
        refKey: workShift!.refKey,
        data: UpdateWorkShiftScheme(
          authorKey: author!.refKey,
          userKey: user!.refKey,
          subdivisionKey: subdivision!.refKey,
          storeKey: store!.refKey,
          status: null,
        ),
      );
      await getCurrentWorkShift(force: true);
      emit(SessionStarted(state));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(SessionFailure(state));
    }
  }

  Future end() async {
    if (state.currentWorkShift == null) return;
    if (state is SessionLoading) return;
    emit(SessionLoading(state));
    try {
      DateTime? endDate;
      if (state.currentWorkShift!.workShiftEnd?.isAfter(DateTime.now()) ??
          false) {
        endDate = DateTime.now();
      }
      await client.patchWorkShift(
        refKey: state.currentWorkShift!.refKey,
        data: UpdateWorkShiftScheme(
          status: WorkShiftScheme.closeStatus,
          workShiftEnd: endDate,
        ),
      );
      await client.postWorkShift(refKey: state.currentWorkShift!.refKey);
      emit(SessionEnded(state));
      final newState = state.copyWith(undefined);
      emit(SessionLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(SessionFailure(state));
    }
  }

  Future getCurrentWorkShift({bool force = false}) async {
    if (!force && state is SessionLoading) return;
    emit(SessionLoading(state));
    try {
      final workShift = await _getWorkShiftByCashRegister();
      if (workShift != null && workShift.status == WorkShiftScheme.openStatus) {
        final newState = state.copyWith(workShift);
        emit(SessionLoaded(newState));
      } else {
        final newState = state.copyWith(undefined);
        emit(SessionLoaded(newState));
      }
    } catch (exc, st) {
      talker.error(exc, st);
      emit(SessionFailure(state));
    }
  }

  Future<WorkShiftScheme?> _getWorkShiftBySession(String sessionRefKey) async {
    final Map<String, dynamic> params = {
      '\$top': '1',
      '\$filter': 'КассоваяСмена_Key eq guid\'$sessionRefKey\'',
      '\$orderby': 'Date desc',
      '\$format': 'json',
    };
    final response = await client.getWorkShifts(
      fullPath: buildODataQuery(params),
    );
    if (response.workShifts.isNotEmpty) {
      return response.workShifts[0];
    } else {
      return null;
    }
  }

  Future<WorkShiftScheme?> _getWorkShiftByCashRegister() async {
    if (cashRegister == null) return null;
    final Map<String, dynamic> params = {
      '\$top': '1',
      '\$filter': 'КассаККМ_Key eq guid\'${cashRegister!.refKey}\'',
      '\$orderby': 'Date desc',
      '\$format': 'json',
    };
    final response = await client.getWorkShifts(
      fullPath: buildODataQuery(params),
    );
    if (response.workShifts.isNotEmpty) {
      final workShift = response.workShifts[0];
      if (workShift.status == WorkShiftScheme.openStatus) {
        return response.workShifts[0];
      }
    }
    return null;
  }

  @override
  SessionState? fromJson(Map<String, dynamic> json) {
    return SessionState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SessionState state) {
    return state.toJson();
  }
}
