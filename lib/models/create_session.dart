import 'package:json_annotation/json_annotation.dart';

part 'create_session.g.dart';

@JsonSerializable()
class CreateSessionScheme {
  CreateSessionScheme({
    required this.date,
    required this.cashRegisterKey,
    required this.start,
    required this.end,
    this.posted = false,
    this.orgKey = '021f4fa6-3377-11ed-91a8-a068f8f3337c',
    this.sessionNumberKKT = 1,
    required this.status,
  });

  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'Posted')
  final bool posted;

  @JsonKey(name: 'Организация_Key')
  final String orgKey;

  @JsonKey(name: 'НомерСменыККТ')
  final int sessionNumberKKT;

  @JsonKey(name: 'КассаККМ_Key')
  final String cashRegisterKey;

  @JsonKey(name: 'НачалоКассовойСмены')
  final DateTime start;

  @JsonKey(name: 'ОкончаниеКассовойСмены')
  final DateTime? end;

  @JsonKey(name: 'Статус')
  final String status;

  static String get openStatus => 'Открыта';

  static String get closeStatus => 'Закрыта';

  factory CreateSessionScheme.fromJson(Map<String, dynamic> json) =>
      _$CreateSessionSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSessionSchemeToJson(this);
}
