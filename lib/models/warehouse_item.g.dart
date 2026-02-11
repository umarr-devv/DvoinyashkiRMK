// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseItemScheme _$WarehouseItemSchemeFromJson(Map<String, dynamic> json) =>
    WarehouseItemScheme(
      nomenclatureKey: json['Номенклатура_Key'] as String,
      characteristicKey: json['Характеристика_Key'] as String?,
      quantity: (json['КоличествоBalance'] as num).toDouble(),
    );

Map<String, dynamic> _$WarehouseItemSchemeToJson(
  WarehouseItemScheme instance,
) => <String, dynamic>{
  'Номенклатура_Key': instance.nomenclatureKey,
  'Характеристика_Key': instance.characteristicKey,
  'КоличествоBalance': instance.quantity,
};

WarehouseItemListScheme _$WarehouseItemListSchemeFromJson(
  Map<String, dynamic> json,
) => WarehouseItemListScheme(
  warehouseItems: (json['value'] as List<dynamic>)
      .map((e) => WarehouseItemScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WarehouseItemListSchemeToJson(
  WarehouseItemListScheme instance,
) => <String, dynamic>{'value': instance.warehouseItems};
