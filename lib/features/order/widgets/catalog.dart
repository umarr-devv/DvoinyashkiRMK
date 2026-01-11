import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/states/category.dart';
import 'package:app/features/order/states/favorite.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    final theme = Theme.of(context);
    return SizedBox(
      width: 360,
      child: Row(
        spacing: 12,
        children: [
          Expanded(
            child: FTextField(
              prefixBuilder: (context, style, states) => Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Icon(FIcons.search),
              ),
              hint: 'Поиск',
            ),
          ),
          ValueListenableBuilder(
            valueListenable: favoriteOnly,
            builder: (context, value, child) {
              return FButton.icon(
                onPress: () {
                  favoriteOnly.value = !value;
                },
                child: value
                    ? Icon(
                        FluentIcons.star_24_filled,
                        color: theme.custom.secondaryAccent,
                      )
                    : Icon(FluentIcons.star_24_regular),
              );
            },
          ),
        ],
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
                      [_OrderCatalogCategoriesItem(null)] +
                      state.pinnedCategories.map((category) {
                        return _OrderCatalogCategoriesItem(category);
                      }).toList(),
                ),
              ),
            ),
            FButton.icon(onPress: () {}, child: Icon(FIcons.settings2)),
          ],
        );
      },
    );
  }
}

class _OrderCatalogCategoriesItem extends StatelessWidget {
  const _OrderCatalogCategoriesItem(this.category);

  final CategoryScheme? category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: selectedCategory,
      builder: (context, value, child) {
        final selected = selectedCategory.value?.refKey == category?.refKey;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              selectedCategory.value = category;
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
                  if (category == null)
                    Icon(
                      FluentIcons.list_24_regular,
                      size: 16,
                      color: selected
                          ? theme.custom.primaryForeground
                          : theme.custom.foreground,
                    ),
                  Text(
                    category?.name ?? 'Все',
                    style: TextStyle(
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (constraints.maxWidth / itemMinWidth).floor().clamp(
              1,
              10,
            ),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return FCard(
              image: CachedNetworkImage(
                height: 96,
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl:
                    'https://content3.flowwow-images.com/data/flowers/1000x1000/38/1720600418_7963038.jpg',
              ),
              title: Text('Торт'),
              subtitle: Text('Обычный торт'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('720 сом')],
                  ),
                ],
              ),
            );
          },
          itemCount: 64,
        );
      },
    );
  }
}
