import 'package:app/blocs/blocs.dart';
import 'package:app/features/work_time/widgets/widgets.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/widgets/scaffold.dart';

@RoutePage()
class WorkTimeScreen extends StatefulWidget {
  const WorkTimeScreen({super.key});

  @override
  State<WorkTimeScreen> createState() => _WorkTimeScreenState();
}

class _WorkTimeScreenState extends State<WorkTimeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WorkShiftsCubit>(context).update();
    BlocProvider.of<SessionCubit>(context).getCurrentWorkShift();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: WorkTimeHeader(),
      footer: WorkTimePagination(),
      child: Column(
        children: [
          WorkTimeSession(),
          Expanded(child: WorkTimeTable()),
        ],
      ),
    );
  }
}
