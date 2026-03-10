// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ref_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefKeyScheme _$RefKeySchemeFromJson(Map<String, dynamic> json) => RefKeyScheme(
  refKey: json['Ref_Key'] as String,
  posted: json['Posted'] as bool?,
);

Map<String, dynamic> _$RefKeySchemeToJson(RefKeyScheme instance) =>
    <String, dynamic>{'Ref_Key': instance.refKey, 'Posted': instance.posted};

RefKeyListScheme _$RefKeyListSchemeFromJson(Map<String, dynamic> json) =>
    RefKeyListScheme(
      value: (json['value'] as List<dynamic>)
          .map((e) => RefKeyScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RefKeyListSchemeToJson(RefKeyListScheme instance) =>
    <String, dynamic>{'value': instance.value};
