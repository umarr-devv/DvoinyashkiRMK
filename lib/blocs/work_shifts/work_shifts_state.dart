// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'work_shifts_cubit.dart';

@JsonSerializable()
class WorkShiftsState extends Equatable {
  const WorkShiftsState({this.workShifts = const [], this.pageNum = 0});

  final List<WorkShiftScheme> workShifts;
  final int pageNum;

  final int limit = 20;
  int get offset => pageNum * limit;

  WorkShiftsState copyWith({List<WorkShiftScheme>? workShifts, int? pageNum}) {
    return WorkShiftsState(
      workShifts: workShifts ?? this.workShifts,
      pageNum: pageNum ?? this.pageNum,
    );
  }

  WorkShiftsState.from(WorkShiftsState other)
    : workShifts = other.workShifts,
      pageNum = other.pageNum;

  factory WorkShiftsState.fromJson(Map<String, dynamic> json) =>
      _$WorkShiftsStateFromJson(json);

  Map<String, dynamic> toJson() => _$WorkShiftsStateToJson(this);

  @override
  List<Object> get props => [workShifts, pageNum];
}

final class WorkShiftsInitial extends WorkShiftsState {}

final class WorkShiftsUpdate extends WorkShiftsState {
  WorkShiftsUpdate(super.state) : super.from();
}

final class WorkShiftsLoading extends WorkShiftsState {
  WorkShiftsLoading(super.state) : super.from();
}

final class WorkShiftsLoaded extends WorkShiftsState {
  WorkShiftsLoaded(super.state) : super.from();
}

final class WorkShiftsFailure extends WorkShiftsState {
  WorkShiftsFailure(super.state) : super.from();
}
