import 'package:json_annotation/json_annotation.dart';

part 'work_report.g.dart';

@JsonSerializable()
class WorkReportScheme {
  WorkReportScheme({
    this.refKey,
    required this.date,
    required this.userKey,
    required this.startWork,
    required this.endWork,
    required this.inn,
    required this.roleKey,
    required this.continueWork,
    required this.totalWork,
  });

  @JsonKey(name: 'Ref_Key', includeToJson: false)
  final String? refKey;

  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'Сотрудник_Key')
  final String userKey;

  @JsonKey(name: 'НачалоРаботы')
  final DateTime startWork;

  @JsonKey(name: 'ОкончаниеРаботы')
  final DateTime endWork;

  @JsonKey(name: 'ИНН')
  final String inn;

  @JsonKey(name: 'Должность_Key')
  final String? roleKey;

  @JsonKey(name: 'ПродолжительностьДня')
  final double continueWork;

  @JsonKey(name: 'ИтогоОтработано')
  final double totalWork;

  factory WorkReportScheme.fromJson(Map<String, dynamic> json) =>
      _$WorkReportSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkReportSchemeToJson(this);
}

@JsonSerializable()
class WorkReportListScheme {
  WorkReportListScheme({required this.value});

  @JsonKey(name: 'value')
  final List<WorkReportScheme> value;

  factory WorkReportListScheme.fromJson(Map<String, dynamic> json) =>
      _$WorkReportListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkReportListSchemeToJson(this);
}

@JsonSerializable()
class UpdateWorkReportScheme {
  @JsonKey(name: 'ОкончаниеРаботы')
  final DateTime endWork;

  @JsonKey(name: 'ПродолжительностьДня')
  final double continueWork;

  @JsonKey(name: 'ИтогоОтработано')
  final double totalWork;

  UpdateWorkReportScheme({
    required this.endWork,
    required this.continueWork,
    required this.totalWork,
  });

  factory UpdateWorkReportScheme.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkReportSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateWorkReportSchemeToJson(this);
}
