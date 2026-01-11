import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'users_cubit.g.dart';
part 'users_state.dart';

class UsersCubit extends HydratedCubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future update() async {
    await forceUpdate();
  }

  Future forceUpdate() async {
    emit(UsersLoading(state));
    try {
      final response = await client.getUsers();
      final newState = state.copyWith(response.users);
      emit(UsersLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(UsersFailure(state));
    }
  }

  @override
  UsersState? fromJson(Map<String, dynamic> json) {
    return UsersState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UsersState state) {
    return state.toJson();
  }
}
