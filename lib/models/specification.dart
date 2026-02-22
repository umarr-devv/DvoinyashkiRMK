import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'specification.g.dart';

@JsonSerializable()
class SpecificationItemScheme {
  SpecificationItemScheme({
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.unitKey,
    required this.quantity,
    required this.sum,
    required this.price,
  });

  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String? characteristicKey;

  @JsonKey(name: 'ЕдиницаИзмерения')
  final String unitKey;

  @JsonKey(name: 'Количество')
  final double quantity;

  @JsonKey(name: 'Сумма')
  final double sum;

  @JsonKey(name: 'Цена')
  final double price;

    factory SpecificationItemScheme.fromJson(Map<String, dynamic> json) =>
      _$SpecificationItemSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$SpecificationItemSchemeToJson(this);
}

@JsonSerializable()
class SpecificationScheme extends Equatable {
  const SpecificationScheme({
    required this.refKey,
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.code,
    required this.priceKey,
    required this.materialSum,
    required this.unitPrice,
    required this.totalPrice,
    required this.outputCount,
    required this.userKey,
    required this.sellPrice,
    required this.items,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Owner_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'ХарактеристикаПродукции_Key')
  final String characteristicKey;

  @JsonKey(name: 'Code')
  final String code;

  @JsonKey(name: 'ВидЦены_Key')
  final String priceKey;

  @JsonKey(name: 'СуммаМатериал')
  final double materialSum;

  @JsonKey(name: 'ЗаЕдиницу')
  final double unitPrice;

  @JsonKey(name: 'Сумма')
  final double totalPrice;

  @JsonKey(name: 'КоличествоПродукции')
  final double outputCount;

  @JsonKey(name: 'Ответственный_Key')
  final String userKey;

  @JsonKey(name: 'ЦенаПродажи')
  final double sellPrice;

  @JsonKey(name: 'Состав')
  final List<SpecificationItemScheme> items;

    factory SpecificationScheme.fromJson(Map<String, dynamic> json) =>
      _$SpecificationSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$SpecificationSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class SpecificationListScheme {
  SpecificationListScheme({required this.value});

  @JsonKey(name: 'value')
  final List<SpecificationScheme> value;


    factory SpecificationListScheme.fromJson(Map<String, dynamic> json) =>
      _$SpecificationListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$SpecificationListSchemeToJson(this);
}
