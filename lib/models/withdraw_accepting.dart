import 'package:json_annotation/json_annotation.dart';

part 'withdraw_accepting.g.dart';

@JsonSerializable()
class WithdrawAcceptScheme {
  WithdrawAcceptScheme({required this.refKey, required this.posted, required this.withdrawKey});

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Posted')
  final bool? posted;

  @JsonKey(name: 'ДокументОснование')
  final String? withdrawKey;

  factory WithdrawAcceptScheme.fromJson(Map<String, dynamic> json) =>
      _$WithdrawAcceptSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawAcceptSchemeToJson(this);
}

@JsonSerializable()
class WithdrawAcceptListScheme {
  WithdrawAcceptListScheme({required this.value});

  @JsonKey(name: 'value')
  final List<WithdrawAcceptScheme> value;

  factory WithdrawAcceptListScheme.fromJson(Map<String, dynamic> json) =>
      _$WithdrawAcceptListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawAcceptListSchemeToJson(this);
}
