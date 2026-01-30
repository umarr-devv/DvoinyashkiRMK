part of 'session_cubit.dart';

class SessionState extends Equatable {
  const SessionState({this.currentWorkShift});

  final WorkShiftScheme? currentWorkShift;

  SessionState copyWith(Object? currentWorkShift) {
    return SessionState(
      currentWorkShift: undefCompare<WorkShiftScheme>(
        currentWorkShift,
        this.currentWorkShift,
      ),
    );
  }

  SessionState.from(SessionState other)
    : currentWorkShift = other.currentWorkShift;

  @override
  List<Object?> get props => [currentWorkShift];
}

final class SessionInitial extends SessionState {}

final class SessionLoading extends SessionState {
  SessionLoading(super.state) : super.from();
}

final class SessionLoaded extends SessionState {
  SessionLoaded(super.state) : super.from();
}

final class SessionFailure extends SessionState {
  SessionFailure(super.state) : super.from();
}
