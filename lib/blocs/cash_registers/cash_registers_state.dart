// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cash_registers_cubit.dart';

@JsonSerializable()
class CashRegistersState extends Equatable {
  const CashRegistersState({this.cashRegisters = const [], this.update});

  final List<CashRegisterScheme> cashRegisters;
  final DateTime? update;

  CashRegistersState copyWith({
    List<CashRegisterScheme>? cashRegisters,
    DateTime? update,
  }) {
    return CashRegistersState(
      cashRegisters: cashRegisters ?? this.cashRegisters,
      update: update ?? this.update,
    );
  }

  CashRegistersState.from(CashRegistersState other)
    : cashRegisters = other.cashRegisters,
      update = other.update;

  factory CashRegistersState.fromJson(Map<String, dynamic> json) =>
      _$CashRegistersStateFromJson(json);

  Map<String, dynamic> toJson() => _$CashRegistersStateToJson(this);

  @override
  List<Object?> get props => [cashRegisters, update];
}

final class CashRegistersInitial extends CashRegistersState {}

final class CashRegistersLoading extends CashRegistersState {
  CashRegistersLoading(super.state) : super.from();
}

final class CashRegistersLoaded extends CashRegistersState {
  CashRegistersLoaded(super.state) : super.from();
}

final class CashRegistersFailure extends CashRegistersState {
  CashRegistersFailure(super.state) : super.from();
}
