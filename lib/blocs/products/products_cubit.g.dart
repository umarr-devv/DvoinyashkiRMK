// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceData _$PriceDataFromJson(Map<String, dynamic> json) => PriceData(
  price: PriceScheme.fromJson(json['price'] as Map<String, dynamic>),
  type: json['type'] == null
      ? null
      : PriceTypeScheme.fromJson(json['type'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PriceDataToJson(PriceData instance) => <String, dynamic>{
  'price': instance.price,
  'type': instance.type,
};

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
  nomenclature: NomenclatureScheme.fromJson(
    json['nomenclature'] as Map<String, dynamic>,
  ),
  characteristic: json['characteristic'] == null
      ? null
      : CharacteristicScheme.fromJson(
          json['characteristic'] as Map<String, dynamic>,
        ),
  prices:
      (json['prices'] as List<dynamic>?)
          ?.map((e) => PriceData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  barcodes:
      (json['barcodes'] as List<dynamic>?)
          ?.map((e) => BarcodeScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'nomenclature': instance.nomenclature,
      'characteristic': instance.characteristic,
      'prices': instance.prices,
      'barcodes': instance.barcodes,
    };

ProductsState _$ProductsStateFromJson(Map<String, dynamic> json) =>
    ProductsState(
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => ProductData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      update: json['update'] == null
          ? null
          : DateTime.parse(json['update'] as String),
    );

Map<String, dynamic> _$ProductsStateToJson(ProductsState instance) =>
    <String, dynamic>{
      'products': instance.products,
      'update': instance.update?.toIso8601String(),
    };
