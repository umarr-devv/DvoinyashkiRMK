// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesState _$CategoriesStateFromJson(Map<String, dynamic> json) =>
    CategoriesState(
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => CategoryScheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pinned:
          (json['pinned'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      update: json['update'] == null
          ? null
          : DateTime.parse(json['update'] as String),
    );

Map<String, dynamic> _$CategoriesStateToJson(CategoriesState instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'pinned': instance.pinned,
      'update': instance.update?.toIso8601String(),
    };
