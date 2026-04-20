// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_cubit.dart';

@JsonSerializable()
class SettingsState extends Equatable {
  const SettingsState({
    this.isDarkTheme = false,
    this.scale = 1,
    this.cashRegister,
    this.author,
    this.store,
    this.subdivision,
    this.printer,
    this.pinnedCategories = const [],
    this.productionGroups = const [],
    this.showEmptyCategories = false,
    this.catalogListView = false,
    this.fontScale = 1.0,
    this.printerGroups = const {},
  });

  final bool isDarkTheme;
  final double scale;
  final double fontScale;
  final CashRegisterScheme? cashRegister;
  final AuthorScheme? author;
  final StructureUnitScheme? store;
  final StructureUnitScheme? subdivision;
  final String? printer;
  final List<String> pinnedCategories;
  final List<GroupScheme> productionGroups;
  final bool showEmptyCategories;
  final bool catalogListView;
  final Map<String, GroupScheme> printerGroups;

  SettingsState copyWith({
    bool? isDarkTheme,
    double? scale,
    AuthorScheme? author,
    CashRegisterScheme? cashRegister,
    StructureUnitScheme? store,
    StructureUnitScheme? subdivision,
    String? printer,
    List<String>? pinnedCategories,
    List<GroupScheme>? productionGroups,
    bool? showEmptyCategories,
    bool? catalogListView,
    double? fontScale,
    Map<String, GroupScheme>? printerGroups,
  }) {
    return SettingsState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      scale: scale ?? this.scale,
      fontScale: fontScale ?? this.fontScale,
      cashRegister: cashRegister ?? this.cashRegister,
      author: author ?? this.author,
      store: store ?? this.store,
      subdivision: subdivision ?? this.subdivision,
      printer: printer ?? this.printer,
      pinnedCategories: pinnedCategories ?? this.pinnedCategories,
      productionGroups: productionGroups ?? this.productionGroups,
      showEmptyCategories: showEmptyCategories ?? this.showEmptyCategories,
      catalogListView: catalogListView ?? this.catalogListView,
      printerGroups: printerGroups ?? this.printerGroups,
    );
  }

  SettingsState.from(SettingsState other)
    : isDarkTheme = other.isDarkTheme,
      scale = other.scale,
      cashRegister = other.cashRegister,
      author = other.author,
      store = other.store,
      subdivision = other.subdivision,
      printer = other.printer,
      pinnedCategories = other.pinnedCategories,
      showEmptyCategories = other.showEmptyCategories,
      productionGroups = other.productionGroups,
      catalogListView = other.catalogListView,
      fontScale = other.fontScale,
      printerGroups = other.printerGroups;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);

  @override
  List<Object?> get props => [
    isDarkTheme,
    printer,
    cashRegister,
    author,
    scale,
    store,
    subdivision,
    pinnedCategories,
    productionGroups,
    showEmptyCategories,
    catalogListView,
    fontScale,
    printerGroups,
  ];
}

final class SettingsInitial extends SettingsState {}

final class SettingsUpdate extends SettingsState {
  SettingsUpdate(super.state) : super.from();
}
