// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceTypeScheme _$PriceTypeSchemeFromJson(Map<String, dynamic> json) =>
    PriceTypeScheme(
      refKey: json['Ref_Key'] as String,
      description: json['Description'] as String,
    );

Map<String, dynamic> _$PriceTypeSchemeToJson(PriceTypeScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Description': instance.description,
    };

PriceTypeListScheme _$PriceTypeListSchemeFromJson(Map<String, dynamic> json) =>
    PriceTypeListScheme(
      priceTypes: (json['value'] as List<dynamic>)
          .map((e) => PriceTypeScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PriceTypeListSchemeToJson(
  PriceTypeListScheme instance,
) => <String, dynamic>{'value': instance.priceTypes};
