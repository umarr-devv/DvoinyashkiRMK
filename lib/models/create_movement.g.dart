// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_movement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMovementScheme _$CreateMovementSchemeFromJson(
  Map<String, dynamic> json,
) => CreateMovementScheme(
  date: DateTime.parse(json['Date'] as String),
  authorKey: json['Автор_Key'] as String,
  userKey: json['Ответственный_Key'] as String,
  statusKey: json['СостояниеЗаказа_Key'] as String,
  reserveStructureUnitKey: json['СтруктурнаяЕдиницаРезерв_Key'] as String,
  operationKey: json['ХозяйственнаяОперация_Key'] as String,
  storeKey: json['СтруктурнаяЕдиницаПолучатель_Key'] as String,
  movementDate: DateTime.parse(json['ДатаПеремещения'] as String),
  items: (json['Запасы'] as List<dynamic>)
      .map((e) => CreateMovementItemScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreateMovementSchemeToJson(
  CreateMovementScheme instance,
) => <String, dynamic>{
  'Date': instance.date.toIso8601String(),
  'Автор_Key': instance.authorKey,
  'Ответственный_Key': instance.userKey,
  'СостояниеЗаказа_Key': instance.statusKey,
  'СтруктурнаяЕдиницаРезерв_Key': instance.reserveStructureUnitKey,
  'ХозяйственнаяОперация_Key': instance.operationKey,
  'СтруктурнаяЕдиницаПолучатель_Key': instance.storeKey,
  'ДатаПеремещения': instance.movementDate.toIso8601String(),
  'Запасы': instance.items,
};

CreateMovementItemScheme _$CreateMovementItemSchemeFromJson(
  Map<String, dynamic> json,
) => CreateMovementItemScheme(
  lineNumber: (json['LineNumber'] as num).toInt(),
  nomenclatureKey: json['Номенклатура_Key'] as String,
  characteristicKey: json['Характеристика_Key'] as String,
  unitKey: json['ЕдиницаИзмерения'] as String,
  quantity: (json['Количество'] as num).toDouble(),
  price: (json['Цена'] as num).toDouble(),
  totalSum: (json['Сумма'] as num).toDouble(),
);

Map<String, dynamic> _$CreateMovementItemSchemeToJson(
  CreateMovementItemScheme instance,
) => <String, dynamic>{
  'LineNumber': instance.lineNumber,
  'Номенклатура_Key': instance.nomenclatureKey,
  'Характеристика_Key': instance.characteristicKey,
  'ЕдиницаИзмерения': instance.unitKey,
  'Количество': instance.quantity,
  'Цена': instance.price,
  'Сумма': instance.totalSum,
};
