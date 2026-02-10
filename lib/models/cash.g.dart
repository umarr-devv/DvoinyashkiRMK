// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashScheme _$CashSchemeFromJson(Map<String, dynamic> json) => CashScheme(
  value: (json['СуммаBalance'] as num).toDouble(),
  cashRegisterKey: json['КассаККМ_Key'] as String,
);

Map<String, dynamic> _$CashSchemeToJson(CashScheme instance) =>
    <String, dynamic>{
      'КассаККМ_Key': instance.cashRegisterKey,
      'СуммаBalance': instance.value,
    };

CashListScheme _$CashListSchemeFromJson(Map<String, dynamic> json) =>
    CashListScheme(
      cashes: (json['value'] as List<dynamic>)
          .map((e) => CashScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CashListSchemeToJson(CashListScheme instance) =>
    <String, dynamic>{'value': instance.cashes};
