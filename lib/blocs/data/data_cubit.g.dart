// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_cubit.dart';

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
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImageScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'nomenclature': instance.nomenclature,
      'characteristic': instance.characteristic,
      'prices': instance.prices,
      'barcodes': instance.barcodes,
      'images': instance.images,
    };

DataState _$DataStateFromJson(Map<String, dynamic> json) => DataState(
  cashRegisters:
      (json['cash_registers'] as List<dynamic>?)
          ?.map((e) => CashRegisterScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
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
  structureUnits:
      (json['structure_units'] as List<dynamic>?)
          ?.map((e) => StructureUnitScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  productImages:
      (json['product_images'] as List<dynamic>?)
          ?.map((e) => ProductImageScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  users:
      (json['users'] as List<dynamic>?)
          ?.map((e) => UserScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  authors:
      (json['authors'] as List<dynamic>?)
          ?.map((e) => AuthorScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  products:
      (json['products'] as List<dynamic>?)
          ?.map((e) => ProductData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  update: json['update'] == null
      ? null
      : DateTime.parse(json['update'] as String),
);

Map<String, dynamic> _$DataStateToJson(DataState instance) => <String, dynamic>{
  'cash_registers': instance.cashRegisters,
  'categories': instance.categories,
  'nomenclatures': instance.nomenclatures,
  'characteristics': instance.characteristics,
  'prices': instance.prices,
  'price_types': instance.priceTypes,
  'barcodes': instance.barcodes,
  'structure_units': instance.structureUnits,
  'product_images': instance.productImages,
  'users': instance.users,
  'authors': instance.authors,
  'products': instance.products,
  'update': instance.update?.toIso8601String(),
};
