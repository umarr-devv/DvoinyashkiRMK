import 'dart:typed_data';

import 'package:app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_image.g.dart';

@JsonSerializable()
class ProductImageScheme {
  ProductImageScheme({
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.image,
  });

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String characteristicKey;

  @JsonKey(name: 'Фотография_Base64Data')
  final String? image;

  Uint8List? get imageBytes => stringToBytes(image);

  factory ProductImageScheme.fromJson(Map<String, dynamic> json) =>
      _$ProductImageSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageSchemeToJson(this);
}

@JsonSerializable()
class ProductImageListScheme {
  ProductImageListScheme({required this.prices});

  @JsonKey(name: 'value')
  final List<ProductImageScheme> prices;

  factory ProductImageListScheme.fromJson(Map<String, dynamic> json) =>
      _$ProductImageListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageListSchemeToJson(this);
}
