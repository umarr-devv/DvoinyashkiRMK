// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCheckScheme _$CreateCheckSchemeFromJson(Map<String, dynamic> json) =>
    CreateCheckScheme(
      date: DateTime.parse(json['Date'] as String),
      authorKey: json['Автор_Key'] as String,
      cashRegisterKey: json['КассаККМ_Key'] as String,
      userKey: json['Кассир_Key'] as String,
      sessionKey: json['КассоваяСмена_Key'] as String,
      sessionNumber: (json['НомерСменыККМ'] as num).toInt(),
      udsCustomer: json['КлиентUDS'] as String?,
      udsDiscountCode: json['КодСкидкиUDS'] as String?,
      udsDiscount: (json['СкидкаUDS'] as num).toDouble(),
      comment: json['Комментарий'] as String,
      responsibleKey: json['Ответственный_Key'] as String,
      subdivisionKey: json['Подразделение_Key'] as String,
      customer: json['Покупатель'] as String,
      employeersDebtKey: json['СотрудникДолг_Key'] as String?,
      cash: (json['Наличные'] as num).toDouble(),
      getCash: (json['ПолученоНаличными'] as num).toDouble(),
      getCashless: (json['ПолученоЭлектронно'] as num).toDouble(),
      cashless: (json['СуммаБезналичнойОплаты'] as num).toDouble(),
      udsPayment: (json['СуммаОплатUDS'] as num).toDouble(),
      paymentForm: json['ФормаОплаты'] as String,
      change: (json['Сдача'] as num).toDouble(),
      storeKey: json['СтруктурнаяЕдиница_Key'] as String,
      items: (json['Запасы'] as List<dynamic>)
          .map((e) => CreateCheckItemScheme.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateCheckSchemeToJson(CreateCheckScheme instance) =>
    <String, dynamic>{
      'Date': instance.date.toIso8601String(),
      'Автор_Key': instance.authorKey,
      'КассаККМ_Key': instance.cashRegisterKey,
      'Кассир_Key': instance.userKey,
      'КассоваяСмена_Key': instance.sessionKey,
      'НомерСменыККМ': instance.sessionNumber,
      'КлиентUDS': instance.udsCustomer,
      'КодСкидкиUDS': instance.udsDiscountCode,
      'СкидкаUDS': instance.udsDiscount,
      'Комментарий': instance.comment,
      'Ответственный_Key': instance.responsibleKey,
      'Подразделение_Key': instance.subdivisionKey,
      'Покупатель': instance.customer,
      'СотрудникДолг_Key': instance.employeersDebtKey,
      'Наличные': instance.cash,
      'ПолученоНаличными': instance.getCash,
      'ПолученоЭлектронно': instance.getCashless,
      'СуммаБезналичнойОплаты': instance.cashless,
      'СуммаОплатUDS': instance.udsPayment,
      'ФормаОплаты': instance.paymentForm,
      'Сдача': instance.change,
      'СтруктурнаяЕдиница_Key': instance.storeKey,
      'Запасы': instance.items,
    };

CreateCheckItemScheme _$CreateCheckItemSchemeFromJson(
  Map<String, dynamic> json,
) => CreateCheckItemScheme(
  lineNumber: (json['LineNumber'] as num).toInt(),
  key: (json['КлючСвязи'] as num).toInt(),
  nomenclatureKey: json['Номенклатура_Key'] as String,
  characteristicKey: json['Характеристика_Key'] as String?,
  quantity: (json['Количество'] as num).toDouble(),
  price: (json['Цена'] as num).toDouble(),
  totalSum: (json['Сумма'] as num).toDouble(),
  allSum: (json['Всего'] as num).toDouble(),
  unitKey: json['ЕдиницаИзмерения'] as String,
);

Map<String, dynamic> _$CreateCheckItemSchemeToJson(
  CreateCheckItemScheme instance,
) => <String, dynamic>{
  'LineNumber': instance.lineNumber,
  'КлючСвязи': instance.key,
  'Номенклатура_Key': instance.nomenclatureKey,
  'Характеристика_Key': instance.characteristicKey,
  'Количество': instance.quantity,
  'Цена': instance.price,
  'Сумма': instance.totalSum,
  'Всего': instance.allSum,
  'ЕдиницаИзмерения': instance.unitKey,
};
