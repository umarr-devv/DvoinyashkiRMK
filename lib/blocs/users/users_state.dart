part of 'users_cubit.dart';

@JsonSerializable()
class UsersState extends Equatable {
  const UsersState({this.users = const [], this.update});

  final List<UserScheme> users;
  final DateTime? update;

  UsersState copyWith({List<UserScheme>? users, DateTime? update}) {
    return UsersState(
      users: users ?? this.users,
      update: update ?? this.update,
    );
  }

  UsersState.from(UsersState other) : users = other.users, update = other.update;

  factory UsersState.fromJson(Map<String, dynamic> json) =>
      _$UsersStateFromJson(json);

  Map<String, dynamic> toJson() => _$UsersStateToJson(this);

  @override
  List<Object?> get props => [users, update];
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
