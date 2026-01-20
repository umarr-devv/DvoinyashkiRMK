import 'package:app/data/repositories/general_storage.dart';
import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_cubit.g.dart';
part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  final storage = GetIt.I<GeneralStorage>();

  void setSettings({
    bool? isDarkTheme,
    double? scale,
    CashRegisterScheme? cashRegister,
    String? printer,
  }) {
    if (scale != null) {
      storage.setValue(GeneralStorageKey.scale, scale);
    }
    final newState = state.copyWith(
      isDarkTheme: isDarkTheme,
      scale: scale,
      cashRegister: cashRegister,
      printer: printer
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
