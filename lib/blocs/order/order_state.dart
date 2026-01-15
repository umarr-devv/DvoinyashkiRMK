// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_cubit.dart';

@JsonSerializable()
class OrderState{
  const OrderState({this.currentOrder, this.saveOrders = const []});

  final OrderData? currentOrder;
  final List<OrderData> saveOrders;

  OrderState copyWith({Object? currentOrder, List<OrderData>? saveOrders}) {
    return OrderState(
      currentOrder: undefCompare(currentOrder, this.currentOrder),
      saveOrders: saveOrders ?? this.saveOrders,
    );
  }

  OrderState.from(OrderState other)
    : currentOrder = other.currentOrder,
      saveOrders = other.saveOrders;

  factory OrderState.fromJson(Map<String, dynamic> json) =>
      _$OrderStateFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStateToJson(this);
}

final class OrderInitial extends OrderState {}

final class OrderUpdate extends OrderState {
  OrderUpdate(super.state) : super.from();
}
