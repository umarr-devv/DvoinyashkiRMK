part of 'create_movement_cubit.dart';

class CreateMovementItemData extends Equatable {
  const CreateMovementItemData({required this.product, required this.quantity});

  final ProductData product;
  final double quantity;

  double get totalSum => (product.sellPrice?.price.price ?? 0) * quantity;

  CreateMovementItemData copyWith(double newQuantity) {
    return CreateMovementItemData(product: product, quantity: newQuantity);
  }

  @override
  List<Object?> get props => [product.uniqueId];
}
