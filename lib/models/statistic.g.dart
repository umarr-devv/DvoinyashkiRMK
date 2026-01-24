// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticCheckScheme _$StatisticCheckSchemeFromJson(
  Map<String, dynamic> json,
) => StatisticCheckScheme(
  date: DateTime.parse(json['Date'] as String),
  userKey: json['Кассир_Key'] as String,
  udsClient: json['КлиентUDS'] as String,
  documentSum: (json['СуммаДокумента'] as num).toDouble(),
  composition: json['Состав'] as String,
);

Map<String, dynamic> _$StatisticCheckSchemeToJson(
  StatisticCheckScheme instance,
) => <String, dynamic>{
  'Date': instance.date.toIso8601String(),
  'Кассир_Key': instance.userKey,
  'КлиентUDS': instance.udsClient,
  'СуммаДокумента': instance.documentSum,
  'Состав': instance.composition,
};

StatisticCheckListScheme _$StatisticCheckListSchemeFromJson(
  Map<String, dynamic> json,
) => StatisticCheckListScheme(
  checks: (json['value'] as List<dynamic>)
      .map((e) => StatisticCheckScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StatisticCheckListSchemeToJson(
  StatisticCheckListScheme instance,
) => <String, dynamic>{'value': instance.checks};
