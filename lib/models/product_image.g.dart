// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImageScheme _$ProductImageSchemeFromJson(Map<String, dynamic> json) =>
    ProductImageScheme(
      nomenclatureKey: json['Ref_Key'] as String,
      image: json['ФотоДляОбмена_Base64Data'] as String?,
    );

Map<String, dynamic> _$ProductImageSchemeToJson(ProductImageScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.nomenclatureKey,
      'ФотоДляОбмена_Base64Data': instance.image,
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
