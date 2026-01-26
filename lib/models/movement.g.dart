// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovementScheme _$MovementSchemeFromJson(Map<String, dynamic> json) =>
    MovementScheme(
      refKey: json['Ref_Key'] as String,
      number: json['Number'] as String,
      date: DateTime.parse(json['Date'] as String),
      posted: json['Posted'] as bool,
      authorKey: json['Автор_Key'] as String,
      userKey: json['Ответственный_Key'] as String,
      statusKey: json['СостояниеЗаказа_Key'] as String,
      recipientStructureUnitKey:
          json['СтруктурнаяЕдиницаПолучатель_Key'] as String,
      reserveStructureUnitKey: json['СтруктурнаяЕдиницаРезерв_Key'] as String,
      movementDate: DateTime.parse(json['ДатаПеремещения'] as String),
      documentSum: (json['СуммаДокумента'] as num).toDouble(),
    );

Map<String, dynamic> _$MovementSchemeToJson(MovementScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Number': instance.number,
      'Date': instance.date.toIso8601String(),
      'Posted': instance.posted,
      'Автор_Key': instance.authorKey,
      'Ответственный_Key': instance.userKey,
      'СостояниеЗаказа_Key': instance.statusKey,
      'СтруктурнаяЕдиницаРезерв_Key': instance.reserveStructureUnitKey,
      'СтруктурнаяЕдиницаПолучатель_Key': instance.recipientStructureUnitKey,
      'ДатаПеремещения': instance.movementDate.toIso8601String(),
      'СуммаДокумента': instance.documentSum,
    };

MovementItemScheme _$MovementItemSchemeFromJson(Map<String, dynamic> json) =>
    MovementItemScheme(
      refKey: json['Ref_Key'] as String,
      nomenclatureKey: json['Номенклатура_Key'] as String,
      characteristicKey: json['Характеристика_Key'] as String,
      quantity: (json['Количество'] as num).toDouble(),
      price: (json['Цена'] as num).toDouble(),
      totalSum: (json['Сумма'] as num).toDouble(),
    );

Map<String, dynamic> _$MovementItemSchemeToJson(MovementItemScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Номенклатура_Key': instance.nomenclatureKey,
      'Характеристика_Key': instance.characteristicKey,
      'Количество': instance.quantity,
      'Цена': instance.price,
      'Сумма': instance.totalSum,
    };

DetailMovementScheme _$DetailMovementSchemeFromJson(
  Map<String, dynamic> json,
) => DetailMovementScheme(
  refKey: json['Ref_Key'] as String,
  number: json['Number'] as String,
  date: DateTime.parse(json['Date'] as String),
  posted: json['Posted'] as bool,
  authorKey: json['Автор_Key'] as String,
  userKey: json['Ответственный_Key'] as String,
  statusKey: json['СостояниеЗаказа_Key'] as String,
  recipientStructureUnitKey: json['СтруктурнаяЕдиницаПолучатель_Key'] as String,
  reserveStructureUnitKey: json['СтруктурнаяЕдиницаРезерв_Key'] as String,
  movementDate: DateTime.parse(json['ДатаПеремещения'] as String),
  documentSum: (json['СуммаДокумента'] as num).toDouble(),
  items: (json['Запасы'] as List<dynamic>)
      .map((e) => MovementItemScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DetailMovementSchemeToJson(
  DetailMovementScheme instance,
) => <String, dynamic>{
  'Ref_Key': instance.refKey,
  'Number': instance.number,
  'Date': instance.date.toIso8601String(),
  'Posted': instance.posted,
  'Автор_Key': instance.authorKey,
  'Ответственный_Key': instance.userKey,
  'СостояниеЗаказа_Key': instance.statusKey,
  'СтруктурнаяЕдиницаРезерв_Key': instance.reserveStructureUnitKey,
  'СтруктурнаяЕдиницаПолучатель_Key': instance.recipientStructureUnitKey,
  'ДатаПеремещения': instance.movementDate.toIso8601String(),
  'СуммаДокумента': instance.documentSum,
  'Запасы': instance.items,
};

MovementListScheme _$MovementListSchemeFromJson(Map<String, dynamic> json) =>
    MovementListScheme(
      movements: (json['value'] as List<dynamic>)
          .map((e) => MovementScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovementListSchemeToJson(MovementListScheme instance) =>
    <String, dynamic>{'value': instance.movements};

MovementStatusScheme _$MovementStatusSchemeFromJson(
  Map<String, dynamic> json,
) => MovementStatusScheme(
  refKey: json['Ref_Key'] as String,
  description: json['Description'] as String,
);

Map<String, dynamic> _$MovementStatusSchemeToJson(
  MovementStatusScheme instance,
) => <String, dynamic>{
  'Ref_Key': instance.refKey,
  'Description': instance.description,
};

MovementStatusListScheme _$MovementStatusListSchemeFromJson(
  Map<String, dynamic> json,
) => MovementStatusListScheme(
  statuses: (json['value'] as List<dynamic>)
      .map((e) => MovementStatusScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovementStatusListSchemeToJson(
  MovementStatusListScheme instance,
) => <String, dynamic>{'value': instance.statuses};
