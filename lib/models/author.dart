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
