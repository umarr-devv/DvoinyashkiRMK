import 'package:json_annotation/json_annotation.dart';

part 'create_production.g.dart';

@JsonSerializable()
class CreateProductionItemScheme {
  CreateProductionItemScheme({
    required this.lineNumber,
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.quantity,
    required this.unitKey,
    this.unitType = 'StandardODATA.Catalog_КлассификаторЕдиницИзмерения',
    required this.key,
    required this.specificationKey,
  });

  @JsonKey(name: 'LineNumber')
  final String lineNumber;

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String? characteristicKey;

  @JsonKey(name: 'Количество')
  final double quantity;

  @JsonKey(name: 'ЕдиницаИзмерения')
  final String unitKey;

  @JsonKey(name: 'ЕдиницаИзмерения_Type')
  final String unitType;

  @JsonKey(name: 'КлючСвязи')
  final String key;

  @JsonKey(name: 'Спецификация_Key')
  final String specificationKey;

  factory CreateProductionItemScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateProductionItemSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductionItemSchemeToJson(this);
}

@JsonSerializable()
class CreateProductionResourceScheme {
  CreateProductionResourceScheme({
    required this.lineNumber,
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.quantity,
    required this.unitKey,
    this.unitType = 'StandardODATA.Catalog_КлассификаторЕдиницИзмерения',
    required this.key,
  });

  @JsonKey(name: 'LineNumber')
  final String lineNumber;

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String? characteristicKey;

  @JsonKey(name: 'Количество')
  final double quantity;

  @JsonKey(name: 'ЕдиницаИзмерения')
  final String unitKey;

  @JsonKey(name: 'ЕдиницаИзмерения_Type')
  final String unitType;

  @JsonKey(name: 'КлючСвязи')
  final String key;

  factory CreateProductionResourceScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateProductionResourceSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductionResourceSchemeToJson(this);
}

@JsonSerializable()
class CreateProductionScheme {
  CreateProductionScheme({
    required this.date,
    this.orgKey = '021f4fa6-3377-11ed-91a8-a068f8f3337c',
    required this.structureUnitKey,
    required this.fromStructureUnitKey,
    required this.toStructureUnitKey,
    this.operationKey = '43f6fc87-4a0d-11ed-a839-18d6c704b66b',
    this.operationType = 'Сборка',
    required this.items,
    required this.resources,
  });

  @JsonKey(name: 'Date')
  final DateTime? date;

  @JsonKey(name: 'Организация_Key')
  final String orgKey;

  @JsonKey(name: 'СтруктурнаяЕдиница_Key')
  final String structureUnitKey;

  @JsonKey(name: 'СтруктурнаяЕдиницаЗапасов_Key')
  final String fromStructureUnitKey;

  @JsonKey(name: 'СтруктурнаяЕдиницаПродукции_Key')
  final String toStructureUnitKey;

  @JsonKey(name: 'ХозяйственнаяОперация_Key')
  final String operationKey;

  @JsonKey(name: 'ВидОперации')
  final String operationType;

  @JsonKey(name: 'Продукция')
  final List<CreateProductionItemScheme> items;

  @JsonKey(name: 'Запасы')
  final List<CreateProductionResourceScheme> resources;

  factory CreateProductionScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateProductionSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductionSchemeToJson(this);
}
