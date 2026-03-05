part of 'transfer_cubit.dart';

class TransferState extends Equatable {
  const TransferState({this.transfer});

  final DetailTransferScheme? transfer;

  TransferState copyWith(DetailTransferScheme? transfer) {
    return TransferState(transfer: transfer ?? this.transfer);
  }

  TransferState.from(TransferState other) : transfer = other.transfer;

  @override
  List<Object?> get props => [transfer];
}

final class TransferInitial extends TransferState {}

final class TransferLoading extends TransferState {
  TransferLoading(super.state) : super.from();
}

final class TransferLoaded extends TransferState {
  TransferLoaded(super.state) : super.from();
}

final class TransferUpdating extends TransferState {
  TransferUpdating(super.state) : super.from();
}

final class TransferUpdated extends TransferState {
  TransferUpdated(super.state) : super.from();
}

final class TransferFailure extends TransferState {
  TransferFailure(super.state) : super.from();
}

final class TransferUpdateFailure extends TransferState {
  TransferUpdateFailure(super.state) : super.from();
}
