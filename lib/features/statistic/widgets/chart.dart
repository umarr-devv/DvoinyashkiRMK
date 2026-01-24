import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticChart extends StatelessWidget {
  const StatisticChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<StatisticCubit, StatisticState>(
      bloc: BlocProvider.of<StatisticCubit>(context),
      builder: (context, state) {
        if (state is StatisticLoading) {
          return FCircularProgress();
        }
        return SfCartesianChart(
          primaryXAxis: DateTimeAxis(
            intervalType: state.isHourInterval
                ? DateTimeIntervalType.hours
                : DateTimeIntervalType.days,
            dateFormat: state.isHourInterval
                ? DateFormat('HH:mm')
                : DateFormat('dd.MM.yy'),
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.currency(symbol: '', decimalDigits: 0),
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            color: theme.custom.muted,
            builder: (data, point, series, pointIndex, seriesIndex) {
              return _ChartTooltip(data, state.isHourInterval);
            },
          ),
          series: <CartesianSeries>[
            ColumnSeries<StatisticCheckSumData, DateTime>(
              dataSource: state.checkSums,
              animationDuration: 250,
              enableTooltip: true,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
              pointColorMapper: (datum, index) {
                final ratio = datum.totalSum / (state.avgDaySum * 2);
                final alpha = (0.5 + ratio * 0.5).clamp(0.5, 1.0);
                return theme.custom.secondaryAccent.withValues(alpha: alpha);
              },
              xValueMapper: (StatisticCheckSumData data, _) => data.period,
              yValueMapper: (StatisticCheckSumData data, _) => data.totalSum,
            ),
          ],
        );
      },
    );
  }
}

class _ChartTooltip extends StatelessWidget {
  const _ChartTooltip(this.checkSum, this.isHourInterval);

  final StatisticCheckSumData checkSum;
  final bool isHourInterval;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FLabel(
            label: Text('Время'),
            axis: Axis.vertical,
            child: Text(
              DateFormat(
                isHourInterval ? 'HH:mm dd.MM.yyyy' : 'dd.MM.yyyy',
              ).format(checkSum.period),
            ),
          ),
          FLabel(
            label: Text('Сумма'),
            axis: Axis.vertical,
            child: Text(
              NumberFormat.currency(symbol: '').format(checkSum.totalSum),
            ),
          ),
        ],
      ),
    );
  }
}
