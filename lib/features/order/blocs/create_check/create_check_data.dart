part of 'create_check_cubit.dart';

class PaymentTypeData extends Equatable {
  const PaymentTypeData({
    required this.icon,
    required this.label,
    required this.isCash,
    this.isDebt = false,
  });

  final IconData icon;
  final String label;
  final bool isCash;
  final bool isDebt;

  @override
  List<Object?> get props => [label, isCash];
}

final cashPaymentType = const PaymentTypeData(
  icon: FluentIcons.money_24_regular,
  label: 'Наличные',
  isCash: false,
);
final cashlessPaymentType = const PaymentTypeData(
  icon: FluentIcons.payment_24_regular,
  label: 'Безналичные',
  isCash: true,
);
final debtPaymentType = const PaymentTypeData(
  icon: FluentIcons.person_24_regular,
  label: 'Долг',
  isCash: false,
  isDebt: true,
);

final List<PaymentTypeData> paymentTypesList = [
  cashPaymentType,
  cashlessPaymentType,
  debtPaymentType,
];
