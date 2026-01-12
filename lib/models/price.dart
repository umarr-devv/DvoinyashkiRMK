import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable()
class PriceScheme {
  PriceScheme({
    required this.period,
    required this.priceTypeKey,
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.price,
  });

  @JsonKey(name: 'Period')
  final DateTime period;

  @JsonKey(name: 'ВидЦен_Key')
  final String priceTypeKey;

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String characteristicKey;

  @JsonKey(name: 'Цена')
  final num price;

  factory PriceScheme.fromJson(Map<String, dynamic> json) =>
      _$PriceSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$PriceSchemeToJson(this);
}

@JsonSerializable()
class PriceListScheme {
  PriceListScheme({required this.prices});

  @JsonKey(name: 'value')
  final List<PriceScheme> prices;

  factory PriceListScheme.fromJson(Map<String, dynamic> json) =>
      _$PriceListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$PriceListSchemeToJson(this);
}
