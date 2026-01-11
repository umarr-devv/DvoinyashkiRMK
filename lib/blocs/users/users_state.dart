part of 'users_cubit.dart';

@JsonSerializable()
class UsersState extends Equatable {
  const UsersState({this.users = const []});

  final List<UserScheme> users;

  UsersState copyWith(List<UserScheme>? users) {
    return UsersState(users: users ?? this.users);
  }

  UsersState.from(UsersState other) : users = other.users;

  factory UsersState.fromJson(Map<String, dynamic> json) =>
      _$UsersStateFromJson(json);

  Map<String, dynamic> toJson() => _$UsersStateToJson(this);

  @override
  List<Object?> get props => [users];
}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {
  UsersLoading(super.state) : super.from();
}

final class UsersLoaded extends UsersState {
  UsersLoaded(super.state) : super.from();
}

final class UsersFailure extends UsersState {
  UsersFailure(super.state) : super.from();
}