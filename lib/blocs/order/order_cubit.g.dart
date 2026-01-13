// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
  nomenclature: NomenclatureScheme.fromJson(
    json['nomenclature'] as Map<String, dynamic>,
  ),
  characteristic: json['characteristic'] == null
      ? null
      : CharacteristicScheme.fromJson(
          json['characteristic'] as Map<String, dynamic>,
        ),
  quantity: (json['quantity'] as num).toDouble(),
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'nomenclature': instance.nomenclature,
  'characteristic': instance.characteristic,
  'quantity': instance.quantity,
  'price': instance.price,
};

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
  uniqueId: json['unique_id'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  createAt: DateTime.parse(json['create_at'] as String),
);

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
  'unique_id': instance.uniqueId,
  'items': instance.items,
  'create_at': instance.createAt.toIso8601String(),
};

OrderState _$OrderStateFromJson(Map<String, dynamic> json) => OrderState(
  currentOrder: json['current_order'] == null
      ? null
      : OrderData.fromJson(json['current_order'] as Map<String, dynamic>),
  saveOrders:
      (json['save_orders'] as List<dynamic>?)
          ?.map((e) => OrderData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$OrderStateToJson(OrderState instance) =>
    <String, dynamic>{
      'current_order': instance.currentOrder,
      'save_orders': instance.saveOrders,
    };
