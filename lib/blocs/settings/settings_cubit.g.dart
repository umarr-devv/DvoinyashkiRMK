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
      pinnedCategories:
          (json['pinnedCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      showEmptyCategories: json['showEmptyCategories'] as bool? ?? false,
      catalogListView: json['catalogListView'] as bool? ?? false,
    );

Map<String, dynamic> _$SettingsStateToJson(SettingsState instance) =>
    <String, dynamic>{
      'isDarkTheme': instance.isDarkTheme,
      'scale': instance.scale,
      'cashRegister': instance.cashRegister,
      'author': instance.author,
      'store': instance.store,
      'subdivision': instance.subdivision,
      'printer': instance.printer,
      'pinnedCategories': instance.pinnedCategories,
      'showEmptyCategories': instance.showEmptyCategories,
      'catalogListView': instance.catalogListView,
    };
