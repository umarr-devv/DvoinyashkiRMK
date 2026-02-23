import 'package:json_annotation/json_annotation.dart';

part 'ref_key.g.dart';

@JsonSerializable()
class RefKeyScheme {
  RefKeyScheme({required this.refKey});

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  factory RefKeyScheme.fromJson(Map<String, dynamic> json) =>
      _$RefKeySchemeFromJson(json);

  Map<String, dynamic> toJson() => _$RefKeySchemeToJson(this);
}
