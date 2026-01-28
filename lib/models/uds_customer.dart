import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'uds_customer.g.dart';

@JsonSerializable()
class UDSCustomerScheme extends Equatable {
  const UDSCustomerScheme({required this.user});

  final UDSCustomerDataScheme user;

  factory UDSCustomerScheme.fromJson(Map<String, dynamic> json) =>
      _$UDSCustomerSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UDSCustomerSchemeToJson(this);

  @override
  List<Object?> get props => [user];
}

@JsonSerializable()
class UDSCustomerDataScheme extends Equatable {
  const UDSCustomerDataScheme({
    required this.uid,
    required this.phone,
    required this.gender,
    required this.birthDate,
    required this.email,
    required this.avatar,
    required this.displayName,
    required this.participant,
  });

  final String uid;
  final String? phone;
  final String? gender;
  final DateTime? birthDate;
  final String? email;
  final String? avatar;
  final String displayName;
  final UDSCustomerParticipantScheme participant;

  factory UDSCustomerDataScheme.fromJson(Map<String, dynamic> json) =>
      _$UDSCustomerDataSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UDSCustomerDataSchemeToJson(this);

  @override
  List<Object?> get props => [uid, participant.id];
}

@JsonSerializable()
class UDSCustomerParticipantScheme extends Equatable{
  const UDSCustomerParticipantScheme({
    required this.id,
    required this.cashSpent,
    required this.discountRate,
    required this.cashbackRate,
    required this.dateCreated,
    required this.points,
    required this.operationsCount,
    required this.savedFunds,
    required this.membershipTier,
  });

  final int id;
  final double cashSpent;
  final double discountRate;
  final double cashbackRate;
  final DateTime dateCreated;
  final double points;
  final int operationsCount;
  final double savedFunds;
  final UDSCustomerMembershipTierScheme membershipTier;

  factory UDSCustomerParticipantScheme.fromJson(Map<String, dynamic> json) =>
      _$UDSCustomerParticipantSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$UDSCustomerParticipantSchemeToJson(this);

    @override
  List<Object?> get props => [id];
}

@JsonSerializable()
class UDSCustomerMembershipTierScheme {
  UDSCustomerMembershipTierScheme({
    required this.uid,
    required this.name,
    required this.maxScoresDiscount,
    required this.rate,
  });

  final String uid;
  final String name;
  final double maxScoresDiscount;
  final double rate;

  factory UDSCustomerMembershipTierScheme.fromJson(Map<String, dynamic> json) =>
      _$UDSCustomerMembershipTierSchemeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UDSCustomerMembershipTierSchemeToJson(this);
}
