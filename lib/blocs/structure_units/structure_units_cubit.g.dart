// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'structure_units_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StructureUnitsState _$StructureUnitsStateFromJson(Map<String, dynamic> json) =>
    StructureUnitsState(
      structureUnits:
          (json['structure_units'] as List<dynamic>?)
              ?.map(
                (e) => StructureUnitScheme.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      update: json['update'] == null
          ? null
          : DateTime.parse(json['update'] as String),
    );

Map<String, dynamic> _$StructureUnitsStateToJson(
  StructureUnitsState instance,
) => <String, dynamic>{
  'structure_units': instance.structureUnits,
  'update': instance.update?.toIso8601String(),
};
