// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checks_cubit.dart';

@JsonSerializable()
class ChecksState extends Equatable {
  const ChecksState({this.checks = const [], this.pageNum = 0});

  final List<CheckScheme> checks;
  final int pageNum;

  final int limit = 20;
  int get offset => pageNum * limit;

  ChecksState copyWith({List<CheckScheme>? checks, int? pageNum}) {
    return ChecksState(
      checks: checks ?? this.checks,
      pageNum: pageNum ?? this.pageNum,
    );
  }

  ChecksState.from(ChecksState other)
    : checks = other.checks,
      pageNum = other.pageNum;

  factory ChecksState.fromJson(Map<String, dynamic> json) =>
      _$ChecksStateFromJson(json);

  Map<String, dynamic> toJson() => _$ChecksStateToJson(this);

  @override
  List<Object?> get props => [checks, pageNum];
}

final class ChecksInitial extends ChecksState {}

final class ChecksUpdate extends ChecksState {}

final class ChecksLoading extends ChecksState {}

final class ChecksLoaded extends ChecksState {}

final class ChecksFailure extends ChecksState {}
