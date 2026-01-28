import 'dart:math';

import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/blocs/uds_customer/uds_customer_cubit.dart';
import 'package:app/shared/icons/icons.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

class PaymentTypeData {
  PaymentTypeData({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class PaymentDialog {
  PaymentDialog(this.rootContext);

  final BuildContext rootContext;

  final udsCubit = UdsCustomerCubit();

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
                  _UDSCustomerSelect(udsCubit),
                  _UdsCustomerPoints(udsCubit),
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

class _UDSCustomerSelect extends StatefulWidget {
  const _UDSCustomerSelect(this.udsCubit);

  final UdsCustomerCubit udsCubit;

  @override
  State<_UDSCustomerSelect> createState() => _UDSCustomerSelectState();
}

class _UDSCustomerSelectState extends State<_UDSCustomerSelect> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<UdsCustomerCubit, UdsCustomerState>(
      bloc: widget.udsCubit,
      builder: (context, state) {
        return FTextField(
          label: Text('UDS код'),
          hint: 'Введите UDS-код',
          description: Text('Отсканируйте QR-код или же введите ее ручную'),
          error: state is UdsCustomerFailure
              ? Text('Клиент с таким кодом не найден')
              : null,
          prefixBuilder: (context, style, states) {
            return Padding(
              padding: const EdgeInsets.only(left: 8, right: 4),
              child: Builder(
                builder: (context) {
                  if (state is UdsCustomerLoading) {
                    return FCircularProgress();
                  } else if (state is UdsCustomerLoaded) {
                    if (state.customer!.user.avatar?.isNotEmpty ?? false) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(64),
                        child: Image.network(
                          state.customer!.user.avatar!,
                          height: 24,
                          width: 24,
                        ),
                      );
                    } else {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(64),
                        child: Image.asset(
                          'assets/images/uds_icon.png',
                          height: 24,
                          width: 24,
                        ),
                      );
                    }
                  } else {
                    return CustomIcons.qr(
                      color: theme.custom.mutedForeground,
                      size: 20,
                    );
                  }
                },
              ),
            );
          },
          suffixBuilder: (context, style, states) {
            if (state is UdsCustomerLoaded) {
              return FButton.icon(
                onPress: () {
                  widget.udsCubit.clear();
                  controller.clear();
                },
                style: FButtonStyle.ghost(),
                child: Icon(Icons.close),
              );
            } else {
              return SizedBox();
            }
          },
          control: state is UdsCustomerLoaded
              ? FTextFieldControl.lifted(
                  value: TextEditingValue(
                    text: state.customer!.user.displayName,
                  ),
                  onChange: (value) {},
                )
              : FTextFieldControl.managed(
                  controller: controller,
                  onChange: (value) {
                    if (state is! UdsCustomerLoading &&
                        value.text.length == 6) {
                      widget.udsCubit.findCustomer(value.text);
                    }
                  },
                ),
          maxLength: 6,
        );
      },
    );
  }
}

class _UdsCustomerPoints extends StatefulWidget {
  const _UdsCustomerPoints(this.udsCubit);

  final UdsCustomerCubit udsCubit;

  @override
  State<_UdsCustomerPoints> createState() => _UdsCustomerPointsState();
}

class _UdsCustomerPointsState extends State<_UdsCustomerPoints> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: BlocProvider.of<OrderCubit>(context),
      builder: (context, orderState) {
        return BlocBuilder<UdsCustomerCubit, UdsCustomerState>(
          bloc: widget.udsCubit,
          builder: (context, udsState) {
            if (udsState is UdsCustomerLoaded) {
              final user = udsState.customer!.user;
              final maxUsePoints = min(
                (orderState.currentOrder?.totalSum ?? 0) *
                    user.participant.membershipTier.maxScoresDiscount /
                    100,
                user.participant.points,
              );
              final customerGet =
                  (orderState.currentOrder?.totalSum ?? 0) *
                  user.participant.membershipTier.rate /
                  100;
              return Column(
                spacing: 24,
                children: [
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: FCard(
                          child: FLabel(
                            label: Text('Кол-во баллов'),
                            axis: Axis.vertical,
                            child: Text(
                              NumberFormat.currency(
                                symbol: '',
                              ).format(user.participant.points),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FCard(
                          child: FLabel(
                            label: Text('Можно потратить'),
                            axis: Axis.vertical,
                            child: Text(
                              NumberFormat.currency(
                                symbol: '',
                              ).format(maxUsePoints),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FCard(
                          child: FLabel(
                            label: Text('Клиент получит'),
                            axis: Axis.vertical,
                            child: Text(
                              NumberFormat.currency(
                                symbol: '',
                              ).format(customerGet),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FTextField(
                    label: Text('Использовать баллы'),
                    control: FTextFieldControl.managed(controller: controller),
                  ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        );
      },
    );
  }
}
