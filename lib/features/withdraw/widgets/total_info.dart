import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class WithdrawInfo extends StatelessWidget {
  const WithdrawInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<WithdrawsCubit, WithdrawsState>(
      bloc: BlocProvider.of<WithdrawsCubit>(context),
      builder: (context, state) {
        final double withdrawSum = state.sessionWithdraws.fold(
          0,
          (a, b) => a + b.documentSum,
        );
        final double notAcceptedSum = state.notAcceptedWithdraws.fold(
          0,
          (a, b) => a + b.documentSum,
        );
        final totalCash = state.cash != null
            ? state.cash!.value - notAcceptedSum
            : 0;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Row(
            crossAxisAlignment: .end,
            spacing: 32,
            children: [
              FLabel(
                label: Text('Деньги в кассе', style: TextStyle(fontSize: 24)),
                axis: Axis.vertical,
                child: Text(
                  NumberFormat.currency(symbol: '').format(totalCash),
                  style: TextStyle(
                    fontSize: 36,
                    color: totalCash < 0
                        ? theme.custom.destructiveTextForeground
                        : theme.custom.success,
                  ),
                ),
              ),

              SizedBox(
                height: 48,
                child: VerticalDivider(color: theme.custom.border),
              ),
              FLabel(
                label: Text('Выемки за смену', style: TextStyle(fontSize: 24)),
                axis: Axis.vertical,
                child: Text(
                  NumberFormat.currency(symbol: '').format(withdrawSum),
                  style: TextStyle(
                    fontSize: 24,
                    color: withdrawSum < 0
                        ? theme.custom.destructiveTextForeground
                        : theme.custom.success,
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: VerticalDivider(color: theme.custom.border),
              ),
              FLabel(
                label: Text('В ожидании', style: TextStyle(fontSize: 24)),
                axis: Axis.vertical,
                child: Text(
                  NumberFormat.currency(symbol: '').format(notAcceptedSum),
                  style: TextStyle(
                    fontSize: 24,
                    color: notAcceptedSum < 0
                        ? theme.custom.destructiveTextForeground
                        : theme.custom.success,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
