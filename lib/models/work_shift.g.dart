// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkShiftScheme _$WorkShiftSchemeFromJson(Map<String, dynamic> json) =>
    WorkShiftScheme(
      refKey: json['Ref_Key'] as String,
      number: json['Number'] as String,
      date: DateTime.parse(json['Date'] as String),
      posted: json['Posted'] as bool,
      userKey: json['Ответственный_Key'] as String,
      authorKey: json['Автор_Key'] as String,
      cashRegisterKey: json['КассаККМ_Key'] as String,
      cashRegisterShiftKey: json['КассоваяСмена_Key'] as String,
      commentary: json['Комментарий'] as String,
      workShiftStart: DateTime.parse(json['НачалоКассовойСмены'] as String),
      workShiftEnd: json['ОкончаниеКассовойСмены'] == null
          ? null
          : DateTime.parse(json['ОкончаниеКассовойСмены'] as String),
      status: json['СтатусКассовойСмены'] as String,
      articleKey: json['Статья_Key'] as String,
      structureUnitKey: json['СтруктурнаяЕдиница_Key'] as String,
      documentSum: (json['СуммаДокумента'] as num).toDouble(),
    );

Map<String, dynamic> _$WorkShiftSchemeToJson(WorkShiftScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Number': instance.number,
      'Date': instance.date.toIso8601String(),
      'Posted': instance.posted,
      'Ответственный_Key': instance.userKey,
      'Автор_Key': instance.authorKey,
      'КассаККМ_Key': instance.cashRegisterKey,
      'КассоваяСмена_Key': instance.cashRegisterShiftKey,
      'Комментарий': instance.commentary,
      'НачалоКассовойСмены': instance.workShiftStart.toIso8601String(),
      'ОкончаниеКассовойСмены': instance.workShiftEnd?.toIso8601String(),
      'СтатусКассовойСмены': instance.status,
      'Статья_Key': instance.articleKey,
      'СтруктурнаяЕдиница_Key': instance.structureUnitKey,
      'СуммаДокумента': instance.documentSum,
    };

WorkShiftListScheme _$WorkShiftListSchemeFromJson(Map<String, dynamic> json) =>
    WorkShiftListScheme(
      workShifts: (json['value'] as List<dynamic>)
          .map((e) => WorkShiftScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkShiftListSchemeToJson(
  WorkShiftListScheme instance,
) => <String, dynamic>{'value': instance.workShifts};
