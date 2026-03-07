part of 'detail_session_cubit.dart';

class DetailSessionState extends Equatable {
  const DetailSessionState({
    this.workShift,
    this.withdraws = const [],
    this.startWarehouseItems = const [],
    this.endWarehouseItems = const [],
    this.startCashes = const [],
    this.endCashes = const [],
  });

  final DetailWorkShiftScheme? workShift;
  final List<WithdrawScheme> withdraws;
  final List<WarehouseItemScheme> startWarehouseItems;
  final List<WarehouseItemScheme> endWarehouseItems;
  final List<CashScheme> startCashes;
  final List<CashScheme> endCashes;

  DetailSessionState copyWith({
    DetailWorkShiftScheme? workShift,
    List<WithdrawScheme>? withdraws,
    List<WarehouseItemScheme>? startWarehouseItems,
    List<WarehouseItemScheme>? endWarehouseItems,
    List<CashScheme>? startCashes,
    List<CashScheme>? endCashes,
  }) {
    return DetailSessionState(
      workShift: workShift ?? this.workShift,
      withdraws: withdraws ?? this.withdraws,
      startWarehouseItems: startWarehouseItems ?? this.startWarehouseItems,
      endWarehouseItems: endWarehouseItems ?? this.endWarehouseItems,
      startCashes: startCashes ?? this.startCashes,
      endCashes: endCashes ?? this.endCashes,
    );
  }

  double startWarehouseItemsCount() {
    return startWarehouseItems.fold<double>(0, (a, b) => a + b.quantity);
  }

  double endWarehouseItemsCount() {
    return endWarehouseItems.fold<double>(0, (a, b) => a + b.quantity);
  }

  double startWarehouseItemsCash(BuildContext context) {
    return startWarehouseItems.fold<double>(0, (a, b) {
      final product = b.product(context);
      if (product != null) {
        return a + ((product.sellPrice?.price.price ?? 0) * b.quantity);
      }
      return a;
    });
  }

  double endWarehouseItemsCash(BuildContext context) {
    return endWarehouseItems.fold<double>(0, (a, b) {
      final product = b.product(context);
      if (product != null) {
        return a + ((product.sellPrice?.price.price ?? 0) * b.quantity);
      }
      return a;
    });
  }

  DetailSessionState.from(DetailSessionState other)
    : workShift = other.workShift,
      withdraws = other.withdraws,
      startWarehouseItems = other.startWarehouseItems,
      endWarehouseItems = other.endWarehouseItems,
      startCashes = other.startCashes,
      endCashes = other.endCashes;

  @override
  List<Object?> get props => [
    workShift,
    withdraws,
    startWarehouseItems,
    endWarehouseItems,
    startCashes,
    endCashes,
  ];
}

final class DetailSessionInitial extends DetailSessionState {}

final class DetailSessionLoading extends DetailSessionState {
  DetailSessionLoading(super.state) : super.from();
}

final class DetailSessionLoaded extends DetailSessionState {
  DetailSessionLoaded(super.state) : super.from();
}

final class DetailSessionFailure extends DetailSessionState {
  DetailSessionFailure(super.state) : super.from();
}
