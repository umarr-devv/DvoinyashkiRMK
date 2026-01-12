part of 'products_cubit.dart';

List<PriceScheme> getNomenclaturePrices({
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

List<PriceScheme> getCharacteristicPrices({
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
