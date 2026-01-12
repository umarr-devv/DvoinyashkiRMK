// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_images_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImagesState _$ProductImagesStateFromJson(Map<String, dynamic> json) =>
    ProductImagesState(
      images:
          (json['images'] as List<dynamic>?)
              ?.map(
                (e) => ProductImageScheme.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      update: json['update'] == null
          ? null
          : DateTime.parse(json['update'] as String),
    );

Map<String, dynamic> _$ProductImagesStateToJson(ProductImagesState instance) =>
    <String, dynamic>{
      'images': instance.images,
      'update': instance.update?.toIso8601String(),
    };
