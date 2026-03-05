// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferScheme _$TransferSchemeFromJson(Map<String, dynamic> json) =>
    TransferScheme(
      refKey: json['Ref_Key'] as String,
      number: json['Number'] as String,
      date: DateTime.parse(json['Date'] as String),
      posted: json['Posted'] as bool,
      authorKey: json['Автор_Key'] as String,
      userKey: json['Ответственный_Key'] as String,
      recipientStructureUnitKey:
          json['СтруктурнаяЕдиницаПолучатель_Key'] as String,
      reserveStructureUnitKey: json['СтруктурнаяЕдиница_Key'] as String,
      transferDate: DateTime.parse(json['ДатаПриемки'] as String),
      documentSum: (json['СуммаДокумента'] as num).toDouble(),
      isAccepted: json['Принят'] as bool,
    );

Map<String, dynamic> _$TransferSchemeToJson(TransferScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Number': instance.number,
      'Date': instance.date.toIso8601String(),
      'Posted': instance.posted,
      'Автор_Key': instance.authorKey,
      'Ответственный_Key': instance.userKey,
      'СтруктурнаяЕдиница_Key': instance.reserveStructureUnitKey,
      'СтруктурнаяЕдиницаПолучатель_Key': instance.recipientStructureUnitKey,
      'ДатаПриемки': instance.transferDate.toIso8601String(),
      'СуммаДокумента': instance.documentSum,
      'Принят': instance.isAccepted,
    };

TransferItemScheme _$TransferItemSchemeFromJson(Map<String, dynamic> json) =>
    TransferItemScheme(
      refKey: json['Ref_Key'] as String?,
      nomenclatureKey: json['Номенклатура_Key'] as String,
      characteristicKey: json['Характеристика_Key'] as String,
      quantity: (json['Количество'] as num).toDouble(),
      price: (json['Цена'] as num).toDouble(),
      totalSum: (json['Сумма'] as num).toDouble(),
    );

Map<String, dynamic> _$TransferItemSchemeToJson(TransferItemScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Номенклатура_Key': instance.nomenclatureKey,
      'Характеристика_Key': instance.characteristicKey,
      'Количество': instance.quantity,
      'Цена': instance.price,
      'Сумма': instance.totalSum,
    };

DetailTransferScheme _$DetailTransferSchemeFromJson(
  Map<String, dynamic> json,
) => DetailTransferScheme(
  refKey: json['Ref_Key'] as String,
  number: json['Number'] as String,
  date: DateTime.parse(json['Date'] as String),
  posted: json['Posted'] as bool,
  authorKey: json['Автор_Key'] as String,
  userKey: json['Ответственный_Key'] as String,
  recipientStructureUnitKey: json['СтруктурнаяЕдиницаПолучатель_Key'] as String,
  reserveStructureUnitKey: json['СтруктурнаяЕдиница_Key'] as String,
  transferDate: DateTime.parse(json['ДатаПриемки'] as String),
  documentSum: (json['СуммаДокумента'] as num).toDouble(),
  items: (json['Запасы'] as List<dynamic>)
      .map((e) => TransferItemScheme.fromJson(e as Map<String, dynamic>))
      .toList(),
  isAccepted: json['Принят'] as bool,
);

Map<String, dynamic> _$DetailTransferSchemeToJson(
  DetailTransferScheme instance,
) => <String, dynamic>{
  'Ref_Key': instance.refKey,
  'Number': instance.number,
  'Date': instance.date.toIso8601String(),
  'Posted': instance.posted,
  'Автор_Key': instance.authorKey,
  'Ответственный_Key': instance.userKey,
  'СтруктурнаяЕдиница_Key': instance.reserveStructureUnitKey,
  'СтруктурнаяЕдиницаПолучатель_Key': instance.recipientStructureUnitKey,
  'ДатаПриемки': instance.transferDate.toIso8601String(),
  'СуммаДокумента': instance.documentSum,
  'Принят': instance.isAccepted,
  'Запасы': instance.items,
};

TransferListScheme _$TransferListSchemeFromJson(Map<String, dynamic> json) =>
    TransferListScheme(
      value: (json['value'] as List<dynamic>)
          .map((e) => DetailTransferScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransferListSchemeToJson(TransferListScheme instance) =>
    <String, dynamic>{'value': instance.value};

TransferUpdateScheme _$TransferUpdateSchemeFromJson(
  Map<String, dynamic> json,
) => TransferUpdateScheme(
  transferDate: DateTime.parse(json['ДатаПриемки'] as String),
  isAccepted: json['Принят'] as bool,
);

Map<String, dynamic> _$TransferUpdateSchemeToJson(
  TransferUpdateScheme instance,
) => <String, dynamic>{
  'ДатаПриемки': instance.transferDate.toIso8601String(),
  'Принят': instance.isAccepted,
};
