// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawScheme _$WithdrawSchemeFromJson(Map<String, dynamic> json) =>
    WithdrawScheme(
      refKey: json['Ref_Key'] as String,
      number: json['Number'] as String,
      date: DateTime.parse(json['Date'] as String),
      posted: json['Posted'] as bool,
      cashRegisyerKey: json['КассаККМ_Key'] as String,
      commentary: json['Комментарий'] as String,
      documentSum: (json['СуммаДокумента'] as num).toDouble(),
      storeKey: json['Магазин_Key'] as String,
      subdivisionKey: json['Подразделение_Key'] as String,
      sessionKey: json['ОтчетОРозничныхПродажах_Key'] as String,
    );

Map<String, dynamic> _$WithdrawSchemeToJson(WithdrawScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Number': instance.number,
      'Date': instance.date.toIso8601String(),
      'Posted': instance.posted,
      'КассаККМ_Key': instance.cashRegisyerKey,
      'Комментарий': instance.commentary,
      'СуммаДокумента': instance.documentSum,
      'Магазин_Key': instance.storeKey,
      'Подразделение_Key': instance.subdivisionKey,
      'ОтчетОРозничныхПродажах_Key': instance.sessionKey,
    };

WithdrawListScheme _$WithdrawListSchemeFromJson(Map<String, dynamic> json) =>
    WithdrawListScheme(
      withdraws: (json['value'] as List<dynamic>)
          .map((e) => WithdrawScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WithdrawListSchemeToJson(WithdrawListScheme instance) =>
    <String, dynamic>{'value': instance.withdraws};
