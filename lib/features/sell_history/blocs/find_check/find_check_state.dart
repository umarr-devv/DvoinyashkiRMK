part of 'find_check_cubit.dart';

class FindCheckState extends Equatable {
  const FindCheckState({this.check});

  final CheckScheme? check;

  FindCheckState copyWith(CheckScheme? check) {
    return FindCheckState(check: check ?? this.check);
  }

  FindCheckState.from(FindCheckState other) : check = other.check;

  @override
  List<Object?> get props => [check];
}

final class FindCheckInitial extends FindCheckState {}

final class FindCheckLoading extends FindCheckState {
  FindCheckLoading(super.state) : super.from();
}

final class FindCheckLoaded extends FindCheckState {
  FindCheckLoaded(super.state) : super.from();
}

final class FindCheckFailure extends FindCheckState {
  FindCheckFailure(super.state) : super.from();
}
