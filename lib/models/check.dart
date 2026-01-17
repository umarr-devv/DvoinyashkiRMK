import 'package:json_annotation/json_annotation.dart';

part 'check.g.dart';

@JsonSerializable()
class CheckScheme {
  CheckScheme({
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
  final double change;

  @JsonKey(name: 'Статус')
  final String status;

  @JsonKey(name: 'СуммаВключаетНДС')
  final bool includeNDS;

  @JsonKey(name: 'СуммаДокумента')
  final double documentSum;

  @JsonKey(name: 'ФормаОплаты')
  final String paymentType;

  @JsonKey(name: 'Состав')
  final String itemsAsString;


  factory CheckScheme.fromJson(Map<String, dynamic> json) =>
      _$CheckSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CheckSchemeToJson(this);
}
