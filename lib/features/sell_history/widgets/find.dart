import 'package:app/features/sell_history/blocs/find_check/find_check_cubit.dart';
import 'package:app/features/sell_history/dialogs/dialogs.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class SellHistoryFindCheck extends StatefulWidget {
  const SellHistoryFindCheck({super.key});

  @override
  State<SellHistoryFindCheck> createState() => _SellHistoryFindCheckState();
}

class _SellHistoryFindCheckState extends State<SellHistoryFindCheck> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FindCheckCubit>(context);
    return Row(
      children: [
        BlocConsumer<FindCheckCubit, FindCheckState>(
          bloc: cubit,
          listener: (context, state) {
            if (state is FindCheckLoaded && state.check != null) {
              DetailCheckDialog(
                rootContext: context,
                refKey: state.check!.refKey,
              ).show();
            } else if (state is FindCheckFailure) {
              showFDialog(
                context: context,
                builder: (context, _, _) {
                  return FDialog(
                    title: Text('Не найден чек'),
                    body: Text('Чек с таким номером не найден в базе'),
                    direction: Axis.horizontal,
                    actions: [
                      FButton(
                        onPress: () {
                          AutoRouter.of(context).maybePop();
                        },
                        style: FButtonStyle.outline(),
                        child: Text('Назад'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: SizedBox(
                width: 320,
                child: FTextFormField(
                  hint: 'Введите номер чека',
                  control: FTextFieldControl.managed(controller: controller),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пустое поле';
                    }
                    if (!value.startsWith('НФДВ')) {
                      return 'Номер чека начинается с НФДВ';
                    }
                    return null;
                  },
                  suffixBuilder: (context, style, states) {
                    if (state is FindCheckLoading) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FCircularProgress(),
                      );
                    }
                    return FButton.icon(
                      onPress: () {
                        if (formKey.currentState?.validate() ?? false) {
                          cubit.findByNumber(controller.text);
                        }
                      },
                      style: FButtonStyle.ghost(),
                      child: Icon(FIcons.search),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
