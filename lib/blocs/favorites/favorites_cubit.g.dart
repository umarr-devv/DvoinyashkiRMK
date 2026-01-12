// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritesState _$FavoritesStateFromJson(Map<String, dynamic> json) =>
    FavoritesState(
      favoriteKeys:
          (json['favorite_keys'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FavoritesStateToJson(FavoritesState instance) =>
    <String, dynamic>{'favorite_keys': instance.favoriteKeys};
