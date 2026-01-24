import 'package:app/features/statistic/widgets/widgets.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

@RoutePage()
class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FScaffold(
            header: StatisticHeader(),
            child: Column(
              spacing: 12,
              children: [
                StaticticFilter(),
                Expanded(child: RevenueChartPage()),
              ],
            ),
          ),
        ),
        SizedBox(width: 420, height: double.infinity, child: FCard()),
      ],
    );
  }
}
