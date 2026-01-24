import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class StatisticHeader extends StatelessWidget {
  const StatisticHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.data_bar_vertical_24_regular, size: 28)],
      title: Text('Статистика'),
      titleAlignment: Alignment.centerLeft,
    );
  }
}
