import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryScheme {
  CategoryScheme({required this.refKey, required this.name});

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String name;

  factory CategoryScheme.fromJson(Map<String, dynamic> json) =>
      _$CategorySchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CategorySchemeToJson(this);
}
