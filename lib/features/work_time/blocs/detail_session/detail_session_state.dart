part of 'detail_session_cubit.dart';

class DetailSessionState extends Equatable {
  const DetailSessionState({
    this.workShift,
    this.withdraws = const [],
    this.startWarehouseItems = const [],
    this.endWarehouseItems = const [],
    this.startCashes = const [],
    this.endCashes = const [],
    this.checks = const [],
  });

  final DetailWorkShiftScheme? workShift;
  final List<WithdrawScheme> withdraws;
  final List<WarehouseItemScheme> startWarehouseItems;
  final List<WarehouseItemScheme> endWarehouseItems;
  final List<CashScheme> startCashes;
  final List<CashScheme> endCashes;
  final List<CheckScheme> checks;

  DetailSessionState copyWith({
    DetailWorkShiftScheme? workShift,
    List<WithdrawScheme>? withdraws,
    List<WarehouseItemScheme>? startWarehouseItems,
    List<WarehouseItemScheme>? endWarehouseItems,
    List<CashScheme>? startCashes,
    List<CashScheme>? endCashes,
     List<CheckScheme>? checks,
  }) {
    return DetailSessionState(
      workShift: workShift ?? this.workShift,
      withdraws: withdraws ?? this.withdraws,
      startWarehouseItems: startWarehouseItems ?? this.startWarehouseItems,
      endWarehouseItems: endWarehouseItems ?? this.endWarehouseItems,
      startCashes: startCashes ?? this.startCashes,
      endCashes: endCashes ?? this.endCashes,
      checks: checks ?? this.checks,
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

  double get cashRevenue {
    return checks
        .where((c) => c.paymentType == CheckScheme.cashPaymentType)
        .fold(0.0, (sum, item) => sum + item.documentSum);
  }

  double get cashlessRevenue {
    return checks
        .where((c) => c.paymentType == CheckScheme.cashlessPaymentType)
        .fold(0.0, (sum, item) => sum + item.documentSum);
  }

  DetailSessionState.from(DetailSessionState other)
    : workShift = other.workShift,
      withdraws = other.withdraws,
      startWarehouseItems = other.startWarehouseItems,
      endWarehouseItems = other.endWarehouseItems,
      startCashes = other.startCashes,
      endCashes = other.endCashes,
      checks = other.checks;

  @override
  List<Object?> get props => [
    workShift,
    withdraws,
    startWarehouseItems,
    endWarehouseItems,
    startCashes,
    endCashes,
    checks,
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
