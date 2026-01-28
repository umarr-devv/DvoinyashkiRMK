// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticCheckSumData _$StatisticCheckSumDataFromJson(
  Map<String, dynamic> json,
) => StatisticCheckSumData(
  period: DateTime.parse(json['period'] as String),
  totalSum: (json['totalSum'] as num).toDouble(),
);

Map<String, dynamic> _$StatisticCheckSumDataToJson(
  StatisticCheckSumData instance,
) => <String, dynamic>{
  'period': instance.period.toIso8601String(),
  'totalSum': instance.totalSum,
};

StatisticUserData _$StatisticUserDataFromJson(Map<String, dynamic> json) =>
    StatisticUserData(
      userKey: json['userKey'] as String,
      checkCount: (json['checkCount'] as num).toInt(),
      totalSum: (json['totalSum'] as num).toDouble(),
    );

Map<String, dynamic> _$StatisticUserDataToJson(StatisticUserData instance) =>
    <String, dynamic>{
      'userKey': instance.userKey,
      'checkCount': instance.checkCount,
      'totalSum': instance.totalSum,
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
      (json['checkSums'] as List<dynamic>?)
          ?.map(
            (e) => StatisticCheckSumData.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  userSums:
      (json['userSums'] as List<dynamic>?)
          ?.map((e) => StatisticUserData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  isHourInterval: json['isHourInterval'] as bool,
);

Map<String, dynamic> _$StatisticStateToJson(StatisticState instance) =>
    <String, dynamic>{
      'checks': instance.checks,
      'checkSums': instance.checkSums,
      'userSums': instance.userSums,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'isHourInterval': instance.isHourInterval,
    };
