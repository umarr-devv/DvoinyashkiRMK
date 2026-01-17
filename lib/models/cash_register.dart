import 'package:json_annotation/json_annotation.dart';

part 'cash_register.g.dart';

@JsonSerializable()
class CashRegisterScheme {
  CashRegisterScheme({required this.refKey, required this.description});

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'ККТ Экран')
  final String description;

  factory CashRegisterScheme.fromJson(Map<String, dynamic> json) =>
      _$CashRegisterSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CashRegisterSchemeToJson(this);
}
