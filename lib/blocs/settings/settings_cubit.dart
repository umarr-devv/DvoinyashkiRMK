import 'package:app/data/repositories/general_storage.dart';
import 'package:app/models/group.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/undefined.dart';
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
    AuthorScheme? author,
    StructureUnitScheme? store,
    StructureUnitScheme? subdivision,
    String? printer,
    List<String>? pinnedCategories,
    bool? showEmptyCategories,
    bool? catalogListView,
    List<GroupScheme>? productionGroups,
    double? fontScale,
    Map<String, GroupScheme>? printerGroups,
    bool? useSmartCatalog,
    Object? cafeCashRegister
  }) {
    if (scale != null) {
      storage.setValue(GeneralStorageKey.scale, scale);
    }
    final newState = state.copyWith(
      isDarkTheme: isDarkTheme,
      scale: scale,
      cashRegister: cashRegister,
      author: author,
      store: store,
      subdivision: subdivision,
      printer: printer,
      pinnedCategories: pinnedCategories,
      showEmptyCategories: showEmptyCategories,
      catalogListView: catalogListView,
      productionGroups: productionGroups,
      fontScale: fontScale,
      printerGroups: printerGroups,
      useSmartCatalog: useSmartCatalog,
      cafeCashRegister: cafeCashRegister,
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
