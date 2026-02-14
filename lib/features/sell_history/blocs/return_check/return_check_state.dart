part of 'return_check_cubit.dart';

class ReturnCheckState {
  const ReturnCheckState({required this.items});

  final List<ReturnCheckItemData> items;

  List<ReturnCheckItemData> get notEmptyItems =>
      items.where((i) => i.quantity != 0).toList();
  double get totalSum => notEmptyItems.fold(0, (a, b) => a + b.totalSum);

  ReturnCheckState copyWith(List<ReturnCheckItemData>? items) {
    return ReturnCheckState(items: items ?? this.items);
  }

  ReturnCheckState.from(ReturnCheckState other) : items = other.items;
}

final class ReturnCheckInitial extends ReturnCheckState {
  const ReturnCheckInitial({required super.items});
}

final class ReturnCheckLoading extends ReturnCheckState {
  ReturnCheckLoading(super.state) : super.from();
}

final class ReturnCheckUpdate extends ReturnCheckState {
  ReturnCheckUpdate(super.state) : super.from();
}

final class ReturnCheckLoaded extends ReturnCheckState {
  ReturnCheckLoaded(super.state) : super.from();
}

final class ReturnCheckFailure extends ReturnCheckState {
  ReturnCheckFailure(super.state) : super.from();
}
