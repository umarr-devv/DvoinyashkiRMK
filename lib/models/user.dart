import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserScheme {
  UserScheme({
    required this.refKey,
    required this.description,
    required this.inn,
    required this.barcode,
  });

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String description;

  @JsonKey(name: 'ИНН')
  final String? inn;

  @JsonKey(name: 'ШтрихКод')
  final String? barcode;

  factory UserScheme.fromJson(Map<String, dynamic> json) =>
      _$UserSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UserSchemeToJson(this);
}

@JsonSerializable()
class DetailUserScheme extends UserScheme {
  DetailUserScheme({
    required super.refKey,
    required super.description,
    required super.inn,
    required super.barcode,
    required this.jobTitle,
    required this.department,
    required this.image,
  });

  @JsonKey(name: 'ДолжностьОбмен')
  final String? jobTitle;

  @JsonKey(name: 'ПодразделениеОбмен')
  final String? department;

  @JsonKey(name: 'Фотография_Base64Data')
  final String? image;

  Uint8List? get imageBytes {
    if (image == null || image!.isEmpty) return null;
    try {
      final cleanBase64 = image!.replaceAll(RegExp(r'\s+'), '');

      return base64Decode(cleanBase64);
    } catch (e) {
      return null;
    }
  }

  factory DetailUserScheme.fromJson(Map<String, dynamic> json) =>
      _$DetailUserSchemeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DetailUserSchemeToJson(this);
}

@JsonSerializable()
class UserListSceheme {
  UserListSceheme({required this.users});

  @JsonKey(name: 'value')
  final List<UserScheme> users;

  factory UserListSceheme.fromJson(Map<String, dynamic> json) =>
      _$UserListScehemeFromJson(json);

  Map<String, dynamic> toJson() => _$UserListScehemeToJson(this);
}
