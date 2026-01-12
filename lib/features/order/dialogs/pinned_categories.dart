import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/states/states.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class PinnedCategoriesDialog {
  PinnedCategoriesDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog.raw(
          builder: (context, style) {
            return Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  title(),
                  Expanded(child: categoriesList()),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget title() {
    return FHeader.nested(
      title: Text('Закрепленные категории'),
      titleAlignment: Alignment.centerLeft,
      prefixes: [Icon(FIcons.pin, size: 24)],
      suffixes: [
        FButton.icon(
          onPress: () {
            AutoRouter.of(rootContext).maybePop();
          },
          child: Icon(Icons.close),
        ),
      ],
    );
  }

  Widget categoriesList() {
    final cubit = BlocProvider.of<CategoriesCubit>(rootContext);
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      bloc: cubit,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children:
                [categoriesListItem(null, state.showEmpty, cubit)] +
                state.categories.map((category) {
                  return categoriesListItem(category, null, cubit);
                }).toList(),
          ),
        );
      },
    );
  }

  Widget categoriesListItem(
    CategoryScheme? category,
    bool? showEmpty,
    CategoriesCubit cubit,
  ) {
    final pinned =
        cubit.state.pinned.contains(category?.refKey) || (showEmpty ?? false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          spacing: 4,
          children: [
            if (category == null) Icon(Icons.close),
            Text(category?.name ?? 'Без категорий'),
          ],
        ),
        Expanded(child: CustomDottedLine()),
        Transform.scale(
          scale: 0.75,
          child: FSwitch(
            value: pinned,
            onChange: (value) {
              if (category != null) {
                if (pinned) {
                  cubit.unpin(category);
                } else {
                  cubit.pin(category);
                }
              } else {
                cubit.switchShowEmpty();
              }

              selectedCategory.value = defaultSelectedCategory;
            },
          ),
        ),
      ],
    );
  }
}
