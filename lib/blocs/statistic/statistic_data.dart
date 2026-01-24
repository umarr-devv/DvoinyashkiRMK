part of 'statistic_cubit.dart';

@JsonSerializable()
class StatisticCheckSumAggregate {
  StatisticCheckSumAggregate({required this.period, required this.totalSum});

  final DateTime period;
  final double totalSum;

  static List<StatisticCheckSumAggregate> aggregateByDay(
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
        .map(
          (e) => StatisticCheckSumAggregate(period: e.key, totalSum: e.value),
        )
        .toList()
      ..sort((a, b) => a.period.compareTo(b.period));
  }

  static List<StatisticCheckSumAggregate> aggregateByHour(
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
        .map(
          (e) => StatisticCheckSumAggregate(period: e.key, totalSum: e.value),
        )
        .toList()
      ..sort((a, b) => a.period.compareTo(b.period));
  }

  factory StatisticCheckSumAggregate.fromJson(Map<String, dynamic> json) =>
      _$StatisticCheckSumAggregateFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticCheckSumAggregateToJson(this);
}
