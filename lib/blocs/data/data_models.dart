part of 'data_cubit.dart';

@JsonSerializable()
class PriceData extends Equatable {
  const PriceData({required this.price, required this.type});

  final PriceScheme price;
  final PriceTypeScheme? type;

  factory PriceData.fromJson(Map<String, dynamic> json) =>
      _$PriceDataFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDataToJson(this);

  @override
  List<Object?> get props => [price, type];
}

@JsonSerializable()
class ProductData extends Equatable {
  const ProductData({
    required this.nomenclature,
    this.characteristic,
    this.prices = const [],
    this.barcodes = const [],
    this.specifications = const [],
  });

  final NomenclatureScheme nomenclature;
  final CharacteristicScheme? characteristic;
  final List<PriceData> prices;
  final List<BarcodeScheme> barcodes;
  final List<SpecificationScheme> specifications;

  static const String mainPriceTypeKey = '021f4fa7-3377-11ed-91a8-a068f8f3337c';

  PriceData? get sellPrice =>
      prices.firstWhereLogTypeOrNull((i) => i.type?.refKey == mainPriceTypeKey);

  SpecificationScheme? get currenctSpecification =>
      specifications.elementAtOrNull(0);

  String get name {
    if (characteristic != null) {
      return "${nomenclature.name ?? ''} (${characteristic?.printName ?? ''})";
    } else {
      return nomenclature.name ?? 'Без названия';
    }
  }

  String get uniqueName =>
      '${nomenclature.description} ${characteristic?.description ?? ""}';

  String get uniqueId =>
      nomenclature.refKey + (characteristic?.refKey ?? emptyRefKey);

  WarehouseItemScheme? warehouseItem(BuildContext context) {
    final items = BlocProvider.of<WarehouseCubit>(context).state.items;

    return items.firstWhereLogTypeOrNull((i) => i.uniqueId == uniqueId);
  }

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataToJson(this);

  @override
  List<Object?> get props => [uniqueId];
}
