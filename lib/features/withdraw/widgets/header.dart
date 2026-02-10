import 'package:app/blocs/blocs.dart';
import 'package:app/features/withdraw/dialogs/dialogs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class WithdrawHeader extends StatelessWidget {
  const WithdrawHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FHeader.nested(
      title: Text('Выемки'),
      titleAlignment: Alignment.centerLeft,
      prefixes: [Icon(FluentIcons.money_24_regular, size: 28)],
      suffixes: [
        BlocBuilder<WithdrawsCubit, WithdrawsState>(
          bloc: BlocProvider.of<WithdrawsCubit>(context),
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(right: 32),
              child: FLabel(
                label: Text('Деньги в кассе'),
                axis: Axis.vertical,
                child: Text(
                  NumberFormat.currency(
                    symbol: '',
                  ).format(state.cash?.value ?? ''),

                  style: TextStyle(
                    color: (state.cash?.value ?? 0) < 0
                        ? theme.custom.destructiveTextForeground
                        : theme.custom.foreground,
                  ),
                ),
              ),
            );
          },
        ),
        FButton.icon(
          onPress: () {
            CreateWithdrawDialog(context).show();
          },
          style: FButtonStyle.primary(),
          child: Icon(Icons.add),
        ),
        FButton.icon(
          onPress: () {
            BlocProvider.of<WithdrawsCubit>(context).update(updateCash: true);
          },
          child: Icon(FIcons.refreshCw),
        ),
      ],
    );
  }
}
