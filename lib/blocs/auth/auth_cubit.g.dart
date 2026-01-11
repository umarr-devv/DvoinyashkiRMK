// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) => AuthState(
  user: json['user'] == null
      ? null
      : DetailUserScheme.fromJson(json['user'] as Map<String, dynamic>),
  lastUsers:
      (json['last_users'] as List<dynamic>?)
          ?.map((e) => DetailUserScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
  'user': instance.user,
  'last_users': instance.lastUsers,
};
