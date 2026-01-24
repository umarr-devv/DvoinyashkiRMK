// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticCheckSumData _$StatisticCheckSumDataFromJson(
  Map<String, dynamic> json,
) => StatisticCheckSumData(
  period: DateTime.parse(json['period'] as String),
  totalSum: (json['total_sum'] as num).toDouble(),
);

Map<String, dynamic> _$StatisticCheckSumDataToJson(
  StatisticCheckSumData instance,
) => <String, dynamic>{
  'period': instance.period.toIso8601String(),
  'total_sum': instance.totalSum,
};

StatisticUserData _$StatisticUserDataFromJson(Map<String, dynamic> json) =>
    StatisticUserData(
      userKey: json['user_key'] as String,
      checkCount: (json['check_count'] as num).toInt(),
      totalSum: (json['total_sum'] as num).toDouble(),
    );

Map<String, dynamic> _$StatisticUserDataToJson(StatisticUserData instance) =>
    <String, dynamic>{
      'user_key': instance.userKey,
      'check_count': instance.checkCount,
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
            (e) => StatisticCheckSumData.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  userSums:
      (json['user_sums'] as List<dynamic>?)
          ?.map((e) => StatisticUserData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  isHourInterval: json['is_hour_interval'] as bool,
);

Map<String, dynamic> _$StatisticStateToJson(StatisticState instance) =>
    <String, dynamic>{
      'checks': instance.checks,
      'check_sums': instance.checkSums,
      'user_sums': instance.userSums,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'is_hour_interval': instance.isHourInterval,
    };
