// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserScheme _$UserSchemeFromJson(Map<String, dynamic> json) => UserScheme(
  refKey: json['Ref_Key'] as String,
  description: json['Description'] as String,
  inn: json['ИНН'] as String?,
  barcode: json['ШтрихКод'] as String?,
);

Map<String, dynamic> _$UserSchemeToJson(UserScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Description': instance.description,
      'ИНН': instance.inn,
      'ШтрихКод': instance.barcode,
    };

UserListSceheme _$UserListScehemeFromJson(Map<String, dynamic> json) =>
    UserListSceheme(
      users: (json['value'] as List<dynamic>)
          .map((e) => UserScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserListScehemeToJson(UserListSceheme instance) =>
    <String, dynamic>{'value': instance.users};
