part of 'warehouse_cubit.dart';

class WarehouseState extends Equatable {
  const WarehouseState({this.items = const []});

  final List<WarehouseItemScheme> items;

  WarehouseState copyWith(List<WarehouseItemScheme>? items) {
    return WarehouseState(items: items ?? this.items);
  }

  WarehouseState.from(WarehouseState other) : items = other.items;

  @override
  List<Object?> get props => [items];
}

final class WarehouseInitial extends WarehouseState {}

final class WarehouseLoading extends WarehouseState {
  WarehouseLoading(super.state) : super.from();
}

final class WarehouseLoaded extends WarehouseState {
  WarehouseLoaded(super.state) : super.from();
}

final class WarehouseFailure extends WarehouseState {
  WarehouseFailure(super.state) : super.from();
}
