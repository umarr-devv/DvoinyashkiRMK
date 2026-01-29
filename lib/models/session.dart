import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class SessionScheme {
  SessionScheme({
    required this.refKey,
    required this.number,
    required this.posted,
    required this.cashRegisterKey,
    required this.start,
    required this.end,
    required this.status,
  });
  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Number')
  final String number;

  @JsonKey(name: 'Posted')
  final bool posted;

  @JsonKey(name: 'КассаККМ_Key')
  final String cashRegisterKey;

  @JsonKey(name: 'НачалоКассовойСмены')
  final DateTime start;

  @JsonKey(name: 'ОкончаниеКассовойСмены')
  final DateTime? end;

  @JsonKey(name: 'Статус')
  final String? status;

  factory SessionScheme.fromJson(Map<String, dynamic> json) =>
      _$SessionSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$SessionSchemeToJson(this);
}

@JsonSerializable()
class SessionListScheme {
  SessionListScheme({required this.sessions});

  @JsonKey(name: 'value')
  final List<SessionScheme> sessions;

  factory SessionListScheme.fromJson(Map<String, dynamic> json) =>
      _$SessionListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$SessionListSchemeToJson(this);
}
