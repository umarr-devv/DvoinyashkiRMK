// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    SettingsState(
      isDarkTheme: json['is_dark_theme'] as bool? ?? false,
      scale: (json['scale'] as num?)?.toDouble() ?? 1,
      cashRegister: json['cash_register'] == null
          ? null
          : CashRegisterScheme.fromJson(
              json['cash_register'] as Map<String, dynamic>,
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
          (json['pinned_categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      showEmptyCategories: json['show_empty_categories'] as bool? ?? false,
      catalogListView: json['catalog_list_view'] as bool? ?? false,
    );

Map<String, dynamic> _$SettingsStateToJson(SettingsState instance) =>
    <String, dynamic>{
      'is_dark_theme': instance.isDarkTheme,
      'scale': instance.scale,
      'cash_register': instance.cashRegister,
      'author': instance.author,
      'store': instance.store,
      'subdivision': instance.subdivision,
      'printer': instance.printer,
      'pinned_categories': instance.pinnedCategories,
      'show_empty_categories': instance.showEmptyCategories,
      'catalog_list_view': instance.catalogListView,
    };
