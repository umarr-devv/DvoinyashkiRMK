// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSessionScheme _$CreateSessionSchemeFromJson(Map<String, dynamic> json) =>
    CreateSessionScheme(
      date: DateTime.parse(json['Date'] as String),
      cashRegisterKey: json['КассаККМ_Key'] as String,
      start: DateTime.parse(json['НачалоКассовойСмены'] as String),
      end: json['ОкончаниеКассовойСмены'] == null
          ? null
          : DateTime.parse(json['ОкончаниеКассовойСмены'] as String),
      posted: json['Posted'] as bool? ?? false,
      orgKey:
          json['Организация_Key'] as String? ??
          '021f4fa6-3377-11ed-91a8-a068f8f3337c',
      sessionNumberKKT: (json['НомерСменыККТ'] as num?)?.toInt() ?? 1,
      status: json['Статус'] as String,
    );

Map<String, dynamic> _$CreateSessionSchemeToJson(
  CreateSessionScheme instance,
) => <String, dynamic>{
  'Date': instance.date.toIso8601String(),
  'Posted': instance.posted,
  'Организация_Key': instance.orgKey,
  'НомерСменыККТ': instance.sessionNumberKKT,
  'КассаККМ_Key': instance.cashRegisterKey,
  'НачалоКассовойСмены': instance.start.toIso8601String(),
  'ОкончаниеКассовойСмены': instance.end?.toIso8601String(),
  'Статус': instance.status,
};
