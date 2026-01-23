import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class AuthorScheme extends Equatable {
  const AuthorScheme({required this.refKey, required this.description});

  @JsonKey(name: 'Ref_Key')
  final String refKey;

  @JsonKey(name: 'Description')
  final String description;

  factory AuthorScheme.fromJson(Map<String, dynamic> json) =>
      _$AuthorSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorSchemeToJson(this);

  @override
  List<Object?> get props => [refKey];
}

@JsonSerializable()
class AuthorListScheme {
  const AuthorListScheme({required this.authors});

  @JsonKey(name: 'value')
  final List<AuthorScheme> authors;

  factory AuthorListScheme.fromJson(Map<String, dynamic> json) =>
      _$AuthorListSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$AAuthorListSchemeToJson(this);
}
