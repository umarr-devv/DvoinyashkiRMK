// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckScheme _$CheckSchemeFromJson(Map<String, dynamic> json) => CheckScheme(
  refKey: json['Ref_Key'] as String,
  number: json['Number'] as String,
  date: DateTime.parse(json['Date'] as String),
  cashRegisterKey: json['КассаККМ_Key'] as String,
  userKey: json['Кассир_Key'] as String,
  cashRegisterSessionKey: json['КассоваяСмена_Key'] as String,
  udsClient: json['КлиентUDS'] as String,
  udsDiscountCode: json['КодСкидкиUDS'] as String,
  udsDiscount: json['СкидкаUDS'] as String,
  udsSumPayment: json['СуммаОплатUDS'] as String,
  cash: (json['Наличные'] as num).toDouble(),
  userInn: json['ОбменИННКассира'] as String,
  shop: json['ОбменМагазин'] as String,
  cashPayment: (json['ПолученоНаличными'] as num).toDouble(),
  cashlessPayment: (json['ПолученоЭлектронно'] as num).toDouble(),
  change: (json['Сдача'] as num).toDouble(),
  status: json['Статус'] as String,
  includeNDS: json['СуммаВключаетНДС'] as bool,
  documentSum: (json['СуммаДокумента'] as num).toDouble(),
  paymentType: json['ФормаОплаты'] as String,
  itemsAsString: json['Состав'] as String,
);

Map<String, dynamic> _$CheckSchemeToJson(CheckScheme instance) =>
    <String, dynamic>{
      'Ref_Key': instance.refKey,
      'Number': instance.number,
      'Date': instance.date.toIso8601String(),
      'КассаККМ_Key': instance.cashRegisterKey,
      'Кассир_Key': instance.userKey,
      'КассоваяСмена_Key': instance.cashRegisterSessionKey,
      'КлиентUDS': instance.udsClient,
      'КодСкидкиUDS': instance.udsDiscountCode,
      'СкидкаUDS': instance.udsDiscount,
      'СуммаОплатUDS': instance.udsSumPayment,
      'Наличные': instance.cash,
      'ОбменИННКассира': instance.userInn,
      'ОбменМагазин': instance.shop,
      'ПолученоНаличными': instance.cashPayment,
      'ПолученоЭлектронно': instance.cashlessPayment,
      'Сдача': instance.change,
      'Статус': instance.status,
      'СуммаВключаетНДС': instance.includeNDS,
      'СуммаДокумента': instance.documentSum,
      'ФормаОплаты': instance.paymentType,
      'Состав': instance.itemsAsString,
    };

CheckListScheme _$CheckListSchemeFromJson(Map<String, dynamic> json) =>
    CheckListScheme(
      checks: (json['value'] as List<dynamic>)
          .map((e) => CheckScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckListSchemeToJson(CheckListScheme instance) =>
    <String, dynamic>{'value': instance.checks};
