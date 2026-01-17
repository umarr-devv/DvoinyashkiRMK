import 'package:json_annotation/json_annotation.dart';

part 'cash_register.g.dart';

@JsonSerializable()
class CashRegisterScheme {
  CashRegisterScheme({required this.refKey, required this.description});

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String description;

  factory CashRegisterScheme.fromJson(Map<String, dynamic> json) =>
      _$CashRegisterSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CashRegisterSchemeToJson(this);
}

@JsonSerializable()
class CashRegisterListScheme {
  CashRegisterListScheme({required this.cashRegisters});

  @JsonKey(name: 'value')
  final List<CashRegisterScheme> cashRegisters;

  factory CashRegisterListScheme.fromJson(Map<String, dynamic> json) =>
      _$CashRegisterListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CashRegisterListSchemeToJson(this);
}
