part of 'terminal_cubit.dart';

class TerminalState extends Equatable {
  const TerminalState({this.workReport, this.timestamp});

  final WorkReportScheme? workReport;
  final int? timestamp;

  TerminalState copyWith(Object? workReport) {
    return TerminalState(
      workReport: undefCompare(workReport, this.workReport),
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  TerminalState.from(TerminalState other)
    : workReport = other.workReport,
      timestamp = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [workReport, timestamp];
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
