// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'structure_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StructureUnitScheme _$StructureUnitSchemeFromJson(Map<String, dynamic> json) =>
    StructureUnitScheme(
      refKey: json['Ref_Key'] as String,
      description: json['Description'] as String,
      udsUID: json['UDS_UID'] as String,
      code: json['Code'] as String,
      type: json['Тип'] as String,
      subdivisionKey: json['Подразделение_Key'] as String,
    );

Map<String, dynamic> _$StructureUnitSchemeToJson(
  StructureUnitScheme instance,
) => <String, dynamic>{
  'Ref_Key': instance.refKey,
  'Description': instance.description,
  'UDS_UID': instance.udsUID,
  'Code': instance.code,
  'Тип': instance.type,
  'Подразделение_Key': instance.subdivisionKey,
};

StructureUnitListScheme _$StructureUnitListSchemeFromJson(
  Map<String, dynamic> json,
) => StructureUnitListScheme(
  structureUnits: (json['value'] as List<dynamic>)
      .map((e) => StructureUnitScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StructureUnitListSchemeToJson(
  StructureUnitListScheme instance,
) => <String, dynamic>{'value': instance.structureUnits};
