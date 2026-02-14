// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_movement_cubit.dart';

class CreateMovementState {
  const CreateMovementState({
    this.items = const [],
    this.reserve,
    this.movementDate,
  });

  final StructureUnitScheme? reserve;
  final DateTime? movementDate;
  final List<CreateMovementItemData> items;

  double get totalSum => items.fold(0, (a, b) => a + b.totalSum);

  CreateMovementState copyWith({
    StructureUnitScheme? reserve,
    DateTime? movementDate,
    List<CreateMovementItemData>? items,
  }) {
    return CreateMovementState(
      reserve: reserve ?? this.reserve,
      movementDate: movementDate ?? this.movementDate,
      items: items ?? this.items,
    );
  }

  CreateMovementState.from(CreateMovementState other)
    : reserve = other.reserve,
      movementDate = other.movementDate,
      items = other.items;
}

final class CreateMovementInitial extends CreateMovementState {}

final class CreateMovementLoading extends CreateMovementState {
  CreateMovementLoading(super.state) : super.from();
}

final class CreateMovementUpdate extends CreateMovementState {
  CreateMovementUpdate(super.state) : super.from();
}

final class CreateMovementLoaded extends CreateMovementState {
  CreateMovementLoaded(super.state) : super.from();
}

final class CreateMovementFailure extends CreateMovementState {
  CreateMovementFailure(super.state) : super.from();
}
