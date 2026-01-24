// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'statistic_cubit.dart';

@JsonSerializable()
class StatisticState extends Equatable {
  const StatisticState({this.checks = const [], this.checkSums = const []});

  final List<StatisticCheckScheme> checks;
  final List<StatisticCheckSumAggregate> checkSums;

  StatisticState copyWith({
    List<StatisticCheckScheme>? checks,
    List<StatisticCheckSumAggregate>? checkSums,
  }) {
    return StatisticState(
      checks: checks ?? this.checks,
      checkSums: checkSums ?? this.checkSums,
    );
  }

  StatisticState.from(StatisticState other)
    : checks = other.checks,
      checkSums = other.checkSums;

  factory StatisticState.fromJson(Map<String, dynamic> json) =>
      _$StatisticStateFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticStateToJson(this);

  @override
  List<Object?> get props => [checks, checkSums];
}

final class StatisticInitial extends StatisticState {}

final class StatisticUpdate extends StatisticState {
  StatisticUpdate(super.state) : super.from();
}

final class StatisticLoading extends StatisticState {
  StatisticLoading(super.state) : super.from();
}

final class StatisticLoaded extends StatisticState {
  StatisticLoaded(super.state) : super.from();
}

final class StatisticFailure extends StatisticState {
  StatisticFailure(super.state) : super.from();
}
