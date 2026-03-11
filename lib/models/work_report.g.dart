// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkReportScheme _$WorkReportSchemeFromJson(Map<String, dynamic> json) =>
    WorkReportScheme(
      refKey: json['Ref_Key'] as String?,
      date: DateTime.parse(json['Date'] as String),
      userKey: json['Сотрудник_Key'] as String,
      startWork: DateTime.parse(json['НачалоРаботы'] as String),
      endWork: DateTime.parse(json['ОкончаниеРаботы'] as String),
      inn: json['ИНН'] as String,
      roleKey: json['Должность_Key'] as String?,
      continueWork: (json['ПродолжительностьДня'] as num).toDouble(),
      totalWork: (json['ИтогоОтработано'] as num).toDouble(),
    );

Map<String, dynamic> _$WorkReportSchemeToJson(WorkReportScheme instance) =>
    <String, dynamic>{
      'Date': instance.date.toIso8601String(),
      'Сотрудник_Key': instance.userKey,
      'НачалоРаботы': instance.startWork.toIso8601String(),
      'ОкончаниеРаботы': instance.endWork.toIso8601String(),
      'ИНН': instance.inn,
      'Должность_Key': instance.roleKey,
      'ПродолжительностьДня': instance.continueWork,
      'ИтогоОтработано': instance.totalWork,
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

UpdateWorkReportScheme _$UpdateWorkReportSchemeFromJson(
  Map<String, dynamic> json,
) => UpdateWorkReportScheme(
  endWork: DateTime.parse(json['ОкончаниеРаботы'] as String),
  continueWork: (json['ПродолжительностьДня'] as num).toDouble(),
  totalWork: (json['ИтогоОтработано'] as num).toDouble(),
);

Map<String, dynamic> _$UpdateWorkReportSchemeToJson(
  UpdateWorkReportScheme instance,
) => <String, dynamic>{
  'ОкончаниеРаботы': instance.endWork.toIso8601String(),
  'ПродолжительностьДня': instance.continueWork,
  'ИтогоОтработано': instance.totalWork,
};
