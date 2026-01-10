import 'package:app/features/order/dialogs/dialogs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class OrderBasket extends StatelessWidget {
  const OrderBasket({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: double.infinity,
      width: 400,
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
    return DataTable2(
      dividerThickness: 0,
      dataRowHeight: 42,
      columns: [
        DataColumn2(label: Text('Название')),
        DataColumn2(label: Text('Цена'), numeric: true),
        DataColumn2(label: Text('Кол-во'), numeric: true),
      ],
      rows: List.generate(4, (index) {
        return DataRow2(
          onTap: () {},
          cells: [
            DataCell(Text('Торт')),
            DataCell(Text('720')),
            DataCell(Text('4')),
          ],
        );
      }),
    );
  }
}

class _OrderBasketSubmitButton extends StatelessWidget {
  const _OrderBasketSubmitButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              '2880',
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
            OrderPaymentDialog(context).show();
          },
          style: (style) => style.copyWith(
            decoration: FWidgetStateMap.all(
              BoxDecoration(
                color: theme.custom.success,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          child: Text('Подтвердить'),
        ),
      ],
    );
  }
}
