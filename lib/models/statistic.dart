import 'package:json_annotation/json_annotation.dart';

part 'statistic.g.dart';

@JsonSerializable()
class StatisticCheckScheme {
  const StatisticCheckScheme({
    required this.date,
    required this.userRefKey,
    required this.udsClient,
    required this.documentSum,
    required this.composition,
  });

  @JsonKey(name: 'Date')
  final DateTime date;

  @JsonKey(name: 'Кассир_Key')
  final String userRefKey;

  @JsonKey(name: 'КлиентUDS')
  final String udsClient;

  @JsonKey(name: 'СуммаДокумента')
  final double documentSum;

  @JsonKey(name: 'Состав')
  final String composition;

  factory StatisticCheckScheme.fromJson(Map<String, dynamic> json) =>
      _$StatisticCheckSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticCheckSchemeToJson(this);
}

@JsonSerializable()
class StaticticCheckListScheme {
  StaticticCheckListScheme({required this.checks});

  @JsonKey(name: 'value')
  final List<StatisticCheckScheme> checks;

  factory StaticticCheckListScheme.fromJson(Map<String, dynamic> json) =>
      _$StaticticCheckListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$StaticticCheckListSchemeToJson(this);
}
