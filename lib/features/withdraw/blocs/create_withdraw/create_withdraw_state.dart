part of 'create_withdraw_cubit.dart';

class CreateWithdrawState extends Equatable {
  const CreateWithdrawState({this.withdraw});

  final WithdrawScheme? withdraw;

  CreateWithdrawState copyWith(WithdrawScheme? withdraw) {
    return CreateWithdrawState(withdraw: withdraw ?? this.withdraw);
  }

  CreateWithdrawState.from(CreateWithdrawState other)
    : withdraw = other.withdraw;

  @override
  List<Object?> get props => [withdraw];
}

final class CreateWithdrawInitial extends CreateWithdrawState {}

final class CreateWithdrawLoading extends CreateWithdrawState {
  CreateWithdrawLoading(super.state) : super.from();
}

final class CreateWithdrawLoaded extends CreateWithdrawState {
  CreateWithdrawLoaded(super.state) : super.from();
}

final class CreateWithdrawFailure extends CreateWithdrawState {
  CreateWithdrawFailure(super.state) : super.from();
}
