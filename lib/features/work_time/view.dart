import 'package:app/blocs/work_shifts/work_shifts_cubit.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
