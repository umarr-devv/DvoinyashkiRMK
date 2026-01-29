// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionScheme _$SessionSchemeFromJson(Map<String, dynamic> json) =>
    SessionScheme(
      refKey: json['Ref_Key'] as String,
      number: json['Number'] as String,
      posted: json['Posted'] as bool,
      cashRegisterKey: json['КассаККМ_Key'] as String,
      start: DateTime.parse(json['НачалоКассовойСмены'] as String),
      end: json['ОкончаниеКассовойСмены'] == null
          ? null
          : DateTime.parse(json['ОкончаниеКассовойСмены'] as String),
      status: json['Статус'] as String?,
    );

Map<String, dynamic> _$SessionSchemeToJson(SessionScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Number': instance.number,
      'Posted': instance.posted,
      'КассаККМ_Key': instance.cashRegisterKey,
      'НачалоКассовойСмены': instance.start.toIso8601String(),
      'ОкончаниеКассовойСмены': instance.end?.toIso8601String(),
      'Статус': instance.status,
    };

SessionListScheme _$SessionListSchemeFromJson(Map<String, dynamic> json) =>
    SessionListScheme(
      sessions: (json['value'] as List<dynamic>)
          .map((e) => SessionScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionListSchemeToJson(SessionListScheme instance) =>
    <String, dynamic>{'value': instance.sessions};
