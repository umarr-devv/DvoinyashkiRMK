import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'withdraw.g.dart';

@JsonSerializable()
class WithdrawScheme extends Equatable {
  const WithdrawScheme({
    required this.refKey,
    required this.number,
    required this.date,
    required this.posted,
    required this.cashRegisyerKey,
    required this.commentary,
    required this.documentSum,
    required this.storeKey,
    required this.subdivisionKey,
    required this.sessionKey,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Number')
  final String number;

  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'Posted')
  final bool posted;

  @JsonKey(name: 'КассаККМ_Key')
  final String cashRegisyerKey;

  @JsonKey(name: 'Комментарий')
  final String commentary;

  @JsonKey(name: 'СуммаДокумента')
  final double documentSum;

  @JsonKey(name: 'Магазин_Key')
  final String storeKey;

  @JsonKey(name: 'Подразделение_Key')
  final String subdivisionKey;

  @JsonKey(name: 'ОтчетОРозничныхПродажах_Key')
  final String sessionKey;

  factory WithdrawScheme.fromJson(Map<String, dynamic> json) =>
      _$WithdrawSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class WithdrawListScheme {
  WithdrawListScheme({required this.withdraws});

  @JsonKey(name: 'value')
  final List<WithdrawScheme> withdraws;

  factory WithdrawListScheme.fromJson(Map<String, dynamic> json) =>
      _$WithdrawListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawListSchemeToJson(this);
}
