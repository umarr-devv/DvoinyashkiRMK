import 'package:json_annotation/json_annotation.dart';

part 'create_withdraw.g.dart';

@JsonSerializable()
class CreateWithdrawScheme {
  CreateWithdrawScheme({
    required this.date,
    required this.comment,
    required this.cashRegisterKey,
    required this.authorKey,
    required this.subdivisionKey,
    required this.storeKey,
    required this.sessionKey,
    required this.documentSum,
    this.orgKey = '021f4fa6-3377-11ed-91a8-a068f8f3337c',
    this.currencyKey = '02e351c0-7e12-11ed-a847-18d6c704b66b',
  });

  @JsonKey(name: 'ВалютаДенежныхСредств_Key')
  final String currencyKey;

  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'Комментарий')
  final String? comment;

  @JsonKey(name: 'Организация_Key')
  final String orgKey;

  @JsonKey(name: 'КассаККМ_Key')
  final String cashRegisterKey;

  @JsonKey(name: 'Автор_Key')
  final String authorKey;

  @JsonKey(name: 'Подразделение_Key')
  final String subdivisionKey;

  @JsonKey(name: 'Магазин_Key')
  final String storeKey;

  @JsonKey(name: 'ОтчетОРозничныхПродажах_Key')
  final String sessionKey;

  @JsonKey(name: 'СуммаДокумента')
  final double documentSum;

  factory CreateWithdrawScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateWithdrawSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWithdrawSchemeToJson(this);
}
