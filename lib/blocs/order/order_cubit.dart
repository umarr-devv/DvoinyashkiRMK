import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/undefined.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uuid/uuid.dart';

part 'order_cubit.g.dart';
part 'order_data.dart';
part 'order_state.dart';

class OrderCubit extends HydratedCubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  final uuid = Uuid();

  void createOrder() {
    if (state.currentOrder == null) {
      final newState = state.copyWith(
        currentOrder: OrderData(
          uniqueId: uuid.v7(),
          items: [],
          createAt: DateTime.now(),
        ),
      );
      emit(OrderUpdate(newState));
    }
  }

  void addItem(OrderItem item) {
    if (state.currentOrder == null) createOrder();
    final currentOrder = state.currentOrder!;
    final List<OrderItem> items = List.from(currentOrder.items);
    items.add(item);
    final newState = state.copyWith(
      currentOrder: currentOrder.copyWith(items: items),
    );
    emit(OrderUpdate(newState));
  }

  void updateItem(OrderItem item) {
    final currentOrder = state.currentOrder;
    if (currentOrder == null) return;

    final List<OrderItem> items = List.from(currentOrder.items);
    final index = currentOrder.items.indexOf(item);

    if (index == -1) return;

    if (item.quantity < 0) {
      items.removeAt(index);
    } else {
      items[index] = item;
    }

    final newState = state.copyWith(
      currentOrder: currentOrder.copyWith(items: items),
    );
    emit(OrderUpdate(newState));
  }

  void deleteItem(OrderItem item) {
    final currentOrder = state.currentOrder;
    if (currentOrder == null) return;

    final List<OrderItem> items = List.from(currentOrder.items);
    final index = currentOrder.items.indexOf(item);

    items.removeAt(index);

    final newState = state.copyWith(
      currentOrder: currentOrder.copyWith(items: items),
    );
    emit(OrderUpdate(newState));
  }

  void clearItems() {
    if (state.currentOrder == null) return;
    final newState = state.copyWith(
      currentOrder: state.currentOrder!.copyWith(items: []),
    );
    emit(OrderUpdate(newState));
  }

  void setCurrentOrder(OrderData order) {
    saveOrder();
    deleteSaveOrder(order);
    final newState = state.copyWith(currentOrder: order);
    emit(OrderUpdate(newState));
  }

  void saveOrder() {
    if (state.currentOrder == null) return;
    final List<OrderData> saveOrders = List.from(state.saveOrders);
    saveOrders.add(state.currentOrder!);

    final newState = state.copyWith(
      currentOrder: undefined,
      saveOrders: saveOrders,
    );
    emit(OrderUpdate(newState));
  }

  void deleteSaveOrder(OrderData order) {
    final List<OrderData> saveOrders = List.from(state.saveOrders);

    final savedOrder = saveOrders.firstWhereLogTypeOrNull(
      (i) => i.uniqueId == order.uniqueId,
    );

    if (savedOrder == null) return;
    saveOrders.remove(savedOrder);

    final newState = state.copyWith(
      currentOrder: undefined,
      saveOrders: saveOrders,
    );
    emit(OrderUpdate(newState));
  }

  @override
  OrderState? fromJson(Map<String, dynamic> json) {
    return OrderState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(OrderState state) {
    return state.toJson();
  }
}
