import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/dialogs/dialogs.dart';
import 'package:app/features/order/states/states.dart';
import 'package:app/models/group.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class OrderCatalog extends StatelessWidget {
  const OrderCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: Text('Каталог'),
        suffixes: [_OrderCatalogSearchBar()],
      ),
      child: Column(
        spacing: 12,
        children: [
          _OrderCatalogCategories(),
          Expanded(child: _CatalogGrid()),
        ],
      ),
    );
  }
}

class _OrderCatalogSearchBar extends StatefulWidget {
  const _OrderCatalogSearchBar();

  @override
  State<_OrderCatalogSearchBar> createState() => _OrderCatalogSearchBarState();
}

class _OrderCatalogSearchBarState extends State<_OrderCatalogSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    productSeachQuery.addListener(_onQueryChanged);
  }

  void _onQueryChanged() {
    if (productSeachQuery.value.isEmpty && _controller.text.isNotEmpty) {
      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    productSeachQuery.removeListener(_onQueryChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: FTextField(
        focusNode: _focusNode,
        control: FTextFieldControl.managed(
          controller: _controller,
          onChange: (value) {
            productSeachQueryDebounce.setValue(value.text);
          },
        ),
        clearable: (p0) => p0.text.isNotEmpty,
        prefixBuilder: (context, style, states) => Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Icon(FIcons.search),
        ),
        hint: 'Поиск',
      ),
    );
  }
}

