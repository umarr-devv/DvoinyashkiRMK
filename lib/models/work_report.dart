import 'package:json_annotation/json_annotation.dart';

part 'work_report.g.dart';

@JsonSerializable(includeIfNull: false)
class WorkReportScheme {
  WorkReportScheme({
    required this.employeeKey,
    required this.terminalKey,
    required this.exitType,
    required this.moment,
    required this.minute,
    required this.crossingDate,
    required this.status,
    required this.fio,
    required this.updaterKey,
    required this.placeKey,
    required this.passNumber,
  });

  @JsonKey(name: 'Сотрудник_Key')
  final String employeeKey;

  @JsonKey(name: 'Терминал_Key')
  final String terminalKey;

  @JsonKey(name: 'Выход')
  final String exitType;

  @JsonKey(name: 'Момент')
  final int moment;

  @JsonKey(name: 'Минута')
  final String minute;

  @JsonKey(name: 'ДатаПересечения')
  final DateTime crossingDate;

  @JsonKey(name: 'Статус')
  final String status;

  @JsonKey(name: 'ФИО')
  final String fio;

  @JsonKey(name: 'Обновил_Key')
  final String? updaterKey;

  @JsonKey(name: 'Место_Key')
  final String? placeKey;

  @JsonKey(name: 'НомерПропуска')
  final String? passNumber;

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

