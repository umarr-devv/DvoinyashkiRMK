// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'data_cubit.dart';

@JsonSerializable()
class DataState extends Equatable {
  const DataState({
    this.cashRegisters = const [],
    this.categories = const [],
    this.nomenclatures = const [],
    this.characteristics = const [],
    this.prices = const [],
    this.priceTypes = const [],
    this.barcodes = const [],
    this.structureUnits = const [],
    this.productImages = const [],
    this.users = const [],
    this.authors = const [],
    this.products = const [],
    this.update,
  });
  final List<CashRegisterScheme> cashRegisters;
  final List<CategoryScheme> categories;
  final List<NomenclatureScheme> nomenclatures;
  final List<CharacteristicScheme> characteristics;
  final List<PriceScheme> prices;
  final List<PriceTypeScheme> priceTypes;
  final List<BarcodeScheme> barcodes;
  final List<StructureUnitScheme> structureUnits;
  final List<ProductImageScheme> productImages;
  final List<UserScheme> users;
  final List<AuthorScheme> authors;

  final List<ProductData> products;

  final DateTime? update;

  DataState copyWith({
    List<CashRegisterScheme>? cashRegisters,
    List<CategoryScheme>? categories,
    List<NomenclatureScheme>? nomenclatures,
    List<CharacteristicScheme>? characteristics,
    List<PriceScheme>? prices,
    List<PriceTypeScheme>? priceTypes,
    List<BarcodeScheme>? barcodes,
    List<StructureUnitScheme>? structureUnits,
    List<ProductImageScheme>? productImages,
    List<UserScheme>? users,
    List<AuthorScheme>? authors,
    List<ProductData>? products,
    DateTime? update,
  }) {
    return DataState(
      cashRegisters: cashRegisters ?? this.cashRegisters,
      categories: categories ?? this.categories,
      nomenclatures: nomenclatures ?? this.nomenclatures,
      characteristics: characteristics ?? this.characteristics,
      prices: prices ?? this.prices,
      priceTypes: priceTypes ?? this.priceTypes,
      barcodes: barcodes ?? this.barcodes,
      structureUnits: structureUnits ?? this.structureUnits,
      productImages: productImages ?? this.productImages,
      users: users ?? this.users,
      authors: authors ?? this.authors,
      products: products ?? this.products,
      update: update ?? this.update,
    );
  }

  DataState.from(DataState other)
    : cashRegisters = other.cashRegisters,
      categories = other.categories,
      nomenclatures = other.nomenclatures,
      characteristics = other.characteristics,
      prices = other.prices,
      priceTypes=other.priceTypes,
      barcodes = other.barcodes,
      structureUnits = other.structureUnits,
      productImages = other.productImages,
      users = other.users,
      authors = other.authors,
      products = other.products,
      update = other.update;

  factory DataState.fromJson(Map<String, dynamic> json) =>
      _$DataStateFromJson(json);

  Map<String, dynamic> toJson() => _$DataStateToJson(this);

  @override
  List<Object?> get props => [
    cashRegisters,
    categories,
    nomenclatures,
    characteristics,
    prices,
    priceTypes,
    barcodes,
    structureUnits,
    productImages,
    users,
    authors,
    products,
    update,
  ];
}

final class DataInitial extends DataState {}

final class DataLoading extends DataState {
  DataLoading(super.state) : super.from();
}

final class DataLoaded extends DataState {
  DataLoaded(super.state) : super.from();
}

final class DataFailure extends DataState {
  DataFailure(super.state) : super.from();
}
