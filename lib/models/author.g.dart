// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorScheme _$AuthorSchemeFromJson(Map<String, dynamic> json) => AuthorScheme(
  refKey: json['Ref_Key'] as String,
  description: json['Description'] as String,
);

Map<String, dynamic> _$AuthorSchemeToJson(AuthorScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Description': instance.description,
    };
