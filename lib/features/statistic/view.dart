import 'package:app/blocs/blocs.dart';
import 'package:app/features/statistic/widgets/widgets.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

@RoutePage()
class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  void initState() {
    BlocProvider.of<StatisticCubit>(context).update();
    super.initState();
  }

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
                Expanded(child: StatisticChart()),
              ],
            ),
          ),
        ),
        StatisticOther(),
      ],
    );
  }
}
