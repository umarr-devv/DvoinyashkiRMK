part of 'statistic_cubit.dart';

@JsonSerializable()
class StatisticCheckSumData {
  StatisticCheckSumData({required this.period, required this.totalSum});

  final DateTime period;
  final double totalSum;

  static List<StatisticCheckSumData> aggregateByDay(
    List<StatisticCheckScheme> items,
  ) {
    final Map<DateTime, double> map = {};

    for (final item in items) {
      final date = DateTime(item.date.year, item.date.month, item.date.day);

      map.update(
        date,
        (value) => value + item.documentSum,
        ifAbsent: () => item.documentSum,
      );
    }

    return map.entries
        .map((e) => StatisticCheckSumData(period: e.key, totalSum: e.value))
        .toList()
      ..sort((a, b) => a.period.compareTo(b.period));
  }

  static List<StatisticCheckSumData> aggregateByHour(
    List<StatisticCheckScheme> items,
  ) {
    final Map<DateTime, double> map = {};

    for (final item in items) {
      final date = DateTime(
        item.date.year,
        item.date.month,
        item.date.day,
        item.date.hour,
      );

      map.update(
        date,
        (value) => value + item.documentSum,
        ifAbsent: () => item.documentSum,
      );
    }

    return map.entries
        .map((e) => StatisticCheckSumData(period: e.key, totalSum: e.value))
        .toList()
      ..sort((a, b) => a.period.compareTo(b.period));
  }

  factory StatisticCheckSumData.fromJson(Map<String, dynamic> json) =>
      _$StatisticCheckSumDataFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticCheckSumDataToJson(this);
}

@JsonSerializable()
class StatisticUserData {
  StatisticUserData({
    required this.userKey,
    required this.checkCount,
    required this.totalSum,
  });

  final String userKey;
  final int checkCount;
  final double totalSum;

  static List<StatisticUserData> aggregateByUser(
    List<StatisticCheckScheme> checks,
  ) {
    final Map<String, StatisticUserData> map = {};

    for (final check in checks) {
      final userId = check.userKey;

      if (map.containsKey(userId)) {
        final existing = map[userId]!;

        map[userId] = StatisticUserData(
          userKey: userId,
          checkCount: existing.checkCount + 1,
          totalSum: existing.totalSum + check.documentSum,
        );
      } else {
        map[userId] = StatisticUserData(
          userKey: userId,
          checkCount: 1,
          totalSum: check.documentSum,
        );
      }
    }

    return map.values.toList();
  }

  factory StatisticUserData.fromJson(Map<String, dynamic> json) =>
      _$StatisticUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticUserDataToJson(this);
}

@JsonSerializable()
class StatisticItemData {
  StatisticItemData({
    required this.nomenclatureKey,
    required this.characteristicKey,
    required this.totalSum,
    required this.totalQuantity,
  });

  final String nomenclatureKey;
  final String? characteristicKey;
  final double totalQuantity;
  final double totalSum;

  static List<StatisticItemData> aggregateByNomen(List<CheckItemScheme> items) {
    final Map<String, StatisticItemData> map = {};

    for (final item in items) {
      final key = '${item.nomenclatureKey}|${item.characteriticKey}';

      if (map.containsKey(key)) {
        final existing = map[key]!;

        map[key] = StatisticItemData(
          nomenclatureKey: existing.nomenclatureKey,
          characteristicKey: existing.characteristicKey,
          totalQuantity: existing.totalQuantity + item.quantity,
          totalSum: existing.totalSum + item.itemSum,
        );
      } else {
        map[key] = StatisticItemData(
          nomenclatureKey: item.nomenclatureKey,
          characteristicKey: item.characteriticKey,
          totalQuantity: item.quantity,
          totalSum: item.itemSum,
        );
      }
    }

    return map.values.toList();
  }

  factory StatisticItemData.fromJson(Map<String, dynamic> json) =>
      _$StatisticItemDataFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticItemDataToJson(this);
}
