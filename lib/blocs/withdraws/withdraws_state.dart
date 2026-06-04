// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'withdraws_cubit.dart';

@JsonSerializable()
class WithdrawsState extends Equatable {
  const WithdrawsState({
    this.withdraws = const [],
    this.sessionWithdraws = const [],
    this.notAcceptedWithdraws = const [],
    this.cash,
    this.pageNum = 0,
    this.accepting = const {},
  });

  final List<WithdrawScheme> withdraws;
  final List<WithdrawScheme> sessionWithdraws;
  final List<WithdrawScheme> notAcceptedWithdraws;
  final CashScheme? cash;
  final Map<String, bool> accepting;
  final int pageNum;

  final int limit = 20;
  int get offset => pageNum * limit;

  factory WithdrawsState.fromJson(Map<String, dynamic> json) =>
      _$WithdrawsStateFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawsStateToJson(this);

  WithdrawsState copyWith({
    List<WithdrawScheme>? withdraws,
    List<WithdrawScheme>? sessionWithdraws,
    List<WithdrawScheme>? notAcceptedWithdraws,
    Map<String, bool>? accepting,
    CashScheme? cash,
    int? pageNum,
  }) {
    return WithdrawsState(
      withdraws: withdraws ?? this.withdraws,
      sessionWithdraws: sessionWithdraws ?? this.sessionWithdraws,
      cash: cash ?? this.cash,
      accepting: accepting ?? this.accepting,
      notAcceptedWithdraws: notAcceptedWithdraws ?? this.notAcceptedWithdraws,
      pageNum: pageNum ?? this.pageNum,
    );
  }

  WithdrawsState.from(WithdrawsState other)
    : withdraws = other.withdraws,
      sessionWithdraws = other.sessionWithdraws,
      cash = other.cash,
      notAcceptedWithdraws = other.notAcceptedWithdraws,
      accepting = other.accepting,
      pageNum = other.pageNum;

  @override
  List<Object?> get props => [
    withdraws,
    sessionWithdraws,
    notAcceptedWithdraws,
    cash,
    pageNum,
    accepting,
  ];
}

final class WithdrawsInitial extends WithdrawsState {}

final class WithdrawsUpdate extends WithdrawsState {
  WithdrawsUpdate(super.state) : super.from();
}

final class WithdrawsLoading extends WithdrawsState {
  WithdrawsLoading(super.state) : super.from();
}

final class WithdrawsLoaded extends WithdrawsState {
  WithdrawsLoaded(super.state) : super.from();
}

final class WithdrawsFailure extends WithdrawsState {
  WithdrawsFailure(super.state) : super.from();
}
