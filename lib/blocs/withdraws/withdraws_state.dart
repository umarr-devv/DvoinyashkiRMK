// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'withdraws_cubit.dart';

@JsonSerializable()
class WithdrawsState extends Equatable {
  const WithdrawsState({this.withdraws = const [], this.pageNum = 0});

  final List<WithdrawScheme> withdraws;
  final int pageNum;

  final int limit = 20;
  int get offset => pageNum * limit;

  factory WithdrawsState.fromJson(Map<String, dynamic> json) =>
      _$WithdrawsStateFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawsStateToJson(this);

  WithdrawsState copyWith({List<WithdrawScheme>? withdraws, int? pageNum}) {
    return WithdrawsState(
      withdraws: withdraws ?? this.withdraws,
      pageNum: pageNum ?? this.pageNum,
    );
  }

  WithdrawsState.from(WithdrawsState other)
    : withdraws = other.withdraws,
      pageNum = other.pageNum;

  @override
  List<Object> get props => [withdraws];
}

final class WithdrawsInitial extends WithdrawsState {}

final class WithdrawsLoading extends WithdrawsState {
  WithdrawsLoading(super.state) : super.from();
}

final class WithdrawsLoaded extends WithdrawsState {
  WithdrawsLoaded(super.state) : super.from();
}

final class WithdrawsFailure extends WithdrawsState {
  WithdrawsFailure(super.state) : super.from();
}
