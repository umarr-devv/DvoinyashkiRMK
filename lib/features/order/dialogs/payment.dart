import 'dart:math';

import 'package:app/blocs/blocs.dart';
import 'package:app/features/order/blocs/create_check/create_check_cubit.dart';
import 'package:app/features/order/blocs/uds_customer/uds_customer_cubit.dart';
import 'package:app/models/models.dart';
import 'package:app/service/print.dart';
import 'package:app/service/print_schemes/check.dart';
import 'package:app/service/print_schemes/print_schemes.dart';
import 'package:app/service/toast.dart';
import 'package:app/shared/icons/icons.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:forui/forui.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog(this.rootContext, {super.key});

  final BuildContext rootContext;

  void show() {
    showFDialog(
      context: rootContext,
      barrierDismissible: false,
      builder: (context, style, animation) {
        return this;
      },
    );
  }

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final formKey = GlobalKey<FormState>();

  SettingsCubit get settingsCubit => BlocProvider.of<SettingsCubit>(context);
  AuthCubit get authCubit => BlocProvider.of<AuthCubit>(context);
  SessionCubit get sessionCubit => BlocProvider.of<SessionCubit>(context);
  OrderCubit get orderCubit => BlocProvider.of<OrderCubit>(context);

  final udsCustomerCubit = UdsCustomerCubit();

  late final CreateCheckCubit createCheckCubit;

  void initCubits() {
    createCheckCubit = CreateCheckCubit(
      settingsCubit,
      authCubit,
      sessionCubit,
      orderCubit,
      udsCustomerCubit,
    );
    createCheckCubit.init();
  }

  @override
  void initState() {
    initCubits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataCubit = BlocProvider.of<DataCubit>(widget.rootContext);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: createCheckCubit),
        BlocProvider.value(value: udsCustomerCubit),
      ],
      child: BlocListener<CreateCheckCubit, CreateCheckState>(
        bloc: createCheckCubit,
        listener: (context, state) {
          if (state is CreateCheckFailure) {
            final hasUdsOrDebt =
                createCheckCubit.udsCustomer != null ||
                createCheckCubit.udsCode != null ||
                createCheckCubit.state.debtUser != null;
            _NetworkErrorDialog(
              context,
              createCheckCubit: createCheckCubit,
              offlineChecksCubit: BlocProvider.of<OfflineChecksCubit>(
                widget.rootContext,
              ),
              canGoOffline: !hasUdsOrDebt,
            ).show();
          } else if (state is CreateCheckOfflineSaved) {
            ToastService.showToast(
              widget.rootContext,
              notification: NotificationData(
                type: NotificationType.info,
                icon: FluentIcons.cloud_off_24_regular,
                title: 'Чек сохранён оффлайн',
                description:
                    'Чек будет отправлен в 1C при восстановлении соединения',
              ),
            );
            udsCustomerCubit.clear();
            AutoRouter.of(context).maybePop();
          } else if (state is CreateCheckUdsOfflineNotSupported) {
            ErrorDialog(
              context,
              label: 'UDS недоступен оффлайн',
              description:
                  'Чеки с UDS-клиентом нельзя сохранить оффлайн. Попробуйте позже.',
            ).show();
          } else if (state is CreateCheckDebtOfflineNotSupported) {
            ErrorDialog(
              context,
              label: 'Долг недоступен оффлайн',
              description:
                  'Чеки с долговым клиентом нельзя сохранить оффлайн. Попробуйте позже.',
            ).show();
          } else if (state is CreateCheckUdsFailure) {
            ErrorDialog(
              context,
              label: 'Ошибка UDS',
              description: 'Переотсканируйте QR-код клиента в приложении UDS',
            ).show();
            udsCustomerCubit.clear();
            createCheckCubit.init();
            createCheckCubit.setUdsPoints(0);
          } else if (state is CreateCheckSettingsFailure) {
            ErrorDialog(
              context,
              label: 'Ошибка настроек',
              description: 'Укажите настройки магазина в разделе "Настройки"',
            ).show();
          } else if (state is CreateCheckSessionFailure) {
            ErrorDialog(
              context,
              label: 'Ошибка смены',
              description: 'Необходимо начать смену',
            ).show();
          } else if (state is CreateCheckLoaded && state.check != null) {
            ToastService.showToast(
              widget.rootContext,
              notification: NotificationData(
                type: NotificationType.success,
                icon: FluentIcons.receipt_24_regular,
                title: 'Чек ${state.check?.number} пробит',
                description:
                    'Чек ${state.check?.number} на сумму ${state.check?.documentSum} успешно пробит',
              ),
            );
            printGroupProductsByPrinter(state.check!);
            udsCustomerCubit.clear();
            BlocProvider.of<OrderCubit>(widget.rootContext).clearItems();
            BlocProvider.of<ChecksCubit>(widget.rootContext).update();
            PrintService(
              printerUrl: BlocProvider.of<SettingsCubit>(context).state.printer,
            ).print(
              PrintCheckScheme(
                check: state.check!,
                dataState: BlocProvider.of<DataCubit>(context).state,
              ),
              context,
            );
            AutoRouter.of(context).maybePop();
          }
        },
        child: FDialog.raw(
          builder: (context, style) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: createCheckCubit),
                BlocProvider.value(value: udsCustomerCubit),
                BlocProvider.value(value: dataCubit),
              ],
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    spacing: 24,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [PaymentScanner(), _DialogHeader()]),
                      _DialogGeneralInfo(),
                      _PaymentTypeSelect(),
                      _PaymentSum(),
                      _CustomerSelect(),
                      _UdsCustomerPoints(),
                      _DialogAccept(formKey),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void printGroupProductsByPrinter(DetailCheckScheme check) {
    final Map<String, List<OrderItem>> grouped = {};
    final printerGroups = settingsCubit.state.printerGroups;
    final items = orderCubit.state.currentOrder?.items ?? [];

    for (final item in items) {
      final groupKey = item.product.nomenclature.groupKey;
      if (groupKey != null && printerGroups.containsKey(groupKey)) {
        final printer = printerGroups[groupKey]!;
        final printerName = printer.name;

        if (!grouped.containsKey(printerName)) {
          grouped[printerName] = [];
        }
        grouped[printerName]!.add(item);
      }
    }

    for (final printer in grouped.keys) {
      final value = grouped[printer];
      if (value?.isNotEmpty ?? false) {
        PrintService(printerUrl: printer).print(
          PrintOrderCheckScheme(
            products: value!,
            check: check,
            dataState: context.read<DataCubit>().state,
          ),
          context,
        );
      }
    }
  }
}

