import 'dart:ui';
import 'package:app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

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
            ),
          ),
        );
      },
    );
  }
}
