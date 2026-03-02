import 'package:app/blocs/blocs.dart';
import 'package:app/features/movement/blocs/create_movement/create_movement_cubit.dart';
import 'package:app/features/movement/widgets/movement_card.dart';
import 'package:app/models/group.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/utils/debounce_notifier.dart';
import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class CreateMovementDialog {
  CreateMovementDialog(this.rootContext);

  final BuildContext rootContext;

  CreateMovementCubit get cubit =>
      BlocProvider.of<CreateMovementCubit>(rootContext);

  final searchValue = DebouncedNotifier(notifier: ValueNotifier<String>(''));

  final groupValue = ValueNotifier<GroupScheme?>(null);

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return BlocListener<CreateMovementCubit, CreateMovementState>(
          bloc: cubit,
          listener: (context, state) {
            if (state is CreateMovementLoaded) {
              BlocProvider.of<MovementsCubit>(context).update();
              AutoRouter.of(rootContext).maybePop();
            }
          },
          child: FDialog.raw(
            constraints: BoxConstraints(maxWidth: double.infinity),
            builder: (context, _) {
              return Material(
                type: MaterialType.transparency,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      header(),
                      Expanded(
                        child: Row(
                          spacing: 12,
                          children: [
                            Expanded(flex: 5, child: catalog()),
                            Expanded(flex: 5, child: basket()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget header() {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.arrow_download_24_regular)],
      title: Text('Создание документа на перемещение'),
      titleAlignment: Alignment.centerLeft,
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

  Widget catalog() {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, state) {
        return Column(
          spacing: 12,
          children: [
            search(),
            category(),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: searchValue.notifier,
                builder: (context, value, child) {
                  return ValueListenableBuilder(
                    valueListenable: groupValue,
                    builder: (context, value, child) {
                      final Iterable<ProductData> categoryItems;
                      if (groupValue.value != null) {
                        categoryItems = state.products.where(
                          (i) =>
                              i.nomenclature.groupKey ==
                              groupValue.value?.refKey,
                        );
                      } else {
                        categoryItems = state.products;
                      }
                      final searchItems = categoryItems
                          .where(
                            (i) => i.name.toLowerCase().contains(
                              searchValue.notifier.value.toLowerCase(),
                            ),
                          )
                          .toList();
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            padding: const EdgeInsets.only(right: 12),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (constraints.maxWidth / 160)
                                      .floor()
                                      .clamp(1, 10),
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 0.65,
                                ),
                            itemBuilder: (context, index) {
                              return MovementCard(
                                product: searchItems[index],
                                cubit: BlocProvider.of<CreateMovementCubit>(
                                  rootContext,
                                ),
                              );
                            },
                            itemCount: searchItems.length,
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
      },
    );
  }

  Widget search() {
    return FTextField(
      prefixBuilder: (context, style, states) => Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Icon(FIcons.search),
      ),
      hint: 'Поиск',
      control: FTextFieldControl.managed(
        onChange: (value) {
          searchValue.setValue(value.text);
        },
      ),
    );
  }

  Widget category() {
    final theme = Theme.of(rootContext);
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of(rootContext),
      builder: (context, state) {
        return ValueListenableBuilder(
          valueListenable: groupValue,
          builder: (context, value, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8,
                children:
                    [
                      GestureDetector(
                        onTap: () {
                          groupValue.value = null;
                        },
                        child: FBadge(
                          style: (style) => style.copyWith(
                            decoration: BoxDecoration(
                              color: value == null
                                  ? theme.custom.primary
                                  : theme.custom.muted,
                              borderRadius: BorderRadius.circular(128),
                            ),
                            contentStyle: (style) => style.copyWith(
                              labelTextStyle: TextStyle(
                                color: value == null
                                    ? theme.custom.primaryForeground
                                    : theme.custom.foreground,
                              ),
                            ),
                          ),
                          child: Text('Все'),
                        ),
                      ),
                    ] +
                    state.groups.map((i) {
                      final active = groupValue.value == i;
                      return GestureDetector(
                        onTap: () {
                          groupValue.value = i;
                        },
                        child: FBadge(
                          style: (style) => style.copyWith(
                            decoration: BoxDecoration(
                              color: active
                                  ? theme.custom.primary
                                  : theme.custom.muted,
                              borderRadius: BorderRadius.circular(128),
                            ),
                            contentStyle: (style) => style.copyWith(
                              labelTextStyle: TextStyle(
                                color: active
                                    ? theme.custom.primaryForeground
                                    : theme.custom.foreground,
                              ),
                            ),
                          ),
                          child: Text(i.name),
                        ),
                      );
                    }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  Widget basket() {
    final theme = Theme.of(rootContext);
    final cubit = BlocProvider.of<CreateMovementCubit>(rootContext);
    return BlocBuilder<CreateMovementCubit, CreateMovementState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          spacing: 12,
          children: [
            Expanded(
              child: DataTable2(
                dividerThickness: 0,
                columnSpacing: 8,
                columns: [
                  DataColumn2(label: Text('Название')),
                  DataColumn2(label: Text('Характеристика')),
                  DataColumn2(label: Text('Кол-во'), numeric: true),
                  DataColumn2(label: SizedBox(), fixedWidth: 36, numeric: true),
                ],
                rows: state.items.map((item) {
                  final index = state.items.indexOf(item);
                  return DataRow2(
                    color: WidgetStatePropertyAll(
                      index.isOdd
                          ? theme.custom.rowOddColor
                          : theme.custom.rowEvenColor,
                    ),
                    cells: [
                      DataCell(
                        Text(item.product.nomenclature.description ?? ''),
                      ),
                      DataCell(
                        Text(item.product.characteristic?.description ?? ''),
                      ),
                      DataCell(MovementItemQuantity(item, cubit)),
                      DataCell(
                        FButton.icon(
                          onPress: () {
                            cubit.deleteItem(item);
                          },
                          child: Icon(FIcons.trash),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            accept(),
          ],
        );
      },
    );
  }

  Widget accept() {
    final theme = Theme.of(rootContext);
    final cubit = BlocProvider.of<CreateMovementCubit>(rootContext);
    return BlocBuilder<CreateMovementCubit, CreateMovementState>(
      bloc: cubit,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FLabel(
              label: Text('Сумма документа'),
              axis: Axis.vertical,
              child: Text(NumberFormat().format(state.totalSum)),
            ),
            FButton(
              onPress: () {
                if (state.items.isNotEmpty) {
                  cubit.create();
                }
              },
              style: (style) => style.copyWith(
                decoration: FWidgetStateMap.all(
                  BoxDecoration(
                    color: state.items.isNotEmpty
                        ? theme.custom.success
                        : theme.custom.success.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              prefix: state is CreateMovementLoading
                  ? FCircularProgress()
                  : null,
              child: Text('Создать'),
            ),
          ],
        );
      },
    );
  }
}
