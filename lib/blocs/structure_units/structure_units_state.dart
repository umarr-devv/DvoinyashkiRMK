// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'structure_units_cubit.dart';

@JsonSerializable()
class StructureUnitsState extends Equatable {
  const StructureUnitsState({this.structureUnits = const [], this.update});

  final List<StructureUnitScheme> structureUnits;
  final DateTime? update;

  StructureUnitsState copyWith({
    List<StructureUnitScheme>? structureUnits,
    DateTime? update,
  }) {
    return StructureUnitsState(
      structureUnits: structureUnits ?? this.structureUnits,
      update: update ?? this.update,
    );
  }

  StructureUnitsState.from(StructureUnitsState other)
    : structureUnits = other.structureUnits,
      update = other.update;

  factory StructureUnitsState.fromJson(Map<String, dynamic> json) =>
      _$StructureUnitsStateFromJson(json);

  Map<String, dynamic> toJson() => _$StructureUnitsStateToJson(this);

  @override
  List<Object?> get props => [structureUnits, update];
}

final class StructureUnitsInitial extends StructureUnitsState {}

final class StructureUnitsLoading extends StructureUnitsState {
  StructureUnitsLoading(super.state) : super.from();
}

final class StructureUnitsLoaded extends StructureUnitsState {
  StructureUnitsLoaded(super.state) : super.from();
}

final class StructureUnitsFailure extends StructureUnitsState {
  StructureUnitsFailure(super.state) : super.from();
}
