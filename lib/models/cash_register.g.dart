// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashRegisterScheme _$CashRegisterSchemeFromJson(Map<String, dynamic> json) =>
    CashRegisterScheme(
      refKey: json['Ref_Key'] as String,
      description: json['Description'] as String,
    );

Map<String, dynamic> _$CashRegisterSchemeToJson(CashRegisterScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Description': instance.description,
    };

CashRegisterListScheme _$CashRegisterListSchemeFromJson(
  Map<String, dynamic> json,
) => CashRegisterListScheme(
  cashRegisters: (json['value'] as List<dynamic>)
      .map((e) => CashRegisterScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CashRegisterListSchemeToJson(
  CashRegisterListScheme instance,
) => <String, dynamic>{'value': instance.cashRegisters};
