import 'package:app/blocs/blocs.dart';
import 'package:app/features/sell_history/blocs/return_check/return_check_cubit.dart';
import 'package:app/models/check.dart';
import 'package:app/service/service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class ReturnCheckDialog {
  ReturnCheckDialog(this.rootContext, {required this.check});

  final BuildContext rootContext;
  final DetailCheckScheme check;

  late final ReturnCheckCubit cubit;

  void show() {
    cubit = ReturnCheckCubit(
      check,
      BlocProvider.of<SettingsCubit>(rootContext),
      BlocProvider.of<SessionCubit>(rootContext),
      BlocProvider.of<AuthCubit>(rootContext),
    );
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog.raw(
          constraints: BoxConstraints(minWidth: 1000, maxWidth: 1000),
          builder: (context, _) {
            return MultiBlocProvider(
              providers: [BlocProvider.value(value: cubit)],
              child: BlocListener<ReturnCheckCubit, ReturnCheckState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is ReturnCheckLoaded) {
                    ToastService.showToast(
                      context,
                      notification: NotificationData(
                        type: NotificationType.success,
                        title: 'Выполен возврат',
                        description:
                            'Выполнен возврат для чека ${check.number}',
                      ),
                    );
                    AutoRouter.of(context).maybePop();
                  }
                },
                child: Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        title(),
                        Expanded(child: table()),
                        actions(),
                      ],
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
      prefixes: [Icon(FluentIcons.arrow_hook_up_left_24_regular, size: 28)],
      title: Text('Возврат чека'),
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

  Widget table() {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, dataState) {
        return BlocBuilder<ReturnCheckCubit, ReturnCheckState>(
          bloc: cubit,
          builder: (context, state) {
            return DataTable2(
              dividerThickness: 0,
              columns: [
                DataColumn2(label: Text('Название')),
                DataColumn2(label: Text('Характеристика')),
                DataColumn2(label: Text('Цена'), numeric: true),
                DataColumn2(label: Text('Кол-во'), numeric: true),
              ],
              rows: state.items.map((item) {
                final nomenclature = dataState.nomenclatures
                    .firstWhereLogTypeOrNull(
                      (i) => i.refKey == item.nomenclatureKey,
                    );
                final characteristic = dataState.characteristics
                    .firstWhereLogTypeOrNull(
                      (i) => i.refKey == item.characteristicKey,
                    );
                return DataRow2(
                  cells: [
                    DataCell(Text(nomenclature?.description ?? '')),
                    DataCell(Text(characteristic?.description ?? '')),
                    DataCell(Text(NumberFormat().format(item.price))),
                    DataCell(_ItemQuantity(item)),
                  ],
                );
              }).toList(),
            );
          },
        );
      },
    );
  }

  Widget actions() {
    return BlocBuilder<ReturnCheckCubit, ReturnCheckState>(
      bloc: cubit,
      builder: (context, state) {
        return Opacity(
          opacity: state.notEmptyItems.isNotEmpty ? 1 : 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FLabel(
                label: Text('Сумма возврата'),
                axis: Axis.vertical,
                child: Text(
                  NumberFormat().format(state.totalSum),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),

              FButton(
                onPress: () {
                  if (state.notEmptyItems.isNotEmpty &&
                      state is! ReturnCheckLoading) {
                    cubit.createCheckReturn();
                  }
                },
                prefix: state is ReturnCheckLoading
                    ? FCircularProgress()
                    : Icon(FluentIcons.arrow_hook_up_left_24_regular),
                style: FButtonStyle.destructive(),
                child: Text('Возврат'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ItemQuantity extends StatefulWidget {
  const _ItemQuantity(this.item);

  final ReturnCheckItemData item;

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
    final cubit = BlocProvider.of<ReturnCheckCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 8,
      children: [
        FButton.icon(
          onPress: () {
            cubit.update(widget.item.copyWith(widget.item.quantity - 1));
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
                  cubit.update(widget.item.copyWith(value_));
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
            cubit.update(widget.item.copyWith(widget.item.quantity + 1));
          },
          style: FButtonStyle.primary(),
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
