import 'dart:typed_data';

import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_image.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class ProductImageScheme extends Equatable {
  ProductImageScheme({
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.image,
  }) : imageBytes = stringToBytes(image);

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String characteristicKey;

  @JsonKey(name: 'Фотография_Base64Data')
  final String? image;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? imageBytes;

  factory ProductImageScheme.fromJson(Map<String, dynamic> json) =>
      _$ProductImageSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageSchemeToJson(this);

  @override
  List<Object?> get props => [nomenclatureKey, characteristicKey, image];
}

@JsonSerializable()
class ProductImageListScheme {
  ProductImageListScheme({required this.productImages});

  @JsonKey(name: 'value')
  final List<ProductImageScheme> productImages;

  factory ProductImageListScheme.fromJson(Map<String, dynamic> json) =>
      _$ProductImageListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageListSchemeToJson(this);
}
