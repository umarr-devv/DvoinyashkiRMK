import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
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

  Future create() async {
    if (cashRegister == null ||
        author == null ||
        store == null ||
        subdivision == null ||
        user == null) {
      return;
    }
    emit(SessionLoading(state));

    try {
      final session = await client.createSession(
        data: CreateSessionScheme(
          date: DateTime.now(),
          cashRegisterKey: cashRegister!.refKey,
          start: DateTime.now(),
          end: DateTime.now().copyWith(hour: 23, minute: 59),
        ),
      );
      final workShift = await _getWorkShiftBySession(session.refKey);

      await client.patchWotkShift(
        refKey: workShift!.refKey,
        data: UpdateWorkShiftScheme(
          authorKey: author!.refKey,
          userKey: user!.refKey,
          subdivisionKey: subdivision!.refKey,
          storeKey: store!.refKey,
          status: null,
        ),
      );
      emit(SessionLoaded(state));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(SessionFailure(state));
    }
  }

  Future getCurrentWorkShift() async {
    emit(SessionLoading(state));
    try {
      final workShift = await _getWorkShiftByCashRegister();
      final newState = state.copyWith(workShift);
      emit(SessionLoaded(newState));
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
      '\$filter': 'КассоваяСмена_Key eq guid\'${cashRegister!.refKey}\'',
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
}
