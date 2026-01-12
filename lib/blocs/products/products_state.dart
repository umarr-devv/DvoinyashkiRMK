part of 'products_cubit.dart';

@JsonSerializable()
class ProductsState extends Equatable {
  const ProductsState({
    this.nomenclatures = const [],
    this.characteristics = const [],
    this.prices = const [],
    this.priceTypes = const [],
    this.barcodes = const [],
    this.update,
  });

  final List<NomenclatureScheme> nomenclatures;
  final List<CharacteristicScheme> characteristics;
  final List<PriceScheme> prices;
  final List<PriceTypeScheme> priceTypes;
  final List<BarcodeScheme> barcodes;
  final DateTime? update;

  ProductsState copyWith({
    List<NomenclatureScheme>? nomenclatures,
    List<CharacteristicScheme>? characteristics,
    List<PriceScheme>? prices,
    List<PriceTypeScheme>? priceTypes,
    List<BarcodeScheme>? barcodes,
    DateTime? update,
  }) {
    return ProductsState(
      nomenclatures: nomenclatures ?? this.nomenclatures,
      characteristics: characteristics ?? this.characteristics,
      prices: prices ?? this.prices,
      priceTypes: priceTypes ?? this.priceTypes,
      barcodes: barcodes ?? this.barcodes,
      update: update ?? this.update,
    );
  }

  ProductsState.from(ProductsState other)
    : nomenclatures = other.nomenclatures,
      characteristics = other.characteristics,
      prices = other.prices,
      priceTypes = other.priceTypes,
      barcodes = other.barcodes,
      update = other.update;

  factory ProductsState.fromJson(Map<String, dynamic> json) =>
      _$ProductsStateFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsStateToJson(this);

  @override
  List<Object?> get props => [
    nomenclatures,
    characteristics,
    prices,
    priceTypes,
    barcodes,
    update,
  ];
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
