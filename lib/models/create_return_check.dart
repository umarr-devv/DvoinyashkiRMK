import 'package:json_annotation/json_annotation.dart';

part 'create_return_check.g.dart';

@JsonSerializable()
class CreateReturnCheckScheme {
  CreateReturnCheckScheme({
    required this.date,
    required this.authorKey,
    required this.checkKey,
    required this.cashRegisterKey,
    required this.sessionKey,
    required this.subdivisionKey,
    required this.storeKey,
    required this.totalSum,
    required this.items,
    required this.userKey,
    required this.cashPayment,
    this.movementDelete = true,
    this.includeNds = true,
    this.sessionNumber = 1,
    this.priceKey = '021f4fa7-3377-11ed-91a8-a068f8f3337c'
  });

  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'Автор_Key')
  final String authorKey;

  @JsonKey(name: 'ЧекККМ_Key')
  final String? checkKey;

  @JsonKey(name: 'КассаККМ_Key')
  final String cashRegisterKey;

  @JsonKey(name: 'КассоваяСмена_Key')
  final String sessionKey;

  @JsonKey(name: 'Подразделение_Key')
  final String subdivisionKey;

  @JsonKey(name: 'СтруктурнаяЕдиница_Key')
  final String storeKey;

  @JsonKey(name: 'Ответственный_Key')
  final String userKey;

  @JsonKey(name: 'СуммаДокумента')
  final double totalSum;

  @JsonKey(name: 'Запасы')
  final List<CreateReturnCheckItemScheme> items;

  @JsonKey(name: 'ДвиженияПоЗапасамУдалять')
  final bool movementDelete;

  @JsonKey(name: 'НДСВключатьВСтоимость')
  final bool includeNds;

  @JsonKey(name: 'НомерСменыККМ')
  final int sessionNumber;

  @JsonKey(name: 'ПолученоНаличными')
  final double cashPayment;

  @JsonKey(name: 'ВидЦен_Key')
  final String priceKey;

  factory CreateReturnCheckScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateReturnCheckSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateReturnCheckSchemeToJson(this);
}

@JsonSerializable()
class CreateReturnCheckItemScheme {
  CreateReturnCheckItemScheme({
    required this.lineNumber,
    required this.key,
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.quantity,
    required this.price,
    required this.totalSum,
    required this.allSum,
    required this.unitKey,
    this.ndsKey = '436b4216-3377-11ed-91a8-a068f8f3337c',
    this.unitType = 'StandardODATA.Catalog_КлассификаторЕдиницИзмерения',
  });

  @JsonKey(name: 'LineNumber')
  final int lineNumber;

  @JsonKey(name: 'КлючСвязи')
  final int key;

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String? characteristicKey;

  @JsonKey(name: 'Количество')
  final double quantity;

  @JsonKey(name: 'Цена')
  final double price;

  @JsonKey(name: 'Сумма')
  final double totalSum;

  @JsonKey(name: 'Всего')
  final double allSum;

  @JsonKey(name: 'СтавкаНДС_Key')
  final String ndsKey;

  @JsonKey(name: 'ЕдиницаИзмерения')
  final String? unitKey;

  @JsonKey(name: 'ЕдиницаИзмерения_Type')
  final String unitType;

  factory CreateReturnCheckItemScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateReturnCheckItemSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateReturnCheckItemSchemeToJson(this);
}
