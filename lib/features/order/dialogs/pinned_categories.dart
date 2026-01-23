import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/states/states.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
    final cubit = BlocProvider.of<SettingsCubit>(rootContext);
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, state) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          bloc: cubit,
          builder: (context, settingsState) {
            return SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  catalogView(settingsState.catalogListView, cubit),
                  Column(
                    children:
                        [
                          categoriesListItem(
                            null,
                            settingsState.showEmptyCategories,
                            cubit,
                          ),
                        ] +
                        state.categories.map((category) {
                          return categoriesListItem(category, null, cubit);
                        }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget catalogView(bool listView, SettingsCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          spacing: 4,
          children: [Icon(FluentIcons.list_20_regular), Text('В виде списка')],
        ),
        Expanded(child: CustomDottedLine()),
        Transform.scale(
          scale: 0.75,
          child: FSwitch(
            value: listView,
            onChange: (value) {
              cubit.setSettings(catalogListView: value);
            },
          ),
        ),
      ],
    );
  }

  Widget categoriesListItem(
    CategoryScheme? category,
    bool? showEmpty,
    SettingsCubit cubit,
  ) {
    final pinned =
        cubit.state.pinnedCategories.contains(category?.refKey) ||
        (showEmpty ?? false);
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
                  final List<String> pinnedCategories = List.from(
                    cubit.state.pinnedCategories,
                  );
                  pinnedCategories.remove(category.refKey);
                  cubit.setSettings(pinnedCategories: pinnedCategories);
                } else {
                  final List<String> pinnedCategories = List.from(
                    cubit.state.pinnedCategories,
                  );
                  pinnedCategories.add(category.refKey);
                  cubit.setSettings(pinnedCategories: pinnedCategories);
                }
              } else {
                cubit.setSettings(
                  showEmptyCategories: cubit.state.showEmptyCategories,
                );
              }

              selectedCategory.value = favoriteSelectedCategory;
            },
          ),
        ),
      ],
    );
  }
}
