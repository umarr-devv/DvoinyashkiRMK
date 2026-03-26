// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserScheme _$UserSchemeFromJson(Map<String, dynamic> json) => UserScheme(
  refKey: json['Ref_Key'] as String,
  description: json['Description'] as String,
  inn: json['ИНН'] as String?,
  barcode: json['ШтрихКод'] as String?,
  departmentKey: json['Подразделение_Key'] as String?,
  warehouseKey: json['Склад_Key'] as String?,
  positionKey: json['Должность_Key'] as String?,
  code: json['МагнитныйКод'] as String?,
);

Map<String, dynamic> _$UserSchemeToJson(UserScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Description': instance.description,
      'ИНН': instance.inn,
      'ШтрихКод': instance.barcode,
      'Склад_Key': instance.warehouseKey,
      'Подразделение_Key': instance.departmentKey,
      'Должность_Key': instance.positionKey,
      'МагнитныйКод': instance.code,
    };

DetailUserScheme _$DetailUserSchemeFromJson(Map<String, dynamic> json) =>
    DetailUserScheme(
      refKey: json['Ref_Key'] as String,
      description: json['Description'] as String,
      inn: json['ИНН'] as String?,
      barcode: json['ШтрихКод'] as String?,
      jobTitle: json['ДолжностьОбмен'] as String?,
      department: json['ПодразделениеОбмен'] as String?,
      departmentKey: json['Подразделение_Key'] as String?,
      warehouseKey: json['Склад_Key'] as String?,
      positionKey: json['Должность_Key'] as String?,
      image: json['Фотография_Base64Data'] as String?,
      code: json['МагнитныйКод'] as String?,
    );

Map<String, dynamic> _$DetailUserSchemeToJson(DetailUserScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Description': instance.description,
      'ИНН': instance.inn,
      'ШтрихКод': instance.barcode,
      'Склад_Key': instance.warehouseKey,
      'Подразделение_Key': instance.departmentKey,
      'Должность_Key': instance.positionKey,
      'МагнитныйКод': instance.code,
      'ДолжностьОбмен': instance.jobTitle,
      'ПодразделениеОбмен': instance.department,
      'Фотография_Base64Data': instance.image,
    };

UserListScheme _$UserListSchemeFromJson(Map<String, dynamic> json) =>
    UserListScheme(
      users: (json['value'] as List<dynamic>)
          .map((e) => UserScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserListSchemeToJson(UserListScheme instance) =>
    <String, dynamic>{'value': instance.users};
