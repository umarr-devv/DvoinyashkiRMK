// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uds_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UDSCustomerScheme _$UDSCustomerSchemeFromJson(Map<String, dynamic> json) =>
    UDSCustomerScheme(
      user: UDSCustomerDataScheme.fromJson(
        json['user'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$UDSCustomerSchemeToJson(UDSCustomerScheme instance) =>
    <String, dynamic>{'user': instance.user};

UDSCustomerDataScheme _$UDSCustomerDataSchemeFromJson(
  Map<String, dynamic> json,
) => UDSCustomerDataScheme(
  uid: json['uid'] as String,
  phone: json['phone'] as String?,
  gender: json['gender'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  email: json['email'] as String?,
  avatar: json['avatar'] as String?,
  displayName: json['displayName'] as String,
  participant: UDSCustomerParticipantScheme.fromJson(
    json['participant'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$UDSCustomerDataSchemeToJson(
  UDSCustomerDataScheme instance,
) => <String, dynamic>{
  'uid': instance.uid,
  'phone': instance.phone,
  'gender': instance.gender,
  'birthDate': instance.birthDate?.toIso8601String(),
  'email': instance.email,
  'avatar': instance.avatar,
  'displayName': instance.displayName,
  'participant': instance.participant,
};

UDSCustomerParticipantScheme _$UDSCustomerParticipantSchemeFromJson(
  Map<String, dynamic> json,
) => UDSCustomerParticipantScheme(
  id: (json['id'] as num).toInt(),
  cashSpent: (json['cashSpent'] as num).toDouble(),
  discountRate: (json['discountRate'] as num).toDouble(),
  cashbackRate: (json['cashbackRate'] as num).toDouble(),
  dateCreated: DateTime.parse(json['dateCreated'] as String),
  points: (json['points'] as num).toDouble(),
  operationsCount: (json['operationsCount'] as num).toInt(),
  savedFunds: (json['savedFunds'] as num).toDouble(),
  membershipTier: UDSCustomerMembershipTierScheme.fromJson(
    json['membershipTier'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$UDSCustomerParticipantSchemeToJson(
  UDSCustomerParticipantScheme instance,
) => <String, dynamic>{
  'id': instance.id,
  'cashSpent': instance.cashSpent,
  'discountRate': instance.discountRate,
  'cashbackRate': instance.cashbackRate,
  'dateCreated': instance.dateCreated.toIso8601String(),
  'points': instance.points,
  'operationsCount': instance.operationsCount,
  'savedFunds': instance.savedFunds,
  'membershipTier': instance.membershipTier,
};

UDSCustomerMembershipTierScheme _$UDSCustomerMembershipTierSchemeFromJson(
  Map<String, dynamic> json,
) => UDSCustomerMembershipTierScheme(
  uid: json['uid'] as String,
  name: json['name'] as String,
  maxScoresDiscount: (json['maxScoresDiscount'] as num).toDouble(),
  rate: (json['rate'] as num).toDouble(),
);

Map<String, dynamic> _$UDSCustomerMembershipTierSchemeToJson(
  UDSCustomerMembershipTierScheme instance,
) => <String, dynamic>{
  'uid': instance.uid,
  'name': instance.name,
  'maxScoresDiscount': instance.maxScoresDiscount,
  'rate': instance.rate,
};
