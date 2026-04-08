part of 'transfer_cubit.dart';

class TransferState extends Equatable {
  const TransferState({this.transfer, this.isSecondData});

  final TransferScheme? transfer;
  final bool? isSecondData;

  TransferState copyWith(
    TransferScheme? transfer,
    bool? isSecondData,
  ) {
    return TransferState(
      transfer: transfer ?? this.transfer,
      isSecondData: isSecondData ?? this.isSecondData,
    );
  }

  TransferState.from(TransferState other)
    : transfer = other.transfer,
      isSecondData = other.isSecondData;

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
