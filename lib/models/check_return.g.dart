// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckReturnScheme _$CheckReturnSchemeFromJson(Map<String, dynamic> json) =>
    CheckReturnScheme(
      refKey: json['Ref_Key'] as String,
      number: json['Number'] as String,
      date: DateTime.parse(json['Date'] as String),
      cashRegisterKey: json['КассаККМ_Key'] as String,
      structureUnitKey: json['СтруктурнаяЕдиница_Key'] as String,
      userKey: json['Ответственный_Key'] as String,
      cashRegisterSessionKey: json['КассоваяСмена_Key'] as String,
      documentSum: (json['СуммаДокумента'] as num).toDouble(),
    );

Map<String, dynamic> _$CheckReturnSchemeToJson(CheckReturnScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Number': instance.number,
      'Date': instance.date.toIso8601String(),
      'КассаККМ_Key': instance.cashRegisterKey,
      'СтруктурнаяЕдиница_Key': instance.structureUnitKey,
      'Ответственный_Key': instance.userKey,
      'КассоваяСмена_Key': instance.cashRegisterSessionKey,
      'СуммаДокумента': instance.documentSum,
    };
