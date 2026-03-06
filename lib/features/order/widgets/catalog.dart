import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/dialogs/dialogs.dart';
import 'package:app/features/order/states/states.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:talker_flutter/talker_flutter.dart';

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

class _OrderCatalogSearchBar extends StatelessWidget {
  const _OrderCatalogSearchBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: FTextField(
        control: FTextFieldControl.managed(
          onChange: (value) {
            productSeachQueryDebounce.setValue(value.text);
          },
        ),
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
    required String? searchQuery,
    required List<String> favoriteKeys,
    required List<String> pinned,
    required List<ProductData> products,
    required List<WarehouseItemScheme> warehouseItems,
  }) {
    final productMap = {for (final p in products) p.uniqueId: p};
    List<ProductData> warehouseProducts = [];

    for (final i in warehouseItems) {
      final item = productMap[i.uniqueId];
      if (item != null) {
        warehouseProducts.add(item);
      }
    }

    List<ProductData> selectedGroupItems = List.from(warehouseProducts);
    if (selectedGroup?.group != null) {
      selectedGroupItems = selectedGroupItems
          .where((i) => i.nomenclature.groupKey == selectedGroup!.group!.refKey)
          .toList();
    } else if (selectedGroup?.favorite ?? false) {
      selectedGroupItems = selectedGroupItems
          .where((i) => favoriteKeys.contains(i.uniqueId))
          .toList();
    }

    List<ProductData> searchQueryItems = List.from(selectedGroupItems);

    if (searchQuery?.isNotEmpty ?? false) {
      searchQueryItems = searchQueryItems
          .where(
            (i) => i.name.toLowerCase().contains(searchQuery!.toLowerCase()),
          )
          .toList();
    }

    return searchQueryItems;
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
                              pinned: settingsState.pinnedCategories,
                              favoriteKeys: favoriteState.favoriteKeys,
                              products: state.products,
                              warehouseItems: warehouseState.items,
                            );

                            final warehouseItemsMap = {
                              for (final i in warehouseState.items)
                                i.uniqueId: i,
                            };

                            if (products.isEmpty) {
                              return _GridEmptyItems(searchQuery: searchQuery);
                            }
                            if (settingsState.catalogListView) {
                              return _CatalogList(
                                products,
                                warehouseItemsMap: warehouseItemsMap,
                              );
                            } else {
                              return _CatalogTable(
                                products,
                                warehouseItemsMap: warehouseItemsMap,
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
  const _CatalogTable(this.products, {required this.warehouseItemsMap});

  final List<ProductData> products;
  final Map<String, WarehouseItemScheme> warehouseItemsMap;
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
            return ProductCard(
              product: product,
              warehouseItem: warehouseItemsMap[product.uniqueId],
            );
          },
          itemCount: products.length,
        );
      },
    );
  }
}

class _CatalogList extends StatelessWidget {
  const _CatalogList(this.products, {required this.warehouseItemsMap});

  final List<ProductData> products;
  final Map<String, WarehouseItemScheme> warehouseItemsMap;
  OrderItem? getOrderItem(OrderData? order, ProductData product) {
    return order?.items.firstWhereLogTypeOrNull(
      (i) => product.uniqueId == i.product.uniqueId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OrderCubit>(context);
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          spacing: 16,
          children: [
            Row(
              children: [
                Expanded(flex: 1, child: SizedBox()),
                Expanded(flex: 6, child: Text('Название')),
                Expanded(flex: 4, child: Text('Тип')),
                Expanded(flex: 4, child: Text('Цена')),
                SizedBox(
                  width: 150,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text('Кол-во'),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(right: 16),
                itemBuilder: (context, index) {
                  final item = products[index];
                  final orderItem = getOrderItem(state.currentOrder, item);
                  final warehouseItem = warehouseItemsMap[item.uniqueId];
                  return Row(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ProductCardFavoriteButton(
                          item,
                          padding: const EdgeInsets.all(0),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(item.nomenclature.name ?? ''),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(item.characteristic?.description ?? ''),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          item.sellPrice?.price.price.toStringAsFixed(2) ?? '',
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: ProductCardAddButton(
                            product: item,
                            orderItem: orderItem,
                            warehouseItem: warehouseItem,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => CustomDottedLine(),
                itemCount: products.length,
              ),
            ),
          ],
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
