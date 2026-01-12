// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsState _$ProductsStateFromJson(
  Map<String, dynamic> json,
) => ProductsState(
  nomenclatures:
      (json['nomenclatures'] as List<dynamic>?)
          ?.map((e) => NomenclatureScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  characteristics:
      (json['characteristics'] as List<dynamic>?)
          ?.map((e) => CharacteristicScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  prices:
      (json['prices'] as List<dynamic>?)
          ?.map((e) => PriceScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  priceTypes:
      (json['price_types'] as List<dynamic>?)
          ?.map((e) => PriceTypeScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  barcodes:
      (json['barcodes'] as List<dynamic>?)
          ?.map((e) => BarcodeScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  update: json['update'] == null
      ? null
      : DateTime.parse(json['update'] as String),
);

Map<String, dynamic> _$ProductsStateToJson(ProductsState instance) =>
    <String, dynamic>{
      'nomenclatures': instance.nomenclatures,
      'characteristics': instance.characteristics,
      'prices': instance.prices,
      'price_types': instance.priceTypes,
      'barcodes': instance.barcodes,
      'update': instance.update?.toIso8601String(),
    };
