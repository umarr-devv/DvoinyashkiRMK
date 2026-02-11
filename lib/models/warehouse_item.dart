import 'package:app/blocs/blocs.dart';
import 'package:app/core/consts/consts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

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
  final String? characteristicKey;

  @JsonKey(name: 'КоличествоBalance')
  final double quantity;

  String get uniqueId => nomenclatureKey + (characteristicKey ?? emptyRefKey);

  ProductData? product(BuildContext context) {
    final products = BlocProvider.of<DataCubit>(context).state.products;
    return products.firstWhereLogTypeOrNull((i) => i.uniqueId == uniqueId);
  }

  @override
  List<Object?> get props => [nomenclatureKey, characteristicKey, quantity];

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
