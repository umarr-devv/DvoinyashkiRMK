// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_cubit.dart';

@JsonSerializable()
class SettingsState extends Equatable {
  const SettingsState({
    this.isDarkTheme = false,
    this.scale = 1,
    this.cashRegister,
  });

  final bool isDarkTheme;
  final double scale;
  final CashRegisterScheme? cashRegister;

  SettingsState copyWith({
    bool? isDarkTheme,
    double? scale,
    CashRegisterScheme? cashRegister,
  }) {
    return SettingsState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      scale: scale ?? this.scale,
      cashRegister: cashRegister ?? this.cashRegister,
    );
  }

  SettingsState.from(SettingsState other)
    : isDarkTheme = other.isDarkTheme,
      scale = other.scale,
      cashRegister = other.cashRegister;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);

  @override
  List<Object?> get props => [isDarkTheme, scale];
}

final class SettingsInitial extends SettingsState {}

final class SettingsUpdate extends SettingsState {
  SettingsUpdate(super.state) : super.from();
}
