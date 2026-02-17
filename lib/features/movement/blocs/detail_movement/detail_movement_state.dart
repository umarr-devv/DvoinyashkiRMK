part of 'detail_movement_cubit.dart';

class DetailMovementState extends Equatable {
  const DetailMovementState({this.movement});
  final DetailMovementScheme? movement;

  DetailMovementState copyWith(DetailMovementScheme? movement) {
    return DetailMovementState(movement: movement);
  }

  DetailMovementState.from(DetailMovementState other)
    : movement = other.movement;

  @override
  List<Object?> get props => [movement];
}

final class DetailMovementInitial extends DetailMovementState {}

final class DetailMovementLoading extends DetailMovementState {
  DetailMovementLoading(super.state) : super.from();
}

final class DetailMovementLoaded extends DetailMovementState {
  DetailMovementLoaded(super.state) : super.from();
}

final class DetailMovementFailure extends DetailMovementState {
  DetailMovementFailure(super.state) : super.from();
}
