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
    this.showEmptyCategories = false,
    this.catalogListView = false,
  });

  final bool isDarkTheme;
  final double scale;
  final CashRegisterScheme? cashRegister;
  final AuthorScheme? author;
  final StructureUnitScheme? store;
  final StructureUnitScheme? subdivision;
  final String? printer;
  final List<String> pinnedCategories;
  final bool showEmptyCategories;
  final bool catalogListView;

  SettingsState copyWith({
    bool? isDarkTheme,
    double? scale,
    AuthorScheme? author,
    CashRegisterScheme? cashRegister,
    StructureUnitScheme? store,
    StructureUnitScheme? subdivision,
    String? printer,
    List<String>? pinnedCategories,
    bool? showEmptyCategories,
    bool? catalogListView,
  }) {
    return SettingsState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      scale: scale ?? this.scale,
      cashRegister: cashRegister ?? this.cashRegister,
      author: author ?? this.author,
      store: store ?? this.store,
      subdivision: subdivision ?? this.subdivision,
      printer: printer ?? this.printer,
      pinnedCategories: pinnedCategories ?? this.pinnedCategories,
      showEmptyCategories: showEmptyCategories ?? this.showEmptyCategories,
      catalogListView: catalogListView ?? this.catalogListView,
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
      catalogListView = other.catalogListView;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);

  @override
  List<Object?> get props => [
    isDarkTheme,
    cashRegister,
    author,
    scale,
    store,
    subdivision,
    pinnedCategories,
    showEmptyCategories,
    catalogListView,
  ];
}

final class SettingsInitial extends SettingsState {}

final class SettingsUpdate extends SettingsState {
  SettingsUpdate(super.state) : super.from();
}
