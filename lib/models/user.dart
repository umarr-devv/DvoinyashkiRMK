import 'dart:typed_data';

import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserScheme extends Equatable {
  const UserScheme({
    required this.refKey,
    required this.description,
    required this.inn,
    required this.barcode,
    required this.departmentKey,
    required this.warehouseKey,
    required this.positionKey,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String description;

  @JsonKey(name: 'ИНН')
  final String? inn;

  @JsonKey(name: 'ШтрихКод')
  final String? barcode;

  @JsonKey(name: 'Склад_Key')
  final String? warehouseKey;

  @JsonKey(name: 'Подразделение_Key')
  final String? departmentKey;

  @JsonKey(name: 'Должность_Key')
  final String? positionKey;

  factory UserScheme.fromJson(Map<String, dynamic> json) =>
      _$UserSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UserSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
// ignore: must_be_immutable
class DetailUserScheme extends UserScheme {
  DetailUserScheme({
    required super.refKey,
    required super.description,
    required super.inn,
    required super.barcode,
    required this.jobTitle,
    required this.department,
    required super.departmentKey,
    required super.warehouseKey,
    required super.positionKey,
    required this.image,
  }) : imageBytes = stringToBytes(image);

  @JsonKey(name: 'ДолжностьОбмен')
  final String? jobTitle;

  @JsonKey(name: 'ПодразделениеОбмен')
  final String? department;

  @JsonKey(name: 'Фотография_Base64Data')
  final String? image;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? imageBytes;

  factory DetailUserScheme.fromJson(Map<String, dynamic> json) =>
      _$DetailUserSchemeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DetailUserSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class UserListScheme {
  UserListScheme({required this.users});

  @JsonKey(name: 'value')
  final List<UserScheme> users;

  factory UserListScheme.fromJson(Map<String, dynamic> json) =>
      _$UserListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UserListSchemeToJson(this);
}
