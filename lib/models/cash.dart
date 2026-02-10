import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash.g.dart';

@JsonSerializable()
class CashScheme extends Equatable {
  const CashScheme({required this.value, required this.cashRegisterKey});

  @JsonKey(name: 'КассаККМ_Key')
  final String cashRegisterKey;

  @JsonKey(name: 'СуммаBalance')
  final double value;

  factory CashScheme.fromJson(Map<String, dynamic> json) =>
      _$CashSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CashSchemeToJson(this);

  @override
  List<Object?> get props => [cashRegisterKey];
}

@JsonSerializable()
class CashListScheme {
  const CashListScheme({required this.cashes});

  @JsonKey(name: 'value')
  final List<CashScheme> cashes;

  factory CashListScheme.fromJson(Map<String, dynamic> json) =>
      _$CashListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CashListSchemeToJson(this);
}
