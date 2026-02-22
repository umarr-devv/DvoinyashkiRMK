// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceScheme _$PriceSchemeFromJson(Map<String, dynamic> json) => PriceScheme(
  period: DateTime.parse(json['Period'] as String),
  priceTypeKey: json['ВидЦен_Key'] as String,
  nomenclatureKey: json['Номенклатура_Key'] as String,
  characteristicKey: json['Характеристика_Key'] as String,
  price: json['Цена'] as num,
);

Map<String, dynamic> _$PriceSchemeToJson(PriceScheme instance) =>
    <String, dynamic>{
      'Period': instance.period.toIso8601String(),
      'ВидЦен_Key': instance.priceTypeKey,
      'Номенклатура_Key': instance.nomenclatureKey,
      'Характеристика_Key': instance.characteristicKey,
      'Цена': instance.price,
    };

PriceListScheme _$PriceListSchemeFromJson(Map<String, dynamic> json) =>
    PriceListScheme(
      value: (json['value'] as List<dynamic>)
          .map((e) => PriceScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PriceListSchemeToJson(PriceListScheme instance) =>
    <String, dynamic>{'value': instance.value};
