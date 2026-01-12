import 'package:json_annotation/json_annotation.dart';

part 'nomenclature.g.dart';

@JsonSerializable()
class NomenclatureScheme {
  NomenclatureScheme({
    required this.refKey,
    required this.description,
    required this.name,
    required this.categoryKey,
    required this.useCharacteristic,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String? description;

  @JsonKey(name: 'НаименованиеПолное')
  final String? name;

  @JsonKey(name: 'КатегорияНоменклатуры_Key')
  final String? categoryKey;

  @JsonKey(name: 'ИспользоватьХарактеристики')
  final bool? useCharacteristic;

  factory NomenclatureScheme.fromJson(Map<String, dynamic> json) =>
      _$NomenclatureSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$NomenclatureSchemeToJson(this);
}

@JsonSerializable()
class NomenclatureListScheme {
  NomenclatureListScheme({required this.nomenclatures});

  @JsonKey(name: 'value')
  final List<NomenclatureScheme> nomenclatures;

  factory NomenclatureListScheme.fromJson(Map<String, dynamic> json) =>
      _$NomenclatureListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$NomenclatureListSchemeToJson(this);
}
