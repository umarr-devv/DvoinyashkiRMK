// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_check_cubit.dart';

@JsonSerializable()
class CreateCheckState extends Equatable {
  const CreateCheckState({
    required this.paymentType,
    this.totalSum = 0,
    this.udsPoints = 0,
    this.customerPay = 0,
    this.debtUser,
    this.check,
  });

  final PaymentTypeData paymentType;
  final double totalSum;
  final double customerPay;
  final double udsPoints;
  final UserScheme? debtUser;

  final DetailCheckScheme? check;

  double get totalSumToPay => totalSum - udsPoints;
  double get change => customerPay - totalSumToPay;

  CreateCheckState copyWith({
    PaymentTypeData? paymentType,
    double? totalSum,
    double? customerPay,
    double? udsPoints,
    Object? debtUser,
    DetailCheckScheme? check,
  }) {
    return CreateCheckState(
      paymentType: paymentType ?? this.paymentType,
      totalSum: totalSum ?? this.totalSum,
      customerPay: customerPay ?? this.customerPay,
      udsPoints: udsPoints ?? this.udsPoints,
      debtUser: undefCompare<UserScheme?>(debtUser, this.debtUser),
      check: check ?? this.check,
    );
  }

  CreateCheckState.from(CreateCheckState other)
    : paymentType = other.paymentType,
      totalSum = other.totalSum,
      customerPay = other.customerPay,
      udsPoints = other.udsPoints,
      debtUser = other.debtUser,
      check = other.check;

  factory CreateCheckState.fromJson(Map<String, dynamic> json) =>
      _$CreateCheckStateFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCheckStateToJson(this);

  @override
  List<Object?> get props => [
    paymentType,
    totalSum,
    customerPay,
    udsPoints,
    debtUser,
    check,
  ];
}

final class CreateCheckInitial extends CreateCheckState {
  const CreateCheckInitial({required super.paymentType});
}

final class CreateCheckUpdate extends CreateCheckState {
  CreateCheckUpdate(super.state) : super.from();
}

final class CreateCheckLoading extends CreateCheckState {
  CreateCheckLoading(super.state) : super.from();
}

final class CreateCheckLoaded extends CreateCheckState {
  CreateCheckLoaded(super.state) : super.from();
}

final class CreateCheckUdsTransaction extends CreateCheckState {
  CreateCheckUdsTransaction(super.state) : super.from();
}

final class CreateCheckUdsFailure extends CreateCheckState {
  CreateCheckUdsFailure(super.state) : super.from();
}

final class CreateCheckSettingsFailure extends CreateCheckState {
  CreateCheckSettingsFailure(super.state) : super.from();
}

final class CreateCheckSessionFailure extends CreateCheckState {
  CreateCheckSessionFailure(super.state) : super.from();
}

final class CreateCheckFailure extends CreateCheckState {
  CreateCheckFailure(super.state) : super.from();
}

final class CreateCheckOfflineSaved extends CreateCheckState {
  CreateCheckOfflineSaved(super.state) : super.from();
}

final class CreateCheckUdsOfflineNotSupported extends CreateCheckState {
  CreateCheckUdsOfflineNotSupported(super.state) : super.from();
}

final class CreateCheckDebtOfflineNotSupported extends CreateCheckState {
  CreateCheckDebtOfflineNotSupported(super.state) : super.from();
}
