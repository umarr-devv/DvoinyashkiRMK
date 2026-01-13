// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_cubit.dart';

@JsonSerializable()
class OrderItem extends Equatable {
  const OrderItem({
    required this.nomenclature,
    required this.characteristic,
    required this.quantity,
    required this.price,
  });

  final NomenclatureScheme nomenclature;
  final CharacteristicScheme? characteristic;
  final double quantity;
  final double price;

  OrderItem copyWith({
    NomenclatureScheme? nomenclature,
    CharacteristicScheme? characteristic,
    double? quantity,
    double? price,
  }) {
    return OrderItem(
      nomenclature: nomenclature ?? this.nomenclature,
      characteristic: characteristic ?? this.characteristic,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @override
  List<Object?> get props => [nomenclature.refKey, characteristic?.refKey];
}

@JsonSerializable()
class OrderData extends Equatable {
  const OrderData({
    required this.uniqueId,
    required this.items,
    required this.createAt,
  });

  final String uniqueId;
  final List<OrderItem> items;
  final DateTime createAt;

  OrderData copyWith({
    String? uniqueId,
    List<OrderItem>? items,
    DateTime? createAt,
  }) {
    return OrderData(
      uniqueId: uniqueId ?? this.uniqueId,
      items: items ?? this.items,
      createAt: createAt ?? this.createAt,
    );
  }

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataToJson(this);

  @override
  List<Object?> get props => [uniqueId];
}
