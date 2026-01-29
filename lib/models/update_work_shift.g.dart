// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_work_shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateWorkShiftScheme _$UpdateWorkShiftSchemeFromJson(
  Map<String, dynamic> json,
) => UpdateWorkShiftScheme(
  authorKey: json['Автор_Key'] as String,
  userKey: json['Ответственный_Key'] as String,
  subdivisionKey: json['Подразделение_Key'] as String,
  storeKey: json['СтруктурнаяЕдиница_Key'] as String,
  status: json['СтатусКассовойСмены'] as String?,
);

Map<String, dynamic> _$UpdateWorkShiftSchemeToJson(
  UpdateWorkShiftScheme instance,
) => <String, dynamic>{
  'Автор_Key': instance.authorKey,
  'Ответственный_Key': instance.userKey,
  'Подразделение_Key': instance.subdivisionKey,
  'СтруктурнаяЕдиница_Key': instance.storeKey,
  'СтатусКассовойСмены': ?instance.status,
};
