import 'package:app/blocs/blocs.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/features/movement/blocs/create_movement/create_movement_cubit.dart';
import 'package:app/models/models.dart';
import 'package:app/service/service.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class CreateMovementDialog {
  CreateMovementDialog(this.rootContext);

  final BuildContext rootContext;

  CreateMovementCubit get cubit =>
      BlocProvider.of<CreateMovementCubit>(rootContext);

  final formKey = GlobalKey<FormState>();

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog.raw(
          constraints: BoxConstraints(maxWidth: 1100),
          builder: (context, _) {
            return MultiBlocProvider(
              providers: [BlocProvider.value(value: cubit)],
              child: BlocListener<CreateMovementCubit, CreateMovementState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is CreateMovementFailure) {
                    ErrorDialog(
                      context,
                      label: 'Ошибка с сетью',
                      description:
                          'Произошла ошибка с сетью, повторите попытку похже',
                    );
                  } else if (state is CreateMovementLoaded) {
                    ToastService.showToast(
                      context,
                      notification: NotificationData(
                        type: NotificationType.success,
                        title: 'Заказ создан',
                        description: 'Заказ на перемещение создана',
                      ),
                    );
                    BlocProvider.of<MovementsCubit>(context).update();
                    AutoRouter.of(context).maybePop();
                  }
                },
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Form(
                      key: formKey,
                      child: Column(
                        spacing: 16,
                        children: [
                          title(),
                          selectDate(),
                          selectReserve(),
                          addItem(),
                          Expanded(child: table()),
                          actions(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget title() {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.arrow_download_24_regular, size: 28)],
      title: Text('Создания заказа на перемещение'),
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

  Widget selectReserve() {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, dataState) {
        return BlocBuilder<CreateMovementCubit, CreateMovementState>(
          bloc: cubit,
          builder: (context, state) {
            return FSelect<StructureUnitScheme>.searchBuilder(
              label: Text('Склад'),
              hint: 'Выберите склад',
              control: FSelectControl.lifted(
                value: state.reserve,
                onChange: (value) {
                  if (value != null) {
                    cubit.update(state.copyWith(reserve: value));
                  }
                },
              ),
              contentEmptyBuilder: (context, style) => Padding(
                padding: const EdgeInsetsGeometry.symmetric(vertical: 12),
                child: Text('Ничего не найдено'),
              ),
              searchFieldProperties: FSelectSearchFieldProperties(
                hint: 'Поиск',
              ),
              validator: (value) {
                if (value == null) {
                  return 'Выберите склад';
                }
                return null;
              },
              format: (i) => i.description,
              filter: (query) => dataState.structureUnits.where((i) {
                return i.typeDetail == warehouseStructureDetailType;
              }),
              contentBuilder: (context, query, values) {
                if (query.length < 2) {
                  return [];
                }
                return dataState.structureUnits
                    .where((i) {
                      return i.typeDetail == warehouseStructureDetailType &&
                          i.description.toLowerCase().contains(
                            query.toLowerCase(),
                          );
                    })
                    .map((i) {
                      return FSelectItem(title: Text(i.description), value: i);
                    })
                    .toList();
              },
            );
          },
        );
      },
    );
  }

  Widget selectDate() {
    return BlocBuilder<CreateMovementCubit, CreateMovementState>(
      bloc: cubit,
      builder: (context, state) {
        return FDateField.calendar(
          label: Text('Время'),
          start: DateTime.now(),
          hint: 'Выберит дату',
          control: FDateFieldControl.managed(
            onChange: (value) {
              if (value != null) {
                cubit.update(state.copyWith(movementDate: value));
              }
            },
            validator: (value) {
              if (value == null) {
                return 'Выбрите дату для заказа';
              }
              return null;
            },
          ),
        );
      },
    );
  }

  Widget addItem() {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, dataState) {
        return FAutocomplete.builder(
          label: Text('Номенклатура'),
          hint: 'Поиск',
          clearable: (value) => value.text.isNotEmpty,
          filter: (text) {
            return [];
          },
          control: FAutocompleteControl.managed(),
          contentBuilder: (context, query, values) {
            return dataState.products
                .where((i) {
                  return i.uniqueName.toLowerCase().contains(
                    query.toLowerCase(),
                  );
                })
                .map((i) {
                  return FAutocompleteItem(
                    value: i.uniqueName,
                    suffix: FButton.icon(
                      onPress: () {
                        cubit.setItem(
                          CreateMovementItemData(product: i, quantity: 1),
                        );
                      },
                      child: Text('Добавить'),
                    ),
                  );
                })
                .take(25)
                .toList();
          },
        );
      },
    );
  }

  Widget table() {
    final theme = Theme.of(rootContext);
    return BlocBuilder<CreateMovementCubit, CreateMovementState>(
      bloc: cubit,
      builder: (context, state) {
        return DataTable2(
          dividerThickness: 0,
          columnSpacing: 4,
          columns: [
            DataColumn2(label: Text('Название'), size: ColumnSize.L),
            DataColumn2(label: Text('Характеристика')),
            DataColumn2(label: Text('Цена'), numeric: true, size: ColumnSize.S),
            DataColumn2(
              label: Text('Кол-во'),
              numeric: true,
              size: ColumnSize.M,
            ),
            DataColumn2(label: Text('Сумма'), numeric: true),
            DataColumn2(label: SizedBox(), numeric: true, fixedWidth: 96),
          ],
          rows: state.items.map((i) {
            final index = state.items.indexOf(i);
            return DataRow2(
              color: WidgetStatePropertyAll(
                index.isOdd
                    ? theme.custom.rowOddColor
                    : theme.custom.rowEvenColor,
              ),
              cells: [
                DataCell(Text(i.product.nomenclature.description ?? '')),
                DataCell(Text(i.product.characteristic?.description ?? '')),
                DataCell(
                  Text(
                    NumberFormat().format(
                      i.product.sellPrice?.price.price ?? 0,
                    ),
                  ),
                ),
                DataCell(_ItemQuantity(i)),
                DataCell(Text(NumberFormat().format(i.totalSum))),
                DataCell(
                  FButton.icon(
                    onPress: () {
                      cubit.deleteItem(i);
                    },
                    child: Icon(FIcons.trash),
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  Widget actions() {
    final theme = Theme.of(rootContext);
    return BlocBuilder<CreateMovementCubit, CreateMovementState>(
      bloc: cubit,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FLabel(
              label: Text('Сумма документа'),
              axis: Axis.vertical,
              child: Text(
                NumberFormat().format(state.totalSum),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            Opacity(
              opacity: state.items.isNotEmpty ? 1 : 0.5,
              child: FButton(
                onPress: () {
                  if ((formKey.currentState?.validate() ?? false) &&
                      state.items.isNotEmpty &&
                      state is! CreateMovementLoading) {
                    cubit.create();
                  }
                },
                style: (style) => style.copyWith(
                  decoration: FWidgetStateMap.all(
                    BoxDecoration(
                      color: theme.custom.success,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                prefix: state is CreateMovementLoading
                    ? FCircularProgress()
                    : null,
                child: Text(
                  'Создать заказ',
                  style: TextStyle(color: theme.custom.actionForeground),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ItemQuantity extends StatefulWidget {
  const _ItemQuantity(this.item);

  final CreateMovementItemData item;

  @override
  State<_ItemQuantity> createState() => _ItemQuantityState();
}

class _ItemQuantityState extends State<_ItemQuantity> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.item.quantity.toStringAsFixed(2),
    );
  }

  @override
  void didUpdateWidget(covariant _ItemQuantity oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newText = widget.item.quantity.toStringAsFixed(2);

    if (_controller.text != newText) {
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateMovementCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 8,
      children: [
        FButton.icon(
          onPress: () {
            cubit.setItem(widget.item.copyWith(widget.item.quantity - 1));
          },
          style: FButtonStyle.secondary(),
          child: Icon(Icons.remove),
        ),
        SizedBox(
          width: 80,
          child: FTextField(
            textAlign: TextAlign.right,
            control: FTextFieldControl.managed(
              controller: _controller,
              onChange: (value) {
                final value_ = double.tryParse(value.text);
                if (value_ != null) {
                  cubit.setItem(widget.item.copyWith(value_));
                }
              },
            ),
            inputFormatters: [
              CurrencyInputFormatter(
                thousandSeparator: ThousandSeparator.Space,
                mantissaLength: 2,
              ),
            ],
          ),
        ),
        FButton.icon(
          onPress: () {
            cubit.setItem(widget.item.copyWith(widget.item.quantity + 1));
          },
          style: FButtonStyle.primary(),
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