class _OrderCatalogCategories extends StatelessWidget {
  const _OrderCatalogCategories();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, state) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          bloc: BlocProvider.of<SettingsCubit>(context),
          builder: (context, settingsState) {
            final pinnedCategories = state.groups
                .where((i) => settingsState.pinnedCategories.contains(i.refKey))
                .toList();
            return Row(
              spacing: 12,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 12,
                      children:
                          [
                            _OrderCatalogCategoriesItem(allSelectedCategory),
                            _OrderCatalogCategoriesItem(
                              favoriteSelectedCategory,
                            ),
                            if (settingsState.showEmptyCategories)
                              _OrderCatalogCategoriesItem(SelectedGroupData()),
                          ] +
                          pinnedCategories.map((category) {
                            return _OrderCatalogCategoriesItem(
                              SelectedGroupData(group: category),
                            );
                          }).toList(),
                    ),
                  ),
                ),
                FButton.icon(
                  onPress: () {
                    ProductionCategoriesDialog(context).show();
                  },
                  child: Icon(FIcons.coffee),
                ),
                FButton.icon(
                  onPress: () {
                    PinnedCategoriesDialog(context).show();
                  },
                  child: Icon(FIcons.settings2),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _OrderCatalogCategoriesItem extends StatelessWidget {
  const _OrderCatalogCategoriesItem(this.data);

  final SelectedGroupData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: selectedCategory,
      builder: (context, value, child) {
        final selected = value == data;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              selectedCategory.value = data;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                color: selected ? theme.custom.primary : theme.custom.muted,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                spacing: 4,
                children: [
                  if (data.group == null || data.all || data.favorite)
                    Icon(
                      data.all
                          ? FluentIcons.list_24_regular
                          : data.favorite
                          ? FluentIcons.star_24_regular
                          : Icons.close,
                      size: 14,
                      color: selected
                          ? theme.custom.primaryForeground
                          : theme.custom.foreground,
                    ),
                  Text(
                    data.all
                        ? 'Все'
                        : data.favorite
                        ? 'Избраные'
                        : data.group?.name ?? 'Без категории',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: selected
                          ? theme.custom.primaryForeground
                          : theme.custom.foreground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CatalogGrid extends StatelessWidget {
  const _CatalogGrid();

  List<ProductData> getItems(
    BuildContext context, {
    required SelectedGroupData? selectedGroup,
    required List<GroupScheme> productionGroups,
    required String? searchQuery,
    required List<String> favoriteKeys,
    required List<String> pinned,
    required List<ProductData> products,
    required List<WarehouseItemScheme> warehouseItems,
  }) {
    final productionGroupKeys = productionGroups.map((i) => i.refKey).toSet();
    final favoriteKeysSet = favoriteKeys.toSet();
    final lowerSearchQuery = searchQuery?.toLowerCase() ?? '';
    final hasSearchQuery = lowerSearchQuery.isNotEmpty;
    final selectedGroupKey = selectedGroup?.group?.refKey;
    final isFavoriteFilter = selectedGroup?.favorite ?? false;

    final result = <ProductData>[];
    final addedIds = <String>{};

    bool isMatch(ProductData product) {
      if (selectedGroupKey != null) {
        if (product.nomenclature.groupKey != selectedGroupKey) return false;
      } else if (isFavoriteFilter) {
        if (!favoriteKeysSet.contains(product.uniqueId)) return false;
      }

      if (hasSearchQuery) {
        if (!product.name.toLowerCase().contains(lowerSearchQuery)) {
          return false;
        }
      }
      return true;
    }

    final productMap = {for (final p in products) p.uniqueId: p};

    for (final i in warehouseItems) {
      final product = productMap[i.uniqueId];
      if (product != null &&
          isMatch(product) &&
          addedIds.add(product.uniqueId)) {
        result.add(product);
      }
    }

    for (final product in products) {
      if (productionGroupKeys.contains(product.nomenclature.groupKey)) {
        if (isMatch(product) && addedIds.add(product.uniqueId)) {
          result.add(product);
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, state) {
        return BlocBuilder<WarehouseCubit, WarehouseState>(
          builder: (context, warehouseState) {
            return BlocBuilder<SettingsCubit, SettingsState>(
              bloc: BlocProvider.of<SettingsCubit>(context),
              builder: (context, settingsState) {
                return BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, favoriteState) {
                    return ValueListenableBuilder(
                      valueListenable: selectedCategory,
                      builder: (context, selectedCat, child) {
                        return ValueListenableBuilder(
                          valueListenable: productSeachQuery,
                          builder: (context, searchQuery, child) {
                            final products = getItems(
                              context,
                              selectedGroup: selectedCat,
                              searchQuery: searchQuery,
                              productionGroups: settingsState.productionGroups,
                              pinned: settingsState.pinnedCategories,
                              favoriteKeys: favoriteState.favoriteKeys,
                              products: state.products,
                              warehouseItems: warehouseState.items,
                            );

                            final warehouseItemsMap = {
                              for (final i in warehouseState.items)
                                i.uniqueId: i,
                            };
                            final productionGroupKeys = settingsState
                                .productionGroups
                                .map((i) => i.refKey)
                                .toSet();

                            if (products.isEmpty) {
                              return _GridEmptyItems(searchQuery: searchQuery);
                            } else {
                              return _CatalogTable(
                                products,
                                warehouseItemsMap: warehouseItemsMap,
                                productionGroupKeys: productionGroupKeys,
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _CatalogTable extends StatelessWidget {
  const _CatalogTable(
    this.products, {
    required this.warehouseItemsMap,
    required this.productionGroupKeys,
  });

  final List<ProductData> products;
  final Map<String, WarehouseItemScheme> warehouseItemsMap;
  final Set<String> productionGroupKeys;
  final double itemMinWidth = 180;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          padding: const EdgeInsets.only(right: 12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (constraints.maxWidth / itemMinWidth).floor().clamp(
              1,
              10,
            ),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return RepaintBoundary(
              child: ProductCard(
                product: product,
                warehouseItem: warehouseItemsMap[product.uniqueId],
                isProduction: productionGroupKeys.contains(
                  product.nomenclature.groupKey,
                ),
              ),
            );
          },
          itemCount: products.length,
        );
      },
    );
  }
}

class _GridEmptyItems extends StatelessWidget {
  const _GridEmptyItems({required this.searchQuery});

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FluentIcons.emoji_sad_24_regular,
            size: 128,
            color: theme.custom.mutedForeground,
          ),
          if (searchQuery.isNotEmpty)
            SizedBox(
              width: 240,
              child: Text(
                'По запросу "$searchQuery" Ничего не найдено',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: theme.custom.mutedForeground,
                ),
              ),
            ),
          if (searchQuery.isEmpty)
            Text(
              'Пусто',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: theme.custom.mutedForeground,
              ),
            ),
        ],
      ),
    );
  }
}
