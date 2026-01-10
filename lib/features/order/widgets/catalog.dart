import 'package:app/shared/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
      width: 280,
      child: FTextField(
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
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 12,
          children: [
            _OrderCatalogCategoriesItem(label: 'Торты'),
            _OrderCatalogCategoriesItem(label: 'Выпечки'),
            _OrderCatalogCategoriesItem(label: 'Кофе'),
            _OrderCatalogCategoriesItem(label: 'Напитки'),
            _OrderCatalogCategoriesItem(label: 'Десерт'),
            _OrderCatalogCategoriesItem(label: 'Разное'),
            _OrderCatalogCategoriesItem(label: 'На день рождение'),
          ],
        ),
      ),
    );
  }
}

class _OrderCatalogCategoriesItem extends StatelessWidget {
  const _OrderCatalogCategoriesItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.custom.muted,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label),
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
