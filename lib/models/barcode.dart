import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'barcode.g.dart';

@JsonSerializable()
class BarcodeScheme extends Equatable {
  const BarcodeScheme({
    required this.barcode,
    required this.nomenclatureKey,
    required this.characteristicKey,
  });

  @JsonKey(name: 'Штрихкод')
  final String barcode;

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String characteristicKey;

  factory BarcodeScheme.fromJson(Map<String, dynamic> json) =>
      _$BarcodeSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeSchemeToJson(this);

  @override
  List<Object?> get props => [barcode, nomenclatureKey, characteristicKey];
}

@JsonSerializable()
class BarcodeListScheme {
  BarcodeListScheme({required this.value});

  @JsonKey(name: 'value')
  final List<BarcodeScheme> value;

  factory BarcodeListScheme.fromJson(Map<String, dynamic> json) =>
      _$BarcodeListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$BarcodeListSchemeToJson(this);
}
