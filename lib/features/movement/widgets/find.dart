import 'package:app/features/movement/blocs/blocs.dart';
import 'package:app/features/movement/dialogs/dialogs.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class TransferFindDialog extends StatefulWidget {
  const TransferFindDialog({super.key});

  @override
  State<TransferFindDialog> createState() => _TransferFindDialogState();
}

class _TransferFindDialogState extends State<TransferFindDialog> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TransferCubit>(context);
    return Row(
      children: [
        BlocConsumer<TransferCubit, TransferState>(
          bloc: cubit,
          listener: (context, state) {
            if (state is TransferLoaded && state.transfer != null) {
              DetailTransferDialog(
                transfer: state.transfer!,
                rootContext: context,
              ).show();
            } else if (state is TransferFailure) {
              showFDialog(
                context: context,
                builder: (context, _, _) {
                  return FDialog(
                    title: Text('Не найден документ'),
                    body: Text('Документ с таким номером не найден в базе'),
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
                  hint: 'Введите номер документа',
                  control: FTextFieldControl.managed(controller: controller),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пустое поле';
                    }
                    return null;
                  },
                  suffixBuilder: (context, style, states) {
                    if (state is TransferLoading) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FCircularProgress(),
                      );
                    }
                    return FButton.icon(
                      onPress: () {
                        if (formKey.currentState?.validate() ?? false) {
                          cubit.getTransfer(controller.text);
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
