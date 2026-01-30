// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_work_shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateWorkShiftScheme _$UpdateWorkShiftSchemeFromJson(
  Map<String, dynamic> json,
) => UpdateWorkShiftScheme(
  authorKey: json['Автор_Key'] as String?,
  userKey: json['Ответственный_Key'] as String?,
  subdivisionKey: json['Подразделение_Key'] as String?,
  storeKey: json['СтруктурнаяЕдиница_Key'] as String?,
  status: json['СтатусКассовойСмены'] as String?,
  workShiftEnd: json['ОкончаниеКассовойСмены'] == null
      ? null
      : DateTime.parse(json['ОкончаниеКассовойСмены'] as String),
  articleKey:
      json['Статья_Key'] as String? ?? '436b4222-3377-11ed-91a8-a068f8f3337c',
  operationKey:
      json['ХозяйственнаяОперация_Key'] as String? ??
      '43f6fc4d-4a0d-11ed-a839-18d6c704b66b',
);

Map<String, dynamic> _$UpdateWorkShiftSchemeToJson(
  UpdateWorkShiftScheme instance,
) => <String, dynamic>{
  'Автор_Key': ?instance.authorKey,
  'Ответственный_Key': ?instance.userKey,
  'Подразделение_Key': ?instance.subdivisionKey,
  'Статья_Key': ?instance.articleKey,
  'СтруктурнаяЕдиница_Key': ?instance.storeKey,
  'ХозяйственнаяОперация_Key': ?instance.operationKey,
  'СтатусКассовойСмены': ?instance.status,
  'ОкончаниеКассовойСмены': ?instance.workShiftEnd?.toIso8601String(),
};
