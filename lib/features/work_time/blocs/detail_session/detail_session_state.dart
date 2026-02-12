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