class PaymentScanner extends StatefulWidget {
  const PaymentScanner({super.key});

  @override
  State<PaymentScanner> createState() => _PaymentScannerState();
}

class _PaymentScannerState extends State<PaymentScanner> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateCheckCubit>(context);
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, dataState) {
        return BlocBuilder<CreateCheckCubit, CreateCheckState>(
          bloc: cubit,
          builder: (context, state) {
            return BarcodeKeyboardListener(
              onBarcodeScanned: (value) async {
                focusNode.requestFocus();
                if (value.length < 2) {
                  return;
                }
                if (cubit.state.paymentType == cashPaymentType ||
                    cubit.state.paymentType == cashlessPaymentType) {
                  BlocProvider.of<UdsCustomerCubit>(
                    context,
                  ).findCustomer(value);
                } else if (cubit.state.paymentType == debtPaymentType) {
                  final user = dataState.users.firstWhereLogTypeOrNull(
                    (i) => i.barcode == value,
                  );
                  if (user != null) {
                    cubit.setDebtUser(user);
                  }
                }
              },
              child: SizedBox(),
            );
          },
        );
      },
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader();

  @override
  Widget build(BuildContext context) {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.calculator_24_regular)],
      title: Text('Пробить чек'),
      titleAlignment: Alignment.centerLeft,
      suffixes: [
        FButton.icon(
          onPress: () {
            AutoRouter.of(context).maybePop();
          },
          child: Icon(Icons.close),
        ),
      ],
    );
  }
}

