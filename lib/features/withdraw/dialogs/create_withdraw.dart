import 'package:app/blocs/blocs.dart';
import 'package:app/features/withdraw/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

enum WithdrawCheckGroup { none, store, bar }

class CreateWithdrawDialog {
  CreateWithdrawDialog(this.rootContext);

  final BuildContext rootContext;

  final formKey = GlobalKey<FormState>();

  final documentSumController = TextEditingController(text: '0');

  final commentController = TextEditingController();

  final withdrawType = ValueNotifier<WithdrawCheckGroup>(.none);

  CreateWithdrawCubit initCubit() {
    final settingsCubit = BlocProvider.of<SettingsCubit>(rootContext);
    final sessionCubit = BlocProvider.of<SessionCubit>(rootContext);
    final cubit = CreateWithdrawCubit(settingsCubit, sessionCubit);
    return cubit;
  }

  void show() {
    final cubit = initCubit();
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog.raw(
          builder: (context, style) {
            return Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [title(), body(), submit(cubit)],
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
      prefixes: [Icon(FluentIcons.money_24_regular, size: 28)],
      title: Text('Создание выемки'),
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

  Widget body() {
    final theme = rootContext.theme;
    return Column(
      spacing: 24,
      children: [
        BlocBuilder<SessionCubit, SessionState>(
          bloc: BlocProvider.of<SessionCubit>(rootContext),
          builder: (context, state) {
            return FSelect<WorkShiftScheme>(
              label: Text('Смена'),
              hint: 'Выберите смену',
              suffixBuilder: (context, style, states) => SizedBox(),
              contentEmptyBuilder: (context, style) => Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Text('Нет активных смен'),
              ),
              items: {
                for (var element
                    in state.currentWorkShift != null
                        ? [state.currentWorkShift]
                        : [])
                  element!.number: element,
              },
              control: FSelectControl.lifted(
                value: state.currentWorkShift,
                onChange: (value) {},
              ),
              validator: (value) {
                if (value == null) {
                  return 'Необходимо выбрать смену';
                }
                return null;
              },
            );
          },
        ),
        BlocBuilder<WithdrawsCubit, WithdrawsState>(
          builder: (context, state) {
            return FTextFormField(
              label: Text('Сумма выемки'),
              control: FTextFieldControl.managed(
                controller: documentSumController,
              ),
              validator: (value) {
                // final cubit = context.read<WithdrawsCubit>();
                if (value == null || value.isEmpty) {
                  return 'Это поле не должен быть пустым';
                }

                final cleanValue = value
                    .replaceAll(RegExp(r'\s+\b|\b\s+'), '')
                    .replaceAll(' ', '');
                final doubleValue = double.tryParse(cleanValue);

                if (doubleValue == null) {
                  return 'Некорректное значение';
                } else if (doubleValue == 0) {
                  return 'Значение не должен быть равен 0';
                } else {
                  return null;
                }
              },
            );
          },
        ),

        ValueListenableBuilder(
          valueListenable: withdrawType,
          builder: (context, value, child) {
            return FormField<WithdrawCheckGroup>(
              initialValue: withdrawType.value,
              validator: (value) {
                if (value == .none) {
                  return 'Выберите один из вариантов';
                }
                return null;
              },
              builder: (field) {
                return Column(
                  crossAxisAlignment: .start,
                  spacing: 12,
                  children: [
                    FCheckbox(
                      label: Text('Магазин'),
                      value: value == .store,
                      onChange: (newValue) {
                        if (newValue) {
                          withdrawType.value = .store;
                          field.didChange(.store); //
                        }
                      },
                    ),
                    FCheckbox(
                      label: Text('Бар'),
                      value: value == .bar,
                      onChange: (newValue) {
                        if (newValue) {
                          withdrawType.value = .bar;
                          field.didChange(.bar); //
                        }
                      },
                    ),
                    if (field.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          field.errorText!,
                          style: TextStyle(
                            color: theme.colors.destructive,
                            fontSize: 15,
                            fontWeight: .w600,
                          ),
                        ),
                      ),
                    if (withdrawType.value == .store)
                      Text(
                        'Касса: ${context.read<SettingsCubit>().state.cashRegister?.description}',
                      ),
                    if (withdrawType.value == .bar)
                      Text(
                        'Касса: ${context.read<SettingsCubit>().state.cafeCashRegister?.description ?? context.read<SettingsCubit>().state.cashRegister?.description}',
                      ),
                  ],
                );
              },
            );
          },
        ),

        FTextFormField(
          label: Text('Комментарии'),
          description: Text('Не объязателен'),
          control: FTextFieldControl.managed(controller: commentController),
        ),
      ],
    );
  }

  Widget submit(CreateWithdrawCubit cubit) {
    return BlocConsumer<CreateWithdrawCubit, CreateWithdrawState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is CreateWithdrawLoaded) {
          BlocProvider.of<WithdrawsCubit>(rootContext).update();
          AutoRouter.of(rootContext).maybePop();
        }
      },
      builder: (context, state) {
        return FButton(
          prefix: state is CreateWithdrawLoading ? FCircularProgress() : null,
          onPress: () {
            if (formKey.currentState?.validate() ?? false) {
              AcceptCreateWithdrawDialog(rootContext, () {
                final documentSum = double.tryParse(documentSumController.text);
                if (documentSum != null) {
                  cubit.create(
                    documentSum,
                    commentController.text,
                    withdrawType.value == .bar,
                  );
                }
              }).show();
            }
          },
          child: Text('Создать выемку'),
        );
      },
    );
  }
}

class AcceptCreateWithdrawDialog {
  final BuildContext rootContext;
  final Function action;

  AcceptCreateWithdrawDialog(this.rootContext, this.action);

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog(
          title: Text('Подтвреждение'),
          body: Text('Подтвердите создания выемки на сумму'),
          direction: Axis.horizontal,
          actions: [
            FButton(
              onPress: () {
                AutoRouter.of(context).maybePop();
              },
              style: FButtonStyle.outline(),
              child: Text('Отмена'),
            ),
            FButton(
              onPress: () {
                action();
                AutoRouter.of(context).maybePop();
              },
              child: Text('Создать'),
            ),
          ],
        );
      },
    );
  }
}
