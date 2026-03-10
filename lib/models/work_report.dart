import 'package:json_annotation/json_annotation.dart';

part 'work_report.g.dart';

@JsonSerializable(includeIfNull: false)
class WorkReportScheme {
  @JsonKey(name: 'Ref_Key', includeToJson: false)
  final String? refKey;

  @JsonKey(name: 'Posted', includeToJson: false)
  final bool? posted;

  @JsonKey(name: 'ОтработанноеВремя', defaultValue: [])
  final List<WorkedTimeScheme> workedTime;

  @JsonKey(name: 'Сотрудник_Key')
  final String employeeKey;

  @JsonKey(name: 'Ответственный_Key')
  final String responsibleKey;

  @JsonKey(name: 'РабочееМесто_Key')
  final String workplaceKey;

  @JsonKey(name: 'Автор_Key')
  final String authorKey;

  @JsonKey(name: 'Закрыт')
  final bool isClosed;

  @JsonKey(name: 'Коэфициент')
  final num coefficient;

  @JsonKey(name: 'Работали')
  final String worked;

  @JsonKey(name: 'РабочаяСмена_Key')
  final String workShiftKey;

  @JsonKey(name: 'Комментарий')
  final String comment;

  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'Подразделение_Key')
  final String departmentKey;

  @JsonKey(name: 'ДатаОтчета')
  final DateTime reportDate;

  WorkReportScheme({
    this.refKey,
    required this.workedTime,
    required this.employeeKey,
    required this.responsibleKey,
    required this.workplaceKey,
    required this.authorKey,
    required this.isClosed,
    required this.coefficient,
    required this.worked,
    required this.workShiftKey,
    required this.comment,
    required this.date,
    required this.departmentKey,
    this.posted,
    required this.reportDate,
  });

  factory WorkReportScheme.fromJson(Map<String, dynamic> json) =>
      _$WorkReportSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkReportSchemeToJson(this);
}

@JsonSerializable(includeIfNull: false)
class UpdateWorkReportScheme {
  @JsonKey(name: 'ОтработанноеВремя', defaultValue: [])
  final List<WorkedTimeScheme> workedTime;

  UpdateWorkReportScheme({required this.workedTime});

  factory UpdateWorkReportScheme.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkReportSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateWorkReportSchemeToJson(this);
}

@JsonSerializable(includeIfNull: false)
class WorkedTimeScheme {
  @JsonKey(name: 'LineNumber')
  final String lineNumber;

  @JsonKey(name: 'Сотрудник_Key')
  final String employeeKey;

  @JsonKey(name: 'НачалоРаботы')
  final DateTime startTime;

  @JsonKey(name: 'ОкончаниеРаботы')
  final DateTime? endTime;

  @JsonKey(name: 'Вычет')
  final num deduction;

  @JsonKey(name: 'ИНН')
  final String inn;

  @JsonKey(name: 'Склад_Key')
  final String warehouseKey;

  @JsonKey(name: 'Должность_Key')
  final String positionKey;

  WorkedTimeScheme({
    required this.lineNumber,
    required this.employeeKey,
    required this.startTime,
    required this.endTime,
    required this.deduction,
    required this.inn,
    required this.warehouseKey,
    required this.positionKey,
  });

  factory WorkedTimeScheme.fromJson(Map<String, dynamic> json) =>
      _$WorkedTimeSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkedTimeSchemeToJson(this);
}
