// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImageScheme _$ProductImageSchemeFromJson(Map<String, dynamic> json) =>
    ProductImageScheme(
      nomenclatureKey: json['Номенклатура_Key'] as String,
      characteristicKey: json['Характеристика_Key'] as String,
      image: json['Фотография_Base64Data'] as String?,
    );

Map<String, dynamic> _$ProductImageSchemeToJson(ProductImageScheme instance) =>
    <String, dynamic>{
      'Номенклатура_Key': instance.nomenclatureKey,
      'Характеристика_Key': instance.characteristicKey,
      'Фотография_Base64Data': instance.image,
    };

ProductImageListScheme _$ProductImageListSchemeFromJson(
  Map<String, dynamic> json,
) => ProductImageListScheme(
  productImages: (json['value'] as List<dynamic>)
      .map((e) => ProductImageScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProductImageListSchemeToJson(
  ProductImageListScheme instance,
) => <String, dynamic>{'value': instance.productImages};
