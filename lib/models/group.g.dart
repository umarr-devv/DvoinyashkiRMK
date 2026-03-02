// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupScheme _$GroupSchemeFromJson(Map<String, dynamic> json) => GroupScheme(
  refKey: json['Ref_Key'] as String,
  name: json['Description'] as String,
  groupKey: json['Parent_Key'] as String?,
);

Map<String, dynamic> _$GroupSchemeToJson(GroupScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Description': instance.name,
      'Parent_Key': instance.groupKey,
    };

GroupListScheme _$GroupListSchemeFromJson(Map<String, dynamic> json) =>
    GroupListScheme(
      value: (json['value'] as List<dynamic>)
          .map((e) => GroupScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupListSchemeToJson(GroupListScheme instance) =>
    <String, dynamic>{'value': instance.value};
