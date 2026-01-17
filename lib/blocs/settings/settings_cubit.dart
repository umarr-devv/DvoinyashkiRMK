import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_cubit.g.dart';
part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  void setSettings(
    bool? isDarkTheme,
    double? scale,
    CashRegisterScheme? cashRegister,
  ) {
    final newState = state.copyWith(
      isDarkTheme: isDarkTheme,
      scale: scale,
      cashRegister: cashRegister,
    );
    emit(SettingsUpdate(newState));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }
}
