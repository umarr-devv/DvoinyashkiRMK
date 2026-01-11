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
class UserListSceheme {
  UserListSceheme({required this.users});

  @JsonKey(name: 'value')
  final List<UserScheme> users;

  factory UserListSceheme.fromJson(Map<String, dynamic> json) =>
      _$UserListScehemeFromJson(json);

  Map<String, dynamic> toJson() => _$UserListScehemeToJson(this);
}
