// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'statistic_cubit.dart';

@JsonSerializable()
class StatisticState extends Equatable {
  const StatisticState({
    this.checks = const [],
    this.checkSums = const [],
    this.userSums = const [],
    this.items = const [],
    required this.startDate,
    required this.endDate,
    required this.isHourInterval,
  });

  final List<StatisticCheckScheme> checks;
  final List<StatisticCheckSumData> checkSums;
  final List<StatisticUserData> userSums;
  final List<StatisticItemData> items;

  final DateTime startDate;
  final DateTime endDate;
  final bool isHourInterval;

  List<StatisticUserData> get filtredUserSums {
    final List<StatisticUserData> copy = List.from(userSums);
    copy.sort((a, b) {
      if (a.totalSum < b.totalSum) {
        return 1;
      } else {
        return 0;
      }
    });
    return copy;
  }

  List<String> get udsClients => checks
      .where((i) => i.udsClient.isNotEmpty)
      .map((i) => i.udsClient)
      .toList();

  Set get uniqueUdsClient => Set.from(udsClients);

  double get totalUdsPoints => checks.fold<double>(0, (a, b) {
    final udsDiscount = double.tryParse(b.udsPayment);
    if (udsDiscount != null){
      return a + udsDiscount;
    }
    return a;
  });

  double get totalSum =>
      checks.map((i) => i.documentSum).fold(0, (a, b) => a + b);

  double get avgCheckSum => totalSum / checks.length;

  double get avgDaySum => totalSum / checkSums.length;

  double get udsPercent => uniqueUdsClient.length / checks.length;

  StatisticState copyWith({
    List<StatisticCheckScheme>? checks,
    List<StatisticCheckSumData>? checkSums,
    List<StatisticUserData>? userSums,
    List<StatisticItemData>? items,
    DateTime? startDate,
    DateTime? endDate,
    bool? isHourInterval,
  }) {
    return StatisticState(
      checks: checks ?? this.checks,
      checkSums: checkSums ?? this.checkSums,
      userSums: userSums ?? this.userSums,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      items: items ?? this.items,
      isHourInterval: isHourInterval ?? this.isHourInterval,
    );
  }

  StatisticState.from(StatisticState other)
    : checks = other.checks,
      checkSums = other.checkSums,
      userSums = other.userSums,
      items = other.items,
      startDate = other.startDate,
      endDate = other.endDate,
      isHourInterval = other.isHourInterval;

  factory StatisticState.fromJson(Map<String, dynamic> json) =>
      _$StatisticStateFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticStateToJson(this);

  @override
  List<Object?> get props => [
    checks,
    checkSums,
    userSums,
    items,
    startDate,
    endDate,
    isHourInterval,
  ];
}

final class StatisticInitial extends StatisticState {
  const StatisticInitial({
    required super.startDate,
    required super.endDate,
    required super.isHourInterval,
  });
}

final class StatisticUpdate extends StatisticState {
  StatisticUpdate(super.state) : super.from();
}

final class StatisticLoading extends StatisticState {
  StatisticLoading(super.state) : super.from();
}

final class StatisticLoaded extends StatisticState {
  StatisticLoaded(super.state) : super.from();
}

final class StatisticAltLoading extends StatisticState {
  StatisticAltLoading(super.state) : super.from();
}

final class StatisticAltLoaded extends StatisticState {
  StatisticAltLoaded(super.state) : super.from();
}

final class StatisticFailure extends StatisticState {
  StatisticFailure(super.state) : super.from();
}
