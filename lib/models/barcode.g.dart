// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarcodeScheme _$BarcodeSchemeFromJson(Map<String, dynamic> json) =>
    BarcodeScheme(
      barcode: json['Штрихкод'] as String,
      nomenclatureKey: json['Номенклатура_Key'] as String,
      characteristicKey: json['Характеристика_Key'] as String,
    );

Map<String, dynamic> _$BarcodeSchemeToJson(BarcodeScheme instance) =>
    <String, dynamic>{
      'Штрихкод': instance.barcode,
      'Номенклатура_Key': instance.nomenclatureKey,
      'Характеристика_Key': instance.characteristicKey,
    };

BarcodeListScheme _$BarcodeListSchemeFromJson(Map<String, dynamic> json) =>
    BarcodeListScheme(
      barcodes: (json['value'] as List<dynamic>)
          .map((e) => BarcodeScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BarcodeListSchemeToJson(BarcodeListScheme instance) =>
    <String, dynamic>{'value': instance.barcodes};
