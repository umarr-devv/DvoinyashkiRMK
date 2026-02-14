import 'package:json_annotation/json_annotation.dart';

part 'create_movement.g.dart';

@JsonSerializable()
class CreateMovementScheme {
  CreateMovementScheme({
    required this.date,
    required this.authorKey,
    required this.userKey,
    this.statusKey = 'e1299b34-8553-11ee-a94d-f02f741f28ff',
    required this.reserveStructureUnitKey,
    this.operationKey = '4079c82a-4a0d-11ed-a839-18d6c704b66b',
    required this.storeKey,
    required this.movementDate,
    required this.items,
    required this.orderSum,
    required this.documentSum
  });
  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'Автор_Key')
  final String authorKey;

  @JsonKey(name: 'Ответственный_Key')
  final String userKey;

  @JsonKey(name: 'СостояниеЗаказа_Key')
  final String statusKey;

  @JsonKey(name: 'СтруктурнаяЕдиницаРезерв_Key')
  final String? reserveStructureUnitKey;

  @JsonKey(name: 'ХозяйственнаяОперация_Key')
  final String operationKey;

  @JsonKey(name: 'СтруктурнаяЕдиницаПолучатель_Key')
  final String storeKey;

  @JsonKey(name: 'ДатаПеремещения')
  final DateTime movementDate;

  @JsonKey(name: 'СуммаЗаказа')
  final double orderSum;

    @JsonKey(name: 'СуммаДокумента')
  final double documentSum;


  @JsonKey(name: 'Запасы')
  final List<CreateMovementItemScheme> items;

  factory CreateMovementScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateMovementSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMovementSchemeToJson(this);
}

@JsonSerializable()
class CreateMovementItemScheme {
  CreateMovementItemScheme({
    required this.lineNumber,
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.unitKey,
    required this.quantity,
    this.unitType = "StandardODATA.Catalog_КлассификаторЕдиницИзмерения",
    required this.price,
    required this.totalSum,
  });

  @JsonKey(name: 'LineNumber')
  final int lineNumber;

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String? characteristicKey;

  @JsonKey(name: 'ЕдиницаИзмерения_Type')
  final String unitType;

  @JsonKey(name: 'ЕдиницаИзмерения')
  final String? unitKey;

  @JsonKey(name: 'Количество')
  final double quantity;

  @JsonKey(name: 'Цена')
  final double price;

  @JsonKey(name: 'Сумма')
  final double totalSum;

  factory CreateMovementItemScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateMovementItemSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMovementItemSchemeToJson(this);
}
