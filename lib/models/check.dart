import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check.g.dart';

@JsonSerializable()
class CheckScheme extends Equatable {
  const CheckScheme({
    required this.refKey,
    required this.number,
    required this.date,
    required this.cashRegisterKey,
    required this.userKey,
    required this.cashRegisterSessionKey,
    required this.udsClient,
    required this.udsDiscountCode,
    required this.udsDiscount,
    required this.udsSumPayment,
    required this.cash,
    required this.userInn,
    required this.shop,
    required this.cashPayment,
    required this.cashlessPayment,
    required this.change,
    required this.status,
    required this.includeNDS,
    required this.documentSum,
    required this.paymentType,
    required this.itemsAsString,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Number')
  final String number;

  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'КассаККМ_Key')
  final String cashRegisterKey;

  @JsonKey(name: 'Кассир_Key')
  final String userKey;

  @JsonKey(name: 'КассоваяСмена_Key')
  final String cashRegisterSessionKey;

  @JsonKey(name: 'КлиентUDS')
  final String udsClient;

  @JsonKey(name: 'КодСкидкиUDS')
  final String udsDiscountCode;

  @JsonKey(name: 'СкидкаUDS')
  final String udsDiscount;

  @JsonKey(name: 'СуммаОплатUDS')
  final String udsSumPayment;

  @JsonKey(name: 'Наличные')
  final double cash;

  @JsonKey(name: 'ОбменИННКассира')
  final String userInn;

  @JsonKey(name: 'ОбменМагазин')
  final String shop;

  @JsonKey(name: 'ПолученоНаличными')
  final double cashPayment;

  @JsonKey(name: 'ПолученоЭлектронно')
  final double cashlessPayment;

  @JsonKey(name: 'Сдача')
  final dynamic change;

  @JsonKey(name: 'Статус')
  final String status;

  @JsonKey(name: 'СуммаВключаетНДС')
  final bool includeNDS;

  @JsonKey(name: 'СуммаДокумента')
  final double documentSum;

  @JsonKey(name: 'ФормаОплаты')
  final String paymentType;

  @JsonKey(name: 'Состав')
  final String? itemsAsString;

  static String get cashPaymentType => 'Наличные';
  static String get cashlessPaymentType => 'Безналичные';

  factory CheckScheme.fromJson(Map<String, dynamic> json) =>
      _$CheckSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CheckSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class CheckItemScheme {
  CheckItemScheme({
    required this.nomenclatureKey,
    required this.characteriticKey,
    required this.quantity,
    required this.price,
    required this.itemSum,
  });

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String? characteriticKey;

  @JsonKey(name: 'Количество')
  final double quantity;

  @JsonKey(name: 'Цена')
  final double price;

  @JsonKey(name: 'Сумма')
  final double itemSum;

  factory CheckItemScheme.fromJson(Map<String, dynamic> json) =>
      _$CheckItemSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CheckItemSchemeToJson(this);
}

@JsonSerializable()
class DetailCheckScheme extends CheckScheme {
  const DetailCheckScheme({
    required this.items,
    required super.refKey,
    required super.number,
    required super.date,
    required super.cashRegisterKey,
    required super.userKey,
    required super.cashRegisterSessionKey,
    required super.udsClient,
    required super.udsDiscountCode,
    required super.udsDiscount,
    required super.udsSumPayment,
    required super.cash,
    required super.userInn,
    required super.shop,
    required super.cashPayment,
    required super.cashlessPayment,
    required super.change,
    required super.status,
    required super.includeNDS,
    required super.documentSum,
    required super.paymentType,
    required super.itemsAsString,
  });

  @JsonKey(name: 'Запасы')
  final List<CheckItemScheme> items;

  factory DetailCheckScheme.fromJson(Map<String, dynamic> json) =>
      _$DetailCheckSchemeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DetailCheckSchemeToJson(this);
}

@JsonSerializable()
class CheckListScheme {
  CheckListScheme({required this.checks});

  @JsonKey(name: 'value')
  final List<CheckScheme> checks;

  factory CheckListScheme.fromJson(Map<String, dynamic> json) =>
      _$CheckListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CheckListSchemeToJson(this);
}

@JsonSerializable()
class OnlyCheckItemsScheme {
  OnlyCheckItemsScheme({required this.items});

  @JsonKey(name: 'Запасы')
  final List<CheckItemScheme> items;

  factory OnlyCheckItemsScheme.fromJson(Map<String, dynamic> json) =>
      _$OnlyCheckItemsSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$OnlyCheckItemsSchemeToJson(this);
}
