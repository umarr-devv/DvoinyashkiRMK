import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/states/states.dart';
import 'package:app/models/group.dart';
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
      title: const Text('Настройки групп'),
      titleAlignment: Alignment.centerLeft,
      prefixes: const [Icon(FIcons.pin, size: 24)],
      suffixes: [
        FButton.icon(
          onPress: () {
            AutoRouter.of(rootContext).maybePop();
          },
          child: const Icon(Icons.close),
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
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      const SizedBox(
                        width: 80,
                        child: Text(
                          'Закрепить',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                        child: Text(
                          'Авто-сборка',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children:
                        [
                          groupListItem(
                            null,
                            settingsState.showEmptyCategories,
                            cubit,
                          ),
                        ] +
                        state.groups.map((group) {
                          return groupListItem(group, null, cubit);
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

  Widget groupListItem(
    GroupScheme? group,
    bool? showEmpty,
    SettingsCubit cubit,
  ) {
    final pinned = group != null
        ? cubit.state.pinnedCategories.contains(group.refKey)
        : (showEmpty ?? false);

    final production =
        group != null &&
        cubit.state.productionGroups.any((g) => g.refKey == group.refKey);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          spacing: 4,
          children: [
            if (group == null) const Icon(Icons.close),
            Text(group?.name ?? 'Без категорий'),
          ],
        ),
        const Expanded(child: CustomDottedLine()),
        SizedBox(
          width: 80,
          child: Center(
            child: Transform.scale(
              scale: 0.75,
              child: FSwitch(
                value: pinned,
                onChange: (value) {
                  if (group != null) {
                    final List<String> pinnedCategories = List.from(
                      cubit.state.pinnedCategories,
                    );
                    if (value) {
                      if (!pinnedCategories.contains(group.refKey)) {
                        pinnedCategories.add(group.refKey);
                      }
                    } else {
                      pinnedCategories.remove(group.refKey);
                    }
                    cubit.setSettings(pinnedCategories: pinnedCategories);
                  } else {
                    cubit.setSettings(showEmptyCategories: value);
                  }
                  selectedCategory.value = favoriteSelectedCategory;
                },
              ),
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: Center(
            child: group == null
                ? const SizedBox()
                : Transform.scale(
                    scale: 0.75,
                    child: FSwitch(
                      value: production,
                      onChange: (value) {
                        final List<GroupScheme> productionGroups = List.from(
                          cubit.state.productionGroups,
                        );
                        if (value) {
                          if (!productionGroups.any(
                            (g) => g.refKey == group.refKey,
                          )) {
                            productionGroups.add(group);
                          }
                        } else {
                          productionGroups.removeWhere(
                            (g) => g.refKey == group.refKey,
                          );
                        }
                        cubit.setSettings(productionGroups: productionGroups);
                      },
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
