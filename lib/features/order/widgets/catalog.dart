import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/dialogs/dialogs.dart';
import 'package:app/features/order/states/states.dart';
import 'package:app/models/models.dart';
import 'package:app/models/nomenclature.dart';
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

class _OrderCatalogSearchBar extends StatelessWidget {
  const _OrderCatalogSearchBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: FTextField(
        control: FTextFieldControl.managed(
          onChange: (value) {
            productSeachQuery.value = value.text;
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
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      bloc: BlocProvider.of<CategoriesCubit>(context),
      builder: (context, state) {
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
                        _OrderCatalogCategoriesItem(favoriteSelectedCategory),
                        if (state.showEmpty)
                          _OrderCatalogCategoriesItem(SelectedCategoryData()),
                      ] +
                      state.pinnedCategories.map((category) {
                        return _OrderCatalogCategoriesItem(
                          SelectedCategoryData(category: category),
                        );
                      }).toList(),
                ),
              ),
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
  }
}

class _OrderCatalogCategoriesItem extends StatelessWidget {
  const _OrderCatalogCategoriesItem(this.data);

  final SelectedCategoryData data;

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
                  if (data.category == null || data.all || data.favorite)
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
                        : data.category?.name ?? 'Без категории',
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

  final double itemMinWidth = 180;

  List<NomenclatureScheme> getItems({
    required SelectedCategoryData? selectedCategory,
    required String? searchQuery,
    required List<String> favoriteKeys,
    required List<String> pinned,
    required List<NomenclatureScheme> nomenclatures,
  }) {
    List<NomenclatureScheme> selectedCategoryItems = List.from(nomenclatures);
    if (selectedCategory?.category != null) {
      selectedCategoryItems = selectedCategoryItems
          .where((i) => i.categoryKey == selectedCategory!.category!.refKey)
          .toList();
    } else if (selectedCategory?.all ?? false) {
      selectedCategoryItems = selectedCategoryItems
          .where((i) => pinned.contains(i.categoryKey))
          .toList();
    } else if (selectedCategory?.favorite ?? false) {
      selectedCategoryItems = selectedCategoryItems
          .where((i) => favoriteKeys.contains(i.refKey))
          .toList();
    }

    List<NomenclatureScheme> searchQueryItems = List.from(
      selectedCategoryItems,
    );

    if (searchQuery?.isNotEmpty ?? false) {
      searchQueryItems = searchQueryItems
          .where(
            (i) =>
                i.name?.toLowerCase().contains(searchQuery!.toLowerCase()) ??
                false,
          )
          .toList();
    }

    return searchQueryItems;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      bloc: BlocProvider.of<ProductsCubit>(context),
      builder: (context, productState) {
        if (productState is ProductsLoading) {
          return Center(child: FCircularProgress());
        }
        return BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, categoriesState) {
            return BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, favoriteState) {
                return ValueListenableBuilder(
                  valueListenable: selectedCategory,
                  builder: (context, selectedCat, child) {
                    return ValueListenableBuilder(
                      valueListenable: productSeachQuery,
                      builder: (context, searchQuery, child) {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final nomenclatures = getItems(
                              selectedCategory: selectedCat,
                              searchQuery: searchQuery,
                              pinned: categoriesState.pinned,
                              favoriteKeys: favoriteState.favoriteKeys,
                              nomenclatures: productState.nomenclatures,
                            );
                            if (nomenclatures.isEmpty) {
                              return _GridEmptyItems(searchQuery: searchQuery);
                            }
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        (constraints.maxWidth / itemMinWidth)
                                            .floor()
                                            .clamp(1, 10),
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 0.75,
                                  ),
                              itemBuilder: (context, index) {
                                final nomenclature = nomenclatures[index];
                                final prices =
                                    ProductsCubitUtils.getNomenclaturePrices(
                                      nomenclature: nomenclature,
                                      allPrices: productState.prices,
                                    );
                                final characteristics =
                                    ProductsCubitUtils.getNomenclatureCharacteristics(
                                      nomenclature: nomenclature,
                                      allCharacteristics:
                                          productState.characteristics,
                                    );
                                return ProductCard(
                                  nomenclature: nomenclatures[index],
                                  prices: prices,
                                  characteristics: characteristics,
                                );
                              },
                              itemCount: nomenclatures.length,
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
