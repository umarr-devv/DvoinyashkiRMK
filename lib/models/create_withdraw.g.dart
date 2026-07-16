// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_withdraw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWithdrawScheme _$CreateWithdrawSchemeFromJson(
  Map<String, dynamic> json,
) => CreateWithdrawScheme(
  date: DateTime.parse(json['Date'] as String),
  comment: json['Комментарий'] as String?,
  posted: json['Posted'] as bool,
  cashRegisterKey: json['КассаККМ_Key'] as String,
  authorKey: json['Автор_Key'] as String,
  subdivisionKey: json['Подразделение_Key'] as String,
  storeKey: json['Магазин_Key'] as String,
  sessionKey: json['ОтчетОРозничныхПродажах_Key'] as String,
  documentSum: (json['СуммаДокумента'] as num).toDouble(),
  orgKey:
      json['Организация_Key'] as String? ??
      '021f4fa6-3377-11ed-91a8-a068f8f3337c',
  currencyKey:
      json['ВалютаДенежныхСредств_Key'] as String? ??
      '02e351c0-7e12-11ed-a847-18d6c704b66b',
);

Map<String, dynamic> _$CreateWithdrawSchemeToJson(
  CreateWithdrawScheme instance,
) => <String, dynamic>{
  'ВалютаДенежныхСредств_Key': instance.currencyKey,
  'Date': instance.date.toIso8601String(),
  'Posted': instance.posted,
  'Комментарий': instance.comment,
  'Организация_Key': instance.orgKey,
  'КассаККМ_Key': instance.cashRegisterKey,
  'Автор_Key': instance.authorKey,
  'Подразделение_Key': instance.subdivisionKey,
  'Магазин_Key': instance.storeKey,
  'ОтчетОРозничныхПродажах_Key': instance.sessionKey,
  'СуммаДокумента': instance.documentSum,
};
