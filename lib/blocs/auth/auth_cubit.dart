import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/undefined.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'auth_cubit.g.dart';
part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  final String adminPassword = 'secret';

  Future login({required UserScheme user, required String password}) async {
    emit(AuthLoading(state));

    if (user.barcode != password && adminPassword != password) {
      emit(AuthInvalidPassword(state));
      return;
    }

    try {
      final response = await client.getUser(refKey: user.refKey);

      final List<DetailUserScheme> lastUsers = List.from(state.lastUsers);

      final lastUser = lastUsers.firstWhereLogTypeOrNull(
        (i) => i.refKey == response.refKey,
      );
      if (lastUser != null) {
        lastUsers.remove(lastUser);
      }
      lastUsers.insert(0, response);

      final newState = state.copyWith(
        user: response,
        lastUsers: lastUsers.take(10).toList(),
      );
      emit(AuthLoggedIn(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(AuthFailure(state));
    }
  }

  Future logout() async {
    final newState = state.copyWith(user: undefined);
    emit(AuthLoggedOut(newState));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
