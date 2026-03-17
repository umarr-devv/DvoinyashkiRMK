// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'offline_checks_cubit.dart';

@JsonSerializable()
class OfflineChecksState extends Equatable {
  const OfflineChecksState({this.checks = const []});

  final List<CreateCheckScheme> checks;

  OfflineChecksState copyWith({List<CreateCheckScheme>? checks}) {
    return OfflineChecksState(checks: checks ?? this.checks);
  }

  OfflineChecksState.from(OfflineChecksState other) : checks = other.checks;

  factory OfflineChecksState.fromJson(Map<String, dynamic> json) =>
      _$OfflineChecksStateFromJson(json);

  Map<String, dynamic> toJson() => _$OfflineChecksStateToJson(this);

  @override
  List<Object?> get props => [checks];
}

final class OfflineChecksInitial extends OfflineChecksState {
  const OfflineChecksInitial();
}

final class OfflineChecksUpdate extends OfflineChecksState {
  OfflineChecksUpdate(super.state) : super.from();
}

final class OfflineChecksSending extends OfflineChecksState {
  OfflineChecksSending(super.state) : super.from();
}

final class OfflineChecksSent extends OfflineChecksState {
  OfflineChecksSent(super.state) : super.from();
}

final class OfflineChecksSendFailure extends OfflineChecksState {
  OfflineChecksSendFailure(super.state) : super.from();
}
