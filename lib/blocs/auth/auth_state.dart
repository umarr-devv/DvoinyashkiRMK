part of 'auth_cubit.dart';

@JsonSerializable()
class AuthState extends Equatable {
  const AuthState({this.user, this.lastUsers = const []});

  final DetailUserScheme? user;
  final List<DetailUserScheme> lastUsers;

  AuthState copyWith({
    Object? user,
    List<DetailUserScheme>? lastUsers,
  }) {
    return AuthState(
      user: undefCompare<DetailUserScheme>(user, this.user),
      lastUsers: lastUsers ?? this.lastUsers,
    );
  }

  AuthState.from(AuthState other)
    : user = other.user,
      lastUsers = other.lastUsers;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);

  @override
  List<Object?> get props => [user, lastUsers];
}

final class AuthInitial extends AuthState {
}

final class AuthInvalidPassword extends AuthState {
  AuthInvalidPassword(super.state) : super.from();
}

final class AuthLoading extends AuthState {
  AuthLoading(super.state) : super.from();
}

final class AuthLoggedIn extends AuthState {
  AuthLoggedIn(super.state) : super.from();
}

final class AuthLoggedOut extends AuthState {
  AuthLoggedOut(super.state) : super.from();
}

final class AuthFailure extends AuthState {
  AuthFailure(super.state) : super.from();
}
