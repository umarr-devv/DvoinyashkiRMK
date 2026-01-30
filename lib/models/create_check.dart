import 'package:json_annotation/json_annotation.dart';

part 'create_check.g.dart';

@JsonSerializable(includeIfNull: true)
class CreateCheckScheme {
  CreateCheckScheme({
    required this.date,
    required this.authorKey,
    this.currencyKey = '02e351c0-7e12-11ed-a847-18d6c704b66b',
    this.priceTypeKey = '021f4fa7-3377-11ed-91a8-a068f8f3337c',
    this.orgKey = '021f4fa6-3377-11ed-91a8-a068f8f3337c',
    this.operationKey = '43f6fc97-4a0d-11ed-a839-18d6c704b66b',
    this.posted = false,
    required this.cashRegisterKey,
    required this.userKey,
    required this.sessionKey,
    required this.sessionNumber,
    required this.udsCustomer,
    required this.udsDiscountCode,
    required this.udsDiscount,
    required this.comment,
    required this.responsibleKey,
    required this.subdivisionKey,
    required this.customer,
    required this.employeersDebtKey,
    required this.cash,
    required this.getCash,
    required this.getCashless,
    required this.cashless,
    required this.udsPayment,
    required this.paymentForm,
    required this.change,
    required this.storeKey,
    required this.items,
  });
  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'Posted')
  final bool posted;

  @JsonKey(name: 'Автор_Key')
  final String authorKey;

  @JsonKey(name: 'ВалютаДокумента_Key')
  final String currencyKey;

  @JsonKey(name: 'ВидЦен_Key')
  final String priceTypeKey;

  @JsonKey(name: 'КассаККМ_Key')
  final String cashRegisterKey;

  @JsonKey(name: 'Кассир_Key')
  final String userKey;

  @JsonKey(name: 'КассоваяСмена_Key')
  final String sessionKey;

  @JsonKey(name: 'НомерСменыККМ')
  final int sessionNumber;

  @JsonKey(name: 'КлиентUDS')
  final String? udsCustomer;

  @JsonKey(name: 'КодСкидкиUDS')
  final String? udsDiscountCode;

  @JsonKey(name: 'СкидкаUDS')
  final double? udsDiscount;

  @JsonKey(name: 'Комментарий')
  final String? comment;

  @JsonKey(name: 'Организация_Key')
  final String orgKey;

  @JsonKey(name: 'Ответственный_Key')
  final String responsibleKey;

  @JsonKey(name: 'Подразделение_Key')
  final String subdivisionKey;

  @JsonKey(name: 'Покупатель')
  final String? customer;

  @JsonKey(name: 'СотрудникДолг_Key')
  final String? employeersDebtKey;

  @JsonKey(name: 'Долг')
  final double debt = 0;

  @JsonKey(name: 'Наличные')
  final double cash;

  @JsonKey(name: 'ПолученоНаличными')
  final double getCash;

  @JsonKey(name: 'ПолученоЭлектронно')
  final double getCashless;

  @JsonKey(name: 'СуммаБезналичнойОплаты')
  final double cashless;

  @JsonKey(name: 'СуммаОплатUDS')
  final double? udsPayment;

  @JsonKey(name: 'ФормаОплаты')
  final String paymentForm;

  @JsonKey(name: 'Сдача')
  final double change;

  @JsonKey(name: 'Статус')
  final String status = 'Пробит';

  @JsonKey(name: 'СтруктурнаяЕдиница_Key')
  final String storeKey;

  @JsonKey(name: 'ХозяйственнаяОперация_Key')
  final String operationKey;

  @JsonKey(name: 'Запасы')
  final List<CreateCheckItemScheme> items;

  factory CreateCheckScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateCheckSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCheckSchemeToJson(this);
}

@JsonSerializable()
class CreateCheckItemScheme {
  CreateCheckItemScheme({
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

  factory CreateCheckItemScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateCheckItemSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCheckItemSchemeToJson(this);
}
