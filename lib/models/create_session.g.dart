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
    );

Map<String, dynamic> _$CreateSessionSchemeToJson(
  CreateSessionScheme instance,
) => <String, dynamic>{
  'Date': instance.date.toIso8601String(),
  'КассаККМ_Key': instance.cashRegisterKey,
  'НачалоКассовойСмены': instance.start.toIso8601String(),
  'ОкончаниеКассовойСмены': instance.end?.toIso8601String(),
};
