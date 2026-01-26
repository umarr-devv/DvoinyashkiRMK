import 'package:app/blocs/blocs.dart';
import 'package:app/features/movement/widgets/widgets.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

@RoutePage()
class MovementScreen extends StatefulWidget {
  const MovementScreen({super.key});

  @override
  State<MovementScreen> createState() => _MovementScreenState();
}

class _MovementScreenState extends State<MovementScreen> {
  @override
  void initState() {
    BlocProvider.of<MovementsCubit>(context).update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: MovementHeader(),
      footer: MovementPagination(),
      child: MovementTable(),
    );
  }
}
