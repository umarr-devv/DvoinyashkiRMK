// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkReportScheme _$WorkReportSchemeFromJson(Map<String, dynamic> json) =>
    WorkReportScheme(
      employeeKey: json['Сотрудник_Key'] as String,
      terminalKey: json['Терминал_Key'] as String,
      exitType: json['Выход'] as String,
      moment: (json['Момент'] as num).toInt(),
      minute: json['Минута'] as String,
      crossingDate: DateTime.parse(json['ДатаПересечения'] as String),
      status: json['Статус'] as String,
      fio: json['ФИО'] as String,
      updaterKey: json['Обновил_Key'] as String?,
      placeKey: json['Место_Key'] as String?,
      passNumber: json['НомерПропуска'] as String?,
    );

Map<String, dynamic> _$WorkReportSchemeToJson(WorkReportScheme instance) =>
    <String, dynamic>{
      'Сотрудник_Key': instance.employeeKey,
      'Терминал_Key': instance.terminalKey,
      'Выход': instance.exitType,
      'Момент': instance.moment,
      'Минута': instance.minute,
      'ДатаПересечения': instance.crossingDate.toIso8601String(),
      'Статус': instance.status,
      'ФИО': instance.fio,
      'Обновил_Key': ?instance.updaterKey,
      'Место_Key': ?instance.placeKey,
      'НомерПропуска': ?instance.passNumber,
    };

WorkReportListScheme _$WorkReportListSchemeFromJson(
  Map<String, dynamic> json,
) => WorkReportListScheme(
  value: (json['value'] as List<dynamic>)
      .map((e) => WorkReportScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WorkReportListSchemeToJson(
  WorkReportListScheme instance,
) => <String, dynamic>{'value': instance.value};
