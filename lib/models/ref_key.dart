import 'package:json_annotation/json_annotation.dart';

part 'ref_key.g.dart';

@JsonSerializable()
class RefKeyScheme {
  RefKeyScheme({required this.refKey, required this.posted});

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Posted')
  final bool? posted;

  factory RefKeyScheme.fromJson(Map<String, dynamic> json) =>
      _$RefKeySchemeFromJson(json);

  Map<String, dynamic> toJson() => _$RefKeySchemeToJson(this);
}

@JsonSerializable()
class RefKeyListScheme {
  RefKeyListScheme({required this.value});

  @JsonKey(name: 'value')
  final List<RefKeyScheme> value;

  factory RefKeyListScheme.fromJson(Map<String, dynamic> json) =>
      _$RefKeyListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$RefKeyListSchemeToJson(this);
}
