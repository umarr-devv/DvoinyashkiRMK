import 'package:app/shared/icons/icons.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:group_button/group_button.dart';

class PaymentTypeData {
  PaymentTypeData({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class PaymentDialog {
  PaymentDialog(this.rootContext);

  final BuildContext rootContext;

  final List<PaymentTypeData> paymentTypes = [
    PaymentTypeData(label: 'Наличные', icon: FluentIcons.money_24_regular),
    PaymentTypeData(label: 'Безналичные', icon: FluentIcons.payment_24_regular),
  ];

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog.raw(
          builder: (context, style) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 24,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(),
                  _paymentType(),
                  _paymentSum(),
                  _udsClient(),
                  _acceptButton(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  FHeader _title() {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.calculator_20_filled)],
      title: Text('Принять оплату'),
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

  Widget _paymentType() {
    final theme = Theme.of(rootContext);
    return FLabel(
      label: Text('Тип оплаты'),
      axis: Axis.vertical,
      child: GroupButton<PaymentTypeData>(
        isRadio: true,
        buttons: paymentTypes,
        buttonBuilder: (selected, value, context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
              color: selected ? theme.custom.info : theme.custom.muted,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              spacing: 6,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  value.icon,
                  color: selected
                      ? theme.custom.invertForeground
                      : theme.custom.foreground,
                ),
                Text(
                  value.label,
                  style: TextStyle(
                    fontSize: 16,
                    color: selected
                        ? theme.custom.invertForeground
                        : theme.custom.foreground,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _paymentSum() {
    return Column(
      spacing: 12,
      children: [
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: FCard(
                child: FLabel(
                  label: Text('Сумма'),
                  axis: Axis.vertical,
                  child: Text('2000', style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
            Expanded(
              child: FCard(
                child: FLabel(
                  label: Text('Сдача'),
                  axis: Axis.vertical,
                  child: Text('0', style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
          ],
        ),
        FTextFormField(
          label: Text('Сумма к оплате'),
          control: FTextFieldControl.managed(
            initial: TextEditingValue(text: '2000'),
            onChange: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _udsClient() {
    final theme = Theme.of(rootContext);
    return FTextField(
      label: Row(
        spacing: 6,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(64),
            child: Image.asset('assets/images/uds_icon.png', height: 20),
          ),
          Text('UDS'),
        ],
      ),
      prefixBuilder: (context, style, states) => Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: CustomIcons.qr(size: 20, color: theme.custom.mutedForeground),
      ),
      hint: 'Введите UDS-код клиента',
      description: Text(
        'Отсканируйте UDS-код у клиента или введите ее вручную',
      ),
    );
  }

  Widget _acceptButton() {
    final theme = Theme.of(rootContext);
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: FButton(
        onPress: () {},
        style: (style) => style.copyWith(
          decoration: FWidgetStateMap.all(
            BoxDecoration(
              color: theme.custom.success,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(
          'Принять оплату',
          style: TextStyle(color: theme.custom.invertForeground),
        ),
      ),
    );
  }
}
