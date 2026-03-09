part of 'terminal_cubit.dart';

class TerminalState extends Equatable {
  const TerminalState({this.workReport});

  final WorkReportScheme? workReport;

  TerminalState copyWith(Object? workReport) {
    return TerminalState(workReport: undefCompare(workReport, this.workReport));
  }

  TerminalState.from(TerminalState other) : workReport = other.workReport;

  @override
  List<Object?> get props => [workReport];
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
