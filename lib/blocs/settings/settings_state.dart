// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_cubit.dart';

@JsonSerializable()
class SettingsState extends Equatable {
  const SettingsState({
    this.isDarkTheme = false,
    this.scale = 1,
    this.cashRegister,
    this.printer,
  });

  final bool isDarkTheme;
  final double scale;
  final CashRegisterScheme? cashRegister;
  final String? printer;

  SettingsState copyWith({
    bool? isDarkTheme,
    double? scale,
    CashRegisterScheme? cashRegister,
    String? printer,
  }) {
    return SettingsState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      scale: scale ?? this.scale,
      cashRegister: cashRegister ?? this.cashRegister,
      printer: printer ?? this.printer,
    );
  }

  SettingsState.from(SettingsState other)
    : isDarkTheme = other.isDarkTheme,
      scale = other.scale,
      cashRegister = other.cashRegister,
      printer = other.printer;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);

  @override
  List<Object?> get props => [isDarkTheme, cashRegister, scale];
}

final class SettingsInitial extends SettingsState {}

final class SettingsUpdate extends SettingsState {
  SettingsUpdate(super.state) : super.from();
}
