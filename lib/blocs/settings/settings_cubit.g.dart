// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    SettingsState(
      isDarkTheme: json['isDarkTheme'] as bool? ?? false,
      scale: (json['scale'] as num?)?.toDouble() ?? 1,
      cashRegister: json['cashRegister'] == null
          ? null
          : CashRegisterScheme.fromJson(
              json['cashRegister'] as Map<String, dynamic>,
            ),
      author: json['author'] == null
          ? null
          : AuthorScheme.fromJson(json['author'] as Map<String, dynamic>),
      store: json['store'] == null
          ? null
          : StructureUnitScheme.fromJson(json['store'] as Map<String, dynamic>),
      subdivision: json['subdivision'] == null
          ? null
          : StructureUnitScheme.fromJson(
              json['subdivision'] as Map<String, dynamic>,
            ),
      printer: json['printer'] as String?,
      cafeCashRegister: json['cafeCashRegister'] == null
          ? null
          : CashRegisterScheme.fromJson(
              json['cafeCashRegister'] as Map<String, dynamic>,
            ),
      pinnedCategories:
          (json['pinnedCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      productionGroups:
          (json['productionGroups'] as List<dynamic>?)
              ?.map((e) => GroupScheme.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      showEmptyCategories: json['showEmptyCategories'] as bool? ?? false,
      catalogListView: json['catalogListView'] as bool? ?? false,
      fontScale: (json['fontScale'] as num?)?.toDouble() ?? 1.0,
      printerGroups:
          (json['printerGroups'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, GroupScheme.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      useSmartCatalog: json['useSmartCatalog'] as bool? ?? true,
    );

Map<String, dynamic> _$SettingsStateToJson(SettingsState instance) =>
    <String, dynamic>{
      'isDarkTheme': instance.isDarkTheme,
      'scale': instance.scale,
      'fontScale': instance.fontScale,
      'cashRegister': instance.cashRegister,
      'author': instance.author,
      'store': instance.store,
      'subdivision': instance.subdivision,
      'printer': instance.printer,
      'pinnedCategories': instance.pinnedCategories,
      'productionGroups': instance.productionGroups,
      'showEmptyCategories': instance.showEmptyCategories,
      'catalogListView': instance.catalogListView,
      'printerGroups': instance.printerGroups,
      'useSmartCatalog': instance.useSmartCatalog,
      'cafeCashRegister': instance.cafeCashRegister,
    };
