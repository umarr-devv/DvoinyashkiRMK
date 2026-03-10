// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkReportScheme _$WorkReportSchemeFromJson(Map<String, dynamic> json) =>
    WorkReportScheme(
      refKey: json['Ref_Key'] as String?,
      workedTime:
          (json['ОтработанноеВремя'] as List<dynamic>?)
              ?.map((e) => WorkedTimeScheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      employeeKey: json['Сотрудник_Key'] as String,
      responsibleKey: json['Ответственный_Key'] as String,
      workplaceKey: json['РабочееМесто_Key'] as String,
      authorKey: json['Автор_Key'] as String,
      isClosed: json['Закрыт'] as bool,
      coefficient: json['Коэфициент'] as num,
      worked: json['Работали'] as String,
      workShiftKey: json['РабочаяСмена_Key'] as String,
      comment: json['Комментарий'] as String,
      date: DateTime.parse(json['Date'] as String),
      departmentKey: json['Подразделение_Key'] as String,
      posted: json['Posted'] as bool?,
      reportDate: DateTime.parse(json['ДатаОтчета'] as String),
    );

Map<String, dynamic> _$WorkReportSchemeToJson(WorkReportScheme instance) =>
    <String, dynamic>{
      'ОтработанноеВремя': instance.workedTime,
      'Сотрудник_Key': instance.employeeKey,
      'Ответственный_Key': instance.responsibleKey,
      'РабочееМесто_Key': instance.workplaceKey,
      'Автор_Key': instance.authorKey,
      'Закрыт': instance.isClosed,
      'Коэфициент': instance.coefficient,
      'Работали': instance.worked,
      'РабочаяСмена_Key': instance.workShiftKey,
      'Комментарий': instance.comment,
      'Date': instance.date.toIso8601String(),
      'Подразделение_Key': instance.departmentKey,
      'ДатаОтчета': instance.reportDate.toIso8601String(),
    };

UpdateWorkReportScheme _$UpdateWorkReportSchemeFromJson(
  Map<String, dynamic> json,
) => UpdateWorkReportScheme(
  workedTime:
      (json['ОтработанноеВремя'] as List<dynamic>?)
          ?.map((e) => WorkedTimeScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$UpdateWorkReportSchemeToJson(
  UpdateWorkReportScheme instance,
) => <String, dynamic>{'ОтработанноеВремя': instance.workedTime};

WorkedTimeScheme _$WorkedTimeSchemeFromJson(Map<String, dynamic> json) =>
    WorkedTimeScheme(
      lineNumber: json['LineNumber'] as String,
      employeeKey: json['Сотрудник_Key'] as String,
      startTime: DateTime.parse(json['НачалоРаботы'] as String),
      endTime: json['ОкончаниеРаботы'] == null
          ? null
          : DateTime.parse(json['ОкончаниеРаботы'] as String),
      deduction: json['Вычет'] as num,
      inn: json['ИНН'] as String,
      warehouseKey: json['Склад_Key'] as String,
      positionKey: json['Должность_Key'] as String,
    );

Map<String, dynamic> _$WorkedTimeSchemeToJson(WorkedTimeScheme instance) =>
    <String, dynamic>{
      'LineNumber': instance.lineNumber,
      'Сотрудник_Key': instance.employeeKey,
      'НачалоРаботы': instance.startTime.toIso8601String(),
      'ОкончаниеРаботы': ?instance.endTime?.toIso8601String(),
      'Вычет': instance.deduction,
      'ИНН': instance.inn,
      'Склад_Key': instance.warehouseKey,
      'Должность_Key': instance.positionKey,
    };
