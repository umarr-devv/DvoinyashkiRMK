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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Row(
            spacing: 32,
            children: [
              FLabel(
                label: Text('Деньги в кассе', style: TextStyle(fontSize: 24)),
                axis: Axis.vertical,
                child: Text(
                  NumberFormat.currency(
                    symbol: '',
                  ).format(state.cash?.value ?? 0),
                  style: TextStyle(
                    fontSize: 36,
                    color: (state.cash?.value ?? 0) < 0
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
                    fontSize: 36,
                    color: withdrawSum < 0
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
