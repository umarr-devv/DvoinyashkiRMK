import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class StaticticFilter extends StatelessWidget {
  const StaticticFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        SizedBox(
          width: 320,
          child: FDateField.calendar(
            label: const Text('Начало'),
            format: DateFormat('dd.MM.yyyy'),
            hint: 'Выберите дату',
          ),
        ),
        SizedBox(
          width: 320,
          child: FDateField.calendar(
            label: const Text('Конец'),
            format: DateFormat('dd.MM.yyyy'),
            hint: 'Выберите дату',
          ),
        ),
      ],
    );
  }
}
