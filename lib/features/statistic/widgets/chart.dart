import 'dart:math';

import 'package:app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RevenueChartPage extends StatelessWidget {
  final random = Random();

  double nextIntInRange(int min, int max) {
    return min + random.nextInt(max - min + 1).toDouble();
  }

  List<RevenueData> get chartData => [
    RevenueData(DateTime(2025, 1, 1), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 2), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 3), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 4), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 5), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 6), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 7), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 8), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 9), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 10), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 11), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 12), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 13), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 14), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 15), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 16), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 17), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 18), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 19), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 20), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 21), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 22), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 23), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 24), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 25), nextIntInRange(2000, 10000)),
    RevenueData(DateTime(2025, 1, 26), nextIntInRange(2000, 10000)),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.days,
        dateFormat: DateFormat('dd.MM.yyyy'),
      ),
      primaryYAxis: NumericAxis(),
      series: <CartesianSeries>[
        ColumnSeries<RevenueData, DateTime>(
          dataSource: chartData,
          color: theme.custom.secondaryAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),

          xValueMapper: (RevenueData data, _) => data.date,
          yValueMapper: (RevenueData data, _) => data.revenue,
        ),
      ],
    );
  }
}

class RevenueData {
  final DateTime date;
  final double revenue;

  RevenueData(this.date, this.revenue);
}
