// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
  product: ProductData.fromJson(json['product'] as Map<String, dynamic>),
  quantity: (json['quantity'] as num).toDouble(),
  specification: json['specification'] == null
      ? null
      : SpecificationScheme.fromJson(
          json['specification'] as Map<String, dynamic>,
        ),
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'product': instance.product,
  'specification': instance.specification,
  'quantity': instance.quantity,
  'price': instance.price,
};

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
  uniqueId: json['uniqueId'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  createAt: DateTime.parse(json['createAt'] as String),
);

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
  'uniqueId': instance.uniqueId,
  'items': instance.items,
  'createAt': instance.createAt.toIso8601String(),
};

OrderState _$OrderStateFromJson(Map<String, dynamic> json) => OrderState(
  currentOrder: json['currentOrder'] == null
      ? null
      : OrderData.fromJson(json['currentOrder'] as Map<String, dynamic>),
  saveOrders:
      (json['saveOrders'] as List<dynamic>?)
          ?.map((e) => OrderData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$OrderStateToJson(OrderState instance) =>
    <String, dynamic>{
      'currentOrder': instance.currentOrder,
      'saveOrders': instance.saveOrders,
    };
