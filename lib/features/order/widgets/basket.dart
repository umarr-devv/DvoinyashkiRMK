import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/dialogs/dialogs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/widgets.dart';
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
            onPress: () {
              ClearBasketDialog(context).show();
            },
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
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: cubit,
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final item = state.currentOrder?.items[index];
            if (item != null) {
              return _ProductOrderCard(item);
            }
            return SizedBox();
          },
          separatorBuilder: (context, index) {
            return CustomDottedLine();
          },
          itemCount: state.currentOrder?.items.length ?? 0,
        );
      },
    );
  }
}

class _ProductOrderCard extends StatelessWidget {
  const _ProductOrderCard(this.item);

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          item.product.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: theme.custom.foreground,
          ),
        ),
      ),
      subtitle: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductOrderItemQuantity(item),
          if (item.specification != null)
            Row(
              spacing: 4,
              children: [
                Icon(FIcons.coffee, size: 14, color: theme.custom.accent),
                Text('Сборка', style: TextStyle(color: theme.custom.accent)),
              ],
            ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Цена: ${item.price.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: theme.custom.foreground,
            ),
          ),
          Text(
            'Сумма: ${item.totalSum.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: theme.custom.foreground,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductOrderItemQuantity extends StatefulWidget {
  const _ProductOrderItemQuantity(this.item);

  final OrderItem item;

  @override
  State<_ProductOrderItemQuantity> createState() =>
      _ProductOrderItemQuantityState();
}

class _ProductOrderItemQuantityState extends State<_ProductOrderItemQuantity> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.item.quantity.toStringAsFixed(2),
    );
  }

  @override
  void didUpdateWidget(covariant _ProductOrderItemQuantity oldWidget) {
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
    return Row(
      spacing: 8,
      children: [
        FButton.icon(
          onPress: () {
            cubit.updateItem(
              widget.item.copyWith(quantity: widget.item.quantity - 1),
            );
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
          ),
        ),
        FButton.icon(
          onPress: () {
            cubit.updateItem(
              widget.item.copyWith(quantity: widget.item.quantity + 1),
            );
          },
          style: FButtonStyle.primary(),
          child: Icon(Icons.add),
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
        final bool notEmptyOrder =
            state.currentOrder?.items.isNotEmpty ?? false;
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
              onPress: () {
                if (notEmptyOrder) {
                  PaymentDialog(context).show();
                }
              },
              style: (style) => style.copyWith(
                decoration: FWidgetStateMap.all(
                  BoxDecoration(
                    color: notEmptyOrder
                        ? theme.custom.success
                        : theme.custom.success.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              child: Text(
                'Принять оплату',
                style: TextStyle(color: theme.custom.actionForeground),
              ),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  flex: 4,
                  child: FButton(
                    onPress: () {
                      SaveOrderDialog(context).show();
                    },
                    style: FButtonStyle.outline(),
                    child: Text('Отложить'),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: FButton(
                    onPress: () {
                      SaveOrderListDialog(context).show();
                    },
                    style: FButtonStyle.secondary(),
                    child: Text('Отложенные чеки'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
