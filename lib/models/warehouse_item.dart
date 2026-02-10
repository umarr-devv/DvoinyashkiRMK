import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'warehouse_item.g.dart';

@JsonSerializable()
class WarehouseItemScheme extends Equatable {
  const WarehouseItemScheme({
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.quantity,
  });


  @JsonKey(name: 'Номенклатура_Key')
  final String nomenclatureKey;

  @JsonKey(name: 'Характеристика_Key')
  final String characteristicKey;

  @JsonKey(name: 'КоличествоBalance')
  final double quantity;

  @override
  List<Object?> get props => [
    nomenclatureKey,
    characteristicKey,
    quantity,
  ];

  factory WarehouseItemScheme.fromJson(Map<String, dynamic> json) =>
      _$WarehouseItemSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseItemSchemeToJson(this);
}


@JsonSerializable()
class WarehouseItemListScheme {
  WarehouseItemListScheme({required this.warehouseItems});

  @JsonKey(name: 'value')
  final List<WarehouseItemScheme> warehouseItems;


  factory WarehouseItemListScheme.fromJson(Map<String, dynamic> json) =>
      _$WarehouseItemListSchemeFromJson(json);


  Map<String, dynamic> toJson() => _$WarehouseItemListSchemeToJson(this);

}
