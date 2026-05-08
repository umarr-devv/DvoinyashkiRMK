import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/dialogs/dialogs.dart';
import 'package:app/models/group.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class SmartCatalog extends StatefulWidget {
  const SmartCatalog({super.key});

  @override
  State<SmartCatalog> createState() => _SmartCatalogState();
}

class _SmartCatalogState extends State<SmartCatalog> {
  GroupScheme? selectedGroup;

  @override
  Widget build(BuildContext context) {
    if (selectedGroup != null) {
      return _buildProductsView();
    }
    return _buildCategoriesView();
  }

  Widget _buildCategoriesView() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        return BlocBuilder<DataCubit, DataState>(
          builder: (context, dataState) {
            final pinnedCategories = settingsState.pinnedCategories;
            final groups = dataState.groups
                .where((group) => pinnedCategories.contains(group.refKey))
                .toList();
            return FScaffold(
              header: FHeader(
                title: Text('Каталог'),
                suffixes: [
                  FButton.icon(
                    onPress: () {
                      PinnedCategoriesDialog(context).show();
                    },
                    child: Icon(FIcons.settings2),
                  ),
                ],
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return _CategoryCard(
                    group: group,
                    onTap: () {
                      setState(() {
                        selectedGroup = group;
                      });
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProductsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              FButton.icon(
                onPress: () {
                  setState(() {
                    selectedGroup = null;
                  });
                },
                child: const Icon(FluentIcons.arrow_left_24_regular),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  selectedGroup!.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, settingsState) {
              final isProduction = settingsState.productionGroups.any(
                (g) => g.refKey == selectedGroup!.refKey,
              );

              return BlocBuilder<DataCubit, DataState>(
                builder: (context, dataState) {
                  final products = dataState.products.where((product) {
                    return product.nomenclature.groupKey ==
                        selectedGroup!.refKey;
                  }).toList();

                  if (products.isEmpty) {
                    return const Center(child: Text('Нет товаров в категории'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        isProduction: isProduction,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.group, required this.onTap});

  final GroupScheme group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.custom.byUuid(group.name);
    return FCard.raw(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: .circular(8),
          ),
          child: Center(
            child: Text(
              group.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
