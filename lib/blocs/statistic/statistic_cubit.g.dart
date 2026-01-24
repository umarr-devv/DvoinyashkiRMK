// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticCheckSumAggregate _$StatisticCheckSumAggregateFromJson(
  Map<String, dynamic> json,
) => StatisticCheckSumAggregate(
  period: DateTime.parse(json['period'] as String),
  totalSum: (json['total_sum'] as num).toDouble(),
);

Map<String, dynamic> _$StatisticCheckSumAggregateToJson(
  StatisticCheckSumAggregate instance,
) => <String, dynamic>{
  'period': instance.period.toIso8601String(),
  'total_sum': instance.totalSum,
};

StatisticState _$StatisticStateFromJson(
  Map<String, dynamic> json,
) => StatisticState(
  checks:
      (json['checks'] as List<dynamic>?)
          ?.map((e) => StatisticCheckScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  checkSums:
      (json['check_sums'] as List<dynamic>?)
          ?.map(
            (e) =>
                StatisticCheckSumAggregate.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$StatisticStateToJson(StatisticState instance) =>
    <String, dynamic>{
      'checks': instance.checks,
      'check_sums': instance.checkSums,
    };
