part of 'products_cubit.dart';

class ProductsCubitUtils {
  static List<CharacteristicScheme> getNomenclatureCharacteristics({
    required NomenclatureScheme nomenclature,
    required List<CharacteristicScheme> allCharacteristics,
  }) {
    return allCharacteristics
        .where((i) => i.nomenclatureKey == nomenclature.refKey)
        .toList();
  }

  static List<PriceScheme> getNomenclaturePrices({
    required NomenclatureScheme nomenclature,
    required List<PriceScheme> allPrices,
  }) {
    final filtered = allPrices.where(
      (scheme) => scheme.nomenclatureKey == nomenclature.refKey,
    );

    final Map<String, PriceScheme> latestByType = {};

    for (var scheme in filtered) {
      if (!latestByType.containsKey(scheme.priceTypeKey) ||
          scheme.period.isAfter(latestByType[scheme.priceTypeKey]!.period)) {
        latestByType[scheme.priceTypeKey] = scheme;
      }
    }

    return latestByType.values.toList();
  }

  static List<PriceScheme> getCharacteristicPrices({
    required CharacteristicScheme characteristic,
    required List<PriceScheme> allPrices,
  }) {
    final filtered = allPrices.where(
      (scheme) => scheme.characteristicKey == characteristic.refKey,
    );

    final Map<String, PriceScheme> latestByType = {};

    for (var scheme in filtered) {
      if (!latestByType.containsKey(scheme.priceTypeKey) ||
          scheme.period.isAfter(latestByType[scheme.priceTypeKey]!.period)) {
        latestByType[scheme.priceTypeKey] = scheme;
      }
    }

    return latestByType.values.toList();
  }
}
