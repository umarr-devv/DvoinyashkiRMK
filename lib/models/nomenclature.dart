import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nomenclature.g.dart';

@JsonSerializable()
class NomenclatureScheme extends Equatable {
  const NomenclatureScheme({
    required this.refKey,
    required this.description,
    required this.name,
    required this.categoryKey,
    required this.groupKey,
    required this.unitKey,
    required this.useCharacteristic,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String? description;

  @JsonKey(name: 'НаименованиеПолное')
  final String? name;

  @JsonKey(name: 'Parent_Key')
  final String? groupKey;

  @JsonKey(name: 'КатегорияНоменклатуры_Key')
  final String? categoryKey;

  @JsonKey(name: 'ЕдиницаИзмерения_Key')
  final String? unitKey;

  @JsonKey(name: 'ИспользоватьХарактеристики')
  final bool? useCharacteristic;

  factory NomenclatureScheme.fromJson(Map<String, dynamic> json) =>
      _$NomenclatureSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$NomenclatureSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class NomenclatureListScheme {
  NomenclatureListScheme({required this.value});

  @JsonKey(name: 'value')
  final List<NomenclatureScheme> value;

  factory NomenclatureListScheme.fromJson(Map<String, dynamic> json) =>
      _$NomenclatureListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$NomenclatureListSchemeToJson(this);
}
