import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryScheme extends Equatable{
  const CategoryScheme({required this.refKey, required this.name});

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String name;

  factory CategoryScheme.fromJson(Map<String, dynamic> json) =>
      _$CategorySchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CategorySchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}


@JsonSerializable()
class CategoryListScheme {
  CategoryListScheme({required this.categories});

  @JsonKey(name: 'value')
  final List<CategoryScheme> categories;

  factory CategoryListScheme.fromJson(Map<String, dynamic> json) =>
      _$CategoryListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListSchemeToJson(this);
}