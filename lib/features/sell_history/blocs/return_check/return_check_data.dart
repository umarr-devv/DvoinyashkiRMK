part of 'return_check_cubit.dart';

class ReturnCheckItemData extends Equatable {
  const ReturnCheckItemData({
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.quantity,
    required this.price,
    required this.unitKey,
  });

  final String nomenclatureKey;
  final String? characteristicKey;
  final double quantity;
  final double price;
  final String unitKey;

  ReturnCheckItemData copyWith(double newQuantity) {
    return ReturnCheckItemData(
      nomenclatureKey: nomenclatureKey,
      characteristicKey: characteristicKey,
      quantity: newQuantity,
      price: price,
      unitKey: unitKey,
    );
  }

  double get totalSum => quantity * price;

  @override
  List<Object?> get props => [nomenclatureKey, characteristicKey];
}
