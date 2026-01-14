// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_cubit.dart';

@JsonSerializable()
class ProductsState extends Equatable {
  const ProductsState({this.products = const [], this.update});

  final List<ProductData> products;
  final DateTime? update;

  ProductsState copyWith({List<ProductData>? products, DateTime? update}) {
    return ProductsState(
      products: products ?? this.products,
      update: update ?? this.update,
    );
  }

  ProductsState.from(ProductsState other)
    : products = other.products,
      update = other.update;

  factory ProductsState.fromJson(Map<String, dynamic> json) =>
      _$ProductsStateFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsStateToJson(this);

  @override
  List<Object?> get props => [products, update];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {
  ProductsLoading(super.state) : super.from();
}

final class ProductsLoaded extends ProductsState {
  ProductsLoaded(super.state) : super.from();
}

final class ProductsFailure extends ProductsState {
  ProductsFailure(super.state) : super.from();
}
