// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryScheme _$CategorySchemeFromJson(Map<String, dynamic> json) =>
    CategoryScheme(
      refKey: json['Ref_Key'] as String,
      name: json['Description'] as String,
    );

Map<String, dynamic> _$CategorySchemeToJson(CategoryScheme instance) =>
    <String, dynamic>{'Ref_Key': instance.refKey, 'Description': instance.name};

CategoryListScheme _$CategoryListSchemeFromJson(Map<String, dynamic> json) =>
    CategoryListScheme(
      categories: (json['value'] as List<dynamic>)
          .map((e) => CategoryScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryListSchemeToJson(CategoryListScheme instance) =>
    <String, dynamic>{'value': instance.categories};
