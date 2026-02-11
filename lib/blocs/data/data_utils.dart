part of 'data_cubit.dart';

class DataCubitUtils {
  static List<PriceData> getActualPrices(
    List<PriceScheme> prices,
    List<PriceTypeScheme> priceTypes,
  ) {
    final priceTypeByKey = {for (final type in priceTypes) type.refKey: type};

    final Map<String, PriceScheme> latestByType = {};

    for (final price in prices) {
      final existing = latestByType[price.priceTypeKey];

      if (existing == null || price.period.isAfter(existing.period)) {
        latestByType[price.priceTypeKey] = price;
      }
    }

    return latestByType.entries.map((entry) {
      return PriceData(price: entry.value, type: priceTypeByKey[entry.key]);
    }).toList();
  }

  static List<ProductData> getProducts({
    required List<NomenclatureScheme> nomenclatures,
    required List<CharacteristicScheme> characteristics,
    required List<PriceScheme> prices,
    required List<ProductImageScheme> productImages,
    required List<BarcodeScheme> barcodes,
    required List<PriceTypeScheme> priceTypes,
  }) {
    final List<ProductData> products = [];

    for (final nomen in nomenclatures) {
      final chars = characteristics
          .where((i) => i.owner == nomen.refKey || i.owner == nomen.categoryKey)
          .toList();

      if (chars.isNotEmpty) {
        for (final char in chars) {
          List<PriceScheme> prices_ = prices
              .where(
                (i) =>
                    i.nomenclatureKey == nomen.refKey &&
                    i.characteristicKey == char.refKey,
              )
              .toList();
          if (prices_.isEmpty) {
            prices_ = prices
                .where((i) => i.nomenclatureKey == nomen.refKey)
                .toList();
          }
          final actualPrices = getActualPrices(prices_, priceTypes);
          final barcodes_ = barcodes
              .where(
                (i) =>
                    i.nomenclatureKey == nomen.refKey &&
                    i.characteristicKey == char.refKey,
              )
              .toList();
          final images_ = productImages
              .where(
                (i) =>
                    i.nomenclatureKey == nomen.refKey &&
                    i.characteristicKey == char.refKey,
              )
              .toList();
          final product = ProductData(
            nomenclature: nomen,
            characteristic: char,
            prices: actualPrices,
            barcodes: barcodes_,
            images: images_,
          );
          products.add(product);
        }
      } else {
        final prices_ = prices
            .where((i) => i.nomenclatureKey == nomen.refKey)
            .toList();
        final actualPrices = getActualPrices(prices_, priceTypes);
        final barcodes_ = barcodes
            .where((i) => i.nomenclatureKey == nomen.refKey)
            .toList();
        final images_ = productImages
            .where((i) => i.nomenclatureKey == nomen.refKey)
            .toList();
        final product = ProductData(
          nomenclature: nomen,
          characteristic: null,
          prices: actualPrices,
          barcodes: barcodes_,
          images: images_,
        );
        products.add(product);
      }
    }

    return products;
  }
}
