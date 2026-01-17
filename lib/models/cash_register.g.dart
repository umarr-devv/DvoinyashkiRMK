// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashRegisterScheme _$CashRegisterSchemeFromJson(Map<String, dynamic> json) =>
    CashRegisterScheme(
      refKey: json['Ref_Key'] as String,
      description: json['ККТ Экран'] as String,
    );

Map<String, dynamic> _$CashRegisterSchemeToJson(CashRegisterScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'ККТ Экран': instance.description,
    };
