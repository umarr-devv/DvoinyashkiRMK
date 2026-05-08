part of 'terminal_cubit.dart';

class TerminalState extends Equatable {
  const TerminalState({
    this.workReport,
    this.timestamp,
    this.pendingReports = const [],
  });

  final WorkReportScheme? workReport;
  final int? timestamp;
  final List<WorkReportScheme> pendingReports;

  TerminalState copyWith(Object? workReport, {List<WorkReportScheme>? pendingReports}) {
    return TerminalState(
      workReport: undefCompare(workReport, this.workReport),
      timestamp: DateTime.now().millisecondsSinceEpoch,
      pendingReports: pendingReports ?? this.pendingReports,
    );
  }

  TerminalState.from(TerminalState other)
    : workReport = other.workReport,
      pendingReports = other.pendingReports,
      timestamp = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [workReport, timestamp, pendingReports];

  Map<String, dynamic> toJson() {
    return {
      'pendingReports': pendingReports.map((e) => e.toJson()).toList(),
    };
  }

  factory TerminalState.fromJson(Map<String, dynamic> json) {
    return TerminalState(
      pendingReports: (json['pendingReports'] as List?)
              ?.map((e) => WorkReportScheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

final class TerminalInitial extends TerminalState {}

final class TerminalLoading extends TerminalState {
  TerminalLoading(super.state) : super.from();
}

final class TerminalLoaded extends TerminalState {
  TerminalLoaded(super.state) : super.from();
}

final class TerminalUpdating extends TerminalState {
  TerminalUpdating(super.state) : super.from();
}

final class TerminalUpdated extends TerminalState {
  TerminalUpdated(super.state) : super.from();
}

final class TerminalFailure extends TerminalState {
  TerminalFailure(super.state) : super.from();
}
