import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:forui/forui.dart';

class OrderBasket extends StatelessWidget {
  const OrderBasket({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: 480,
      child: FCard.raw(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _OrderBasketTitle(),
              Expanded(child: _OrderBasketTable()),
              CustomDottedLine(),
              _OrderBasketSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderBasketTitle extends StatelessWidget {
  const _OrderBasketTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Корзина',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: theme.custom.foreground,
            ),
          ),
          FButton.icon(
            onPress: () {},
            style: FButtonStyle.destructive(),
            child: Icon(FIcons.trash),
          ),
        ],
      ),
    );
  }
}

class _OrderBasketTable extends StatelessWidget {
  const _OrderBasketTable();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OrderCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: cubit,
      builder: (context, state) {
        return DataTable2(
          dividerThickness: 0,
          dataRowHeight: 42,
          columnSpacing: 8,
          columns: [
            DataColumn2(label: Text('Название')),
            DataColumn2(label: Text('Цена'), numeric: true, fixedWidth: 100),
            DataColumn2(label: Text('Кол-во'), numeric: true, fixedWidth: 100),
            DataColumn2(label: SizedBox(), fixedWidth: 24),
          ],
          rows:
              state.currentOrder?.items.map((i) {
                return DataRow2(
                  cells: [
                    DataCell(
                      FTooltip(
                        tipBuilder: (context, controller) => Text(
                          i.product.name,
                          style: TextStyle(color: theme.custom.foreground),
                        ),
                        child: Row(
                          spacing: 4,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                i.product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      FTextField(
                        textAlign: TextAlign.right,
                        control: FTextFieldControl.lifted(
                          value: TextEditingValue(
                            text: i.price.toStringAsFixed(2),
                          ),
                          onChange: (value) {},
                        ),
                        inputFormatters: [
                          CurrencyInputFormatter(
                            thousandSeparator: ThousandSeparator.Space,
                            mantissaLength: 2,
                          ),
                        ],
                      ),
                    ),
                    DataCell(_TableQuantity(i)),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          cubit.deleteItem(i);
                        },
                        child: Container(
                          padding: const EdgeInsetsGeometry.all(4),
                          decoration: BoxDecoration(
                            color: theme.custom.muted,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(Icons.close, size: 16),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList() ??
              [],
        );
      },
    );
  }
}

class _TableQuantity extends StatefulWidget {
  const _TableQuantity(this.item);

  final OrderItem item;

  @override
  State<_TableQuantity> createState() => _TableQuantityState();
}

class _TableQuantityState extends State<_TableQuantity> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.item.quantity.toStringAsFixed(2),
    );
  }

  @override
  void didUpdateWidget(covariant _TableQuantity oldWidget) {
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
    final cubit = BlocProvider.of<OrderCubit>(context);
    return FTextField(
      textAlign: TextAlign.right,
      control: FTextFieldControl.managed(
        controller: _controller,
        onChange: (value) {
          final value_ = double.tryParse(value.text);
          if (value_ != null) {
            cubit.updateItem(widget.item.copyWith(quantity: value_));
          }
        },
      ),
      inputFormatters: [
        CurrencyInputFormatter(
          thousandSeparator: ThousandSeparator.Space,
          mantissaLength: 2,
        ),
      ],
    );
  }
}

class _OrderBasketSubmitButton extends StatelessWidget {
  const _OrderBasketSubmitButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: BlocProvider.of<OrderCubit>(context),
      builder: (context, state) {
        return Column(
          spacing: 12,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Сумма',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: theme.custom.mutedForeground,
                  ),
                ),
                Text(
                  state.currentOrder?.totalSum.toStringAsFixed(0) ?? '0',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: theme.custom.foreground,
                  ),
                ),
              ],
            ),
            FButton(
              onPress: () {},
              style: (style) => style.copyWith(
                decoration: FWidgetStateMap.all(
                  BoxDecoration(
                    color: theme.custom.success,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              child: Text(
                'Принять оплату',
                style: TextStyle(color: theme.custom.successForeground),
              ),
            ),
          ],
        );
      },
    );
  }
}
