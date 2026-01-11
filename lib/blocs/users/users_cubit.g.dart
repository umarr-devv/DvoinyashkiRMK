// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersState _$UsersStateFromJson(Map<String, dynamic> json) => UsersState(
  users:
      (json['users'] as List<dynamic>?)
          ?.map((e) => UserScheme.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  update: json['update'] == null
      ? null
      : DateTime.parse(json['update'] as String),
);

Map<String, dynamic> _$UsersStateToJson(UsersState instance) =>
    <String, dynamic>{
      'users': instance.users,
      'update': instance.update?.toIso8601String(),
    };
