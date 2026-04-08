part of 'transfers_cubit.dart';

class TransfersState extends Equatable {
  const TransfersState({
    this.transfers = const [],
    this.pageNum = 0,
  });

  final List<TransferScheme> transfers;
  final int pageNum;
  final int limit = 20;
  
  int get offset => pageNum * limit;

  TransfersState copyWith({
    List<TransferScheme>? transfers,
    int? pageNum,
  }) {
    return TransfersState(
      transfers: transfers ?? this.transfers,
      pageNum: pageNum ?? this.pageNum,
    );
  }

  @override
  List<Object?> get props => [transfers, pageNum];
}

final class TransfersInitial extends TransfersState {
  const TransfersInitial() : super();
}
final class TransfersUpdate extends TransfersState {
  TransfersUpdate(TransfersState state) : super(transfers: state.transfers, pageNum: state.pageNum);
}
final class TransfersLoading extends TransfersState {
  TransfersLoading(TransfersState state) : super(transfers: state.transfers, pageNum: state.pageNum);
}
final class TransfersLoaded extends TransfersState {
  TransfersLoaded(TransfersState state) : super(transfers: state.transfers, pageNum: state.pageNum);
}
final class TransfersFailure extends TransfersState {
  TransfersFailure(TransfersState state) : super(transfers: state.transfers, pageNum: state.pageNum);
}
