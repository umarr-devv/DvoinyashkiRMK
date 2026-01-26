// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movements_cubit.dart';

@JsonSerializable()
class MovementsState extends Equatable {
  const MovementsState({
    this.movements = const [],
    this.statuses = const [],
    this.pageNum = 0,
  });

  final List<MovementScheme> movements;
  final List<MovementStatusScheme> statuses;
  final int pageNum;

  final int limit = 20;
  int get offset => pageNum * limit;

  MovementsState copyWith({
    List<MovementScheme>? movements,
    List<MovementStatusScheme>? statuses,
    int? pageNum,
  }) {
    return MovementsState(
      movements: movements ?? this.movements,
      statuses: statuses ?? this.statuses,
      pageNum: pageNum ?? this.pageNum,
    );
  }

  MovementsState.from(MovementsState other)
    : movements = other.movements,
      statuses = other.statuses,
      pageNum = other.pageNum;

  factory MovementsState.fromJson(Map<String, dynamic> json) =>
      _$MovementsStateFromJson(json);

  Map<String, dynamic> toJson() => _$MovementsStateToJson(this);

  @override
  List<Object?> get props => [movements, statuses, pageNum];
}

final class MovementsInitial extends MovementsState {}

final class MovementsUpdate extends MovementsState {
  MovementsUpdate(super.state) : super.from();
}

final class MovementsLoading extends MovementsState {
  MovementsLoading(super.state) : super.from();
}

final class MovementsLoaded extends MovementsState {
  MovementsLoaded(super.state) : super.from();
}

final class MovementsFailure extends MovementsState {
  MovementsFailure(super.state) : super.from();
}
