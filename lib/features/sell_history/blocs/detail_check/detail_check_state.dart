// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_check_cubit.dart';

@JsonSerializable()
class DetailCheckState extends Equatable {
  const DetailCheckState({required this.refKey, this.check, this.update});

  final String refKey;
  final DetailCheckScheme? check;
  final DateTime? update;

  DetailCheckState copyWith({
    String? refKey,
    DetailCheckScheme? check,
    DateTime? update,
  }) {
    return DetailCheckState(
      refKey: refKey ?? this.refKey,
      check: check ?? this.check,
      update: update ?? this.update,
    );
  }

  DetailCheckState.from(DetailCheckState other)
    : refKey = other.refKey,
      check = other.check,
      update = other.update;

  factory DetailCheckState.fromJson(Map<String, dynamic> json) =>
      _$DetailCheckStateFromJson(json);

  Map<String, dynamic> toJson() => _$DetailCheckStateToJson(this);

  @override
  List<Object?> get props => [refKey, check, update];
}

final class DetailCheckInitial extends DetailCheckState {
  const DetailCheckInitial({required super.refKey});
}

final class DetailCheckLoading extends DetailCheckState {
  DetailCheckLoading(super.state) : super.from();
}

final class DetailCheckLoaded extends DetailCheckState {
  DetailCheckLoaded(super.state) : super.from();
}

final class DetailCheckFailure extends DetailCheckState {
  DetailCheckFailure(super.state) : super.from();
}
