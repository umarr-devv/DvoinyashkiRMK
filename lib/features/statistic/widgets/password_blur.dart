import 'dart:ui';
import 'package:app/blocs/blocs.dart';
import 'package:app/features/statistic/widgets/other.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class StatisticPasswordBlur extends StatelessWidget {
  const StatisticPasswordBlur({required this.isUnlocked, super.key});

  final ValueNotifier<bool> isUnlocked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<bool>(
      valueListenable: isUnlocked,
      builder: (context, unlocked, child) {
        if (unlocked) return const SizedBox.shrink();
        return Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
              child: Container(
                color: theme.custom.background.withValues(alpha: 0.5),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 320,
                        child: FCard(
                          title: const Text('Доступ закрыт'),
                          subtitle: const Text(
                            'Введите пароль для просмотра статистики',
                          ),
                          child: FTextField.password(
                            label: const Text('Пароль'),
                            hint: 'Введите пароль',
                            control: FTextFieldControl.managed(
                              onChange: (value) {
                                if (value.text == 'secret') {
                                  isUnlocked.value = true;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(alignment: .centerRight, child: GeneralInfo()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<StatisticCubit, StatisticState>(
      builder: (context, state) {
        return Container(
          height: double.infinity,
          padding: .symmetric(vertical: 32, horizontal: 24),
          width: 340,
          decoration: BoxDecoration(
            color: theme.custom.background,
            border: Border(left: BorderSide(color: theme.custom.barrier)),
          ),
          child: Column(
            spacing: 12,
            children: [
              FHeader.nested(title: Text('Доступная статистика')),
              StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(FluentIcons.person_24_regular),
                    Text('UDS-клиенты'),
                  ],
                ),
                child: Text(state.uniqueUdsClient.length.toStringAsFixed(0)),
              ),
              StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(FluentIcons.person_24_regular),
                    Text('UDS-баллы'),
                  ],
                ),
                child: Text(NumberFormat().format(state.totalUdsPoints)),
              ),
              StatisticTotalItem(
                label: Row(
                  spacing: 6,
                  children: [
                    Icon(Icons.percent_rounded),
                    Text('Привлеченность UDS'),
                  ],
                ),
                child: Text('${(state.udsPercent * 100).toStringAsFixed(2)}%'),
              ),
            ],
          ),
        );
      },
    );
  }
}
