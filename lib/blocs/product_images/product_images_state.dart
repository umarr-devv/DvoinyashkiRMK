part of 'product_images_cubit.dart';

@JsonSerializable()
class ProductImagesState extends Equatable {
  const ProductImagesState({this.images = const [], this.update});

  final List<ProductImageScheme> images;
  final DateTime? update;

  ProductImagesState copyWith({
    List<ProductImageScheme>? images,
    DateTime? update,
  }) {
    return ProductImagesState(
      images: images ?? this.images,
      update: update ?? this.update,
    );
  }

  ProductImagesState.from(ProductImagesState other)
    : images = other.images,
      update = other.update;

  @override
  List<Object?> get props => [images, update];

  factory ProductImagesState.fromJson(Map<String, dynamic> json) =>
      _$ProductImagesStateFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImagesStateToJson(this);
}

final class ProductImagesInitial extends ProductImagesState {}

final class ProductImagesLoading extends ProductImagesState {
  ProductImagesLoading(super.state) : super.from();
}

final class ProductImagesLoaded extends ProductImagesState {
  ProductImagesLoaded(super.state) : super.from();
}

final class ProductImagesFailure extends ProductImagesState {
  ProductImagesFailure(super.state) : super.from();
}