class _DialogGeneralInfo extends StatelessWidget {
  const _DialogGeneralInfo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CreateCheckCubit, CreateCheckState>(
      bloc: BlocProvider.of<CreateCheckCubit>(context),
      builder: (context, state) {
        return Row(
          spacing: 12,
          children: [
            Expanded(
              child: FCard(
                child: FLabel(
                  label: Text('Сумма к оплате'),
                  axis: Axis.vertical,
                  child: Text(
                    NumberFormat.currency(
                      symbol: '',
                    ).format(state.totalSumToPay),
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ),
            if (state.paymentType == cashPaymentType)
              Expanded(
                child: FCard(
                  child: FLabel(
                    label: Text('Сдача'),
                    axis: Axis.vertical,
                    child: Text(
                      NumberFormat.currency(symbol: '').format(state.change),
                      style: TextStyle(
                        fontSize: 22,
                        color: state.change < 0
                            ? theme.custom.destructiveTextForeground
                            : theme.custom.foreground,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _DialogAccept extends StatelessWidget {
  const _DialogAccept(this.formKey);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateCheckCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<CreateCheckCubit, CreateCheckState>(
      bloc: cubit,
      builder: (context, state) {
        return FButton(
          onPress: () {
            if (formKey.currentState?.validate() ?? false) {
              cubit.create();
            }
          },
          prefix: state is CreateCheckLoading ? FCircularProgress() : null,
          style: (style) => style.copyWith(
            decoration: FWidgetStateMap.all(
              BoxDecoration(
                color: theme.custom.success,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          child: Text('Пробить'),
        );
      },
    );
  }
}

class _PaymentTypeSelect extends StatefulWidget {
  const _PaymentTypeSelect();

  @override
  State<_PaymentTypeSelect> createState() => _PaymentTypeSelectState();
}

class _PaymentTypeSelectState extends State<_PaymentTypeSelect> {
  late final GroupButtonController controller;

  @override
  void initState() {
    final paymentType = BlocProvider.of<CreateCheckCubit>(
      context,
    ).state.paymentType;
    controller = GroupButtonController(
      selectedIndex: paymentTypesList.indexOf(paymentType),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GroupButton<PaymentTypeData>(
      buttons: paymentTypesList,
      controller: controller,
      onSelected: (value, index, isSelected) {
        BlocProvider.of<CreateCheckCubit>(
          context,
        ).setPaymentType(paymentTypesList[index]);
      },
      buttonBuilder: (selected, value, context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          decoration: BoxDecoration(
            color: selected ? theme.custom.info : theme.custom.muted,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                value.icon,
                size: 20,
                color: selected
                    ? theme.custom.invertForeground
                    : theme.custom.foreground,
              ),
              Text(
                value.label,
                style: TextStyle(
                  color: selected
                      ? theme.custom.invertForeground
                      : theme.custom.foreground,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PaymentSum extends StatefulWidget {
  const _PaymentSum();

  @override
  State<_PaymentSum> createState() => _PaymentSumState();
}

class _PaymentSumState extends State<_PaymentSum> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = BlocProvider.of<CreateCheckCubit>(
      context,
    ).state.customerPay.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateCheckCubit>(context);
    return BlocBuilder<CreateCheckCubit, CreateCheckState>(
      bloc: BlocProvider.of(context),
      builder: (context, state) {
        if (state.paymentType != cashPaymentType) {
          return SizedBox();
        }
        return FTextFormField(
          label: Text('Получено от клиента'),
          inputFormatters: [
            CurrencyInputFormatter(thousandSeparator: ThousandSeparator.None),
          ],
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if (state.change < 0) {
              return 'Недостаточно средств для оплаты';
            }
            return null;
          },
          control: FTextFieldControl.managed(
            controller: controller,
            onChange: (value) {
              if (double.tryParse(value.text) != null) {
                cubit.setCustomerPay(double.tryParse(value.text)!);
              }
            },
          ),
          suffixBuilder: (context, style, states) => FButton.icon(
            onPress: () {
              controller.text = state.totalSumToPay.toStringAsFixed(2);
              cubit.setCustomerPay(state.totalSumToPay);
            },
            style: FButtonStyle.ghost(),
            child: Icon(Icons.sync),
          ),
        );
      },
    );
  }
}

class _CustomerSelect extends StatelessWidget {
  const _CustomerSelect();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCheckCubit, CreateCheckState>(
      bloc: BlocProvider.of<CreateCheckCubit>(context),
      buildWhen: (previous, current) {
        return previous.paymentType != current.paymentType;
      },
      builder: (context, state) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          bloc: BlocProvider.of<SettingsCubit>(context),
          builder: (context, settingsState) {
            if (state.paymentType == debtPaymentType) {
              return _DebtCustomerSelect();
            }
            return _UdsCustomerSelect();
          },
        );
      },
    );
  }
}

class _DebtCustomerSelect extends StatefulWidget {
  const _DebtCustomerSelect();

  @override
  State<_DebtCustomerSelect> createState() => _DebtCustomerSelectState();
}

class _DebtCustomerSelectState extends State<_DebtCustomerSelect> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateCheckCubit>(context);
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, dataState) {
        return BlocBuilder<CreateCheckCubit, CreateCheckState>(
          bloc: cubit,
          builder: (context, state) {
            return FSelect<UserScheme>.searchBuilder(
              label: Text('Сотрудник'),
              hint: 'Выберите сотрудника, чтобы оформить долг',
              autovalidateMode: AutovalidateMode.always,
              control: FSelectControl.lifted(
                value: state.debtUser,
                onChange: (value) {
                  if (value != null) {
                    cubit.setDebtUser(value);
                  }
                },
              ),
              validator: (value) {
                if (value == null) {
                  return 'Необходимо выбрать сотрудника для оформления долга';
                }
                return null;
              },
              contentEmptyBuilder: (context, style) => Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text('Ничего не найдено'),
              ),
              searchFieldProperties: FSelectSearchFieldProperties(
                hint: 'Введите код сотрудника',
              ),
              format: (i) => i.description,
              filter: (query) {
                return dataState.users.where((user) => user.barcode == query);
              },
              contentBuilder: (context, query, values) {
                if (query.isEmpty) {
                  return [];
                }
                return dataState.users
                    .where((user) => user.barcode == query)
                    .map((user) {
                      return FSelectItem(
                        title: Text(user.description),
                        value: user,
                      );
                    })
                    .toList();
              },
            );
          },
        );
      },
    );
  }
}

class _UdsCustomerSelect extends StatefulWidget {
  const _UdsCustomerSelect();

  @override
  State<_UdsCustomerSelect> createState() => _UdsCustomerSelectState();
}

class _UdsCustomerSelectState extends State<_UdsCustomerSelect> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<UdsCustomerCubit>(context);
    return BlocBuilder<UdsCustomerCubit, UdsCustomerState>(
      bloc: cubit,
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
                  BlocProvider.of<CreateCheckCubit>(context).setCustomerPay(0);
                  cubit.clear();
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
                      cubit.findCustomer(value.text);
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
  const _UdsCustomerPoints();

  @override
  State<_UdsCustomerPoints> createState() => _UdsCustomerPointsState();
}

class _UdsCustomerPointsState extends State<_UdsCustomerPoints> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UdsCustomerCubit>(context);
    return BlocBuilder<CreateCheckCubit, CreateCheckState>(
      bloc: BlocProvider.of<CreateCheckCubit>(context),
      builder: (context, checkState) {
        if (checkState.paymentType == debtPaymentType) {
          return SizedBox();
        }
        return BlocBuilder<UdsCustomerCubit, UdsCustomerState>(
          bloc: cubit,
          builder: (context, udsState) {
            if (udsState is UdsCustomerLoaded) {
              final user = udsState.customer!.user;
              final maxUsePoints = min(
                checkState.totalSum *
                    user.participant.membershipTier.maxScoresDiscount /
                    100,
                user.participant.points,
              );
              final customerGet =
                  checkState.totalSumToPay *
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
                  FTextFormField(
                    label: Text('Использовать баллы'),
                    inputFormatters: [CurrencyInputFormatter()],
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value != null) {
                        final value_ = double.tryParse(value);
                        if (value_ != null) {
                          if (value_ > maxUsePoints) {
                            return 'Клиент не сможет потратить столько баллов';
                          }
                        }
                      }
                      return null;
                    },
                    control: FTextFieldControl.managed(
                      initial: TextEditingValue(text: '0.00'),
                      onChange: (value) {
                        if (double.tryParse(value.text) != null) {
                          BlocProvider.of<CreateCheckCubit>(
                            context,
                          ).setUdsPoints(double.tryParse(value.text)!);
                        }
                      },
                    ),
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

class _NetworkErrorDialog {
  _NetworkErrorDialog(
    this.rootContext, {
    required this.createCheckCubit,
    required this.offlineChecksCubit,
    required this.canGoOffline,
  });

  final BuildContext rootContext;
  final CreateCheckCubit createCheckCubit;
  final OfflineChecksCubit offlineChecksCubit;
  final bool canGoOffline;

  void show() {
    final theme = Theme.of(rootContext);
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog(
          title: Row(
            spacing: 6,
            children: [
              Icon(
                FluentIcons.wifi_off_24_regular,
                color: theme.custom.destructiveTextForeground,
                size: 20,
              ),
              Text(
                'Сетевая ошибка',
                style: TextStyle(color: theme.custom.destructiveTextForeground),
              ),
            ],
          ),
          body: Text(
            'Произошла сетевая ошибка, 1C сервер не отвечает.\n'
            '${canGoOffline ? 'Вы можете сохранить чек оффлайн и отправить позже.' : 'Чек с UDS-клиентом или долгом нельзя сохранить оффлайн.'}',
          ),
          direction: Axis.horizontal,
          actions: [
            FButton(
              onPress: () => AutoRouter.of(context).maybePop(),
              style: FButtonStyle.outline(),
              child: Text('Назад'),
            ),
            if (canGoOffline)
              FButton(
                onPress: () {
                  AutoRouter.of(context).maybePop();
                  createCheckCubit.saveOffline(offlineChecksCubit);
                },
                style: (style) => style.copyWith(
                  decoration: FWidgetStateMap.all(
                    BoxDecoration(
                      color: theme.custom.info,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                child: Row(
                  spacing: 6,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FluentIcons.cloud_off_24_regular,
                      size: 16,
                      color: theme.custom.invertForeground,
                    ),
                    Text(
                      'Пробить оффлайн',
                      style: TextStyle(color: theme.custom.invertForeground),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
