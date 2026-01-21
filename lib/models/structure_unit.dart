import 'package:json_annotation/json_annotation.dart';

part 'structure_unit.g.dart';

@JsonSerializable()
class StructureUnitScheme {
  StructureUnitScheme({
    required this.refKey,
    required this.description,
    required this.udsUID,
    required this.code,
    required this.type,
    required this.subdivisionKey,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String description;

  @JsonKey(name: 'UDS_UID')
  final String udsUID;

  @JsonKey(name: 'Code')
  final String code;

  @JsonKey(name: 'Тип')
  final String type;

  @JsonKey(name: 'Подразделение_Key')
  final String subdivisionKey;

  factory StructureUnitScheme.fromJson(Map<String, dynamic> json) =>
      _$StructureUnitSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$StructureUnitSchemeToJson(this);
}

@JsonSerializable()
class StructureUnitListScheme {
  StructureUnitListScheme({required this.structureUnits});

  @JsonKey(name: 'value')
  final List<StructureUnitScheme> structureUnits;

  factory StructureUnitListScheme.fromJson(Map<String, dynamic> json) =>
      _$StructureUnitListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$StructureUnitListSchemeToJson(this);
}
