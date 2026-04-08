import 'package:app/blocs/blocs.dart';
import 'package:app/features/movement/blocs/blocs.dart';
import 'package:app/features/movement/widgets/transfer_table.dart';
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
  int _currentIndex = 0;

  @override
  void initState() {
    BlocProvider.of<MovementsCubit>(context).update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateMovementCubit(
            BlocProvider.of<SettingsCubit>(context),
            BlocProvider.of<AuthCubit>(context),
          ),
        ),
        BlocProvider(create: (context) => TransferCubit()),
        BlocProvider(
          create: (context) =>
              TransfersCubit(BlocProvider.of<SettingsCubit>(context))..update(),
        ),
      ],
      child: FScaffold(
        header: MovementHeader(tabIndex: _currentIndex),
        footer: MovementPagination(tabIndex: _currentIndex),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                spacing: 8,
                children: [
                  FButton(
                    onPress: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    style: _currentIndex == 0
                        ? FButtonStyle.primary()
                        : FButtonStyle.outline(),
                    child: const Text('Заказы'),
                  ),
                  FButton(
                    onPress: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    style: _currentIndex == 1
                        ? FButtonStyle.primary()
                        : FButtonStyle.outline(),
                    child: const Text('Перемещения'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _currentIndex == 0
                  ? const MovementTable()
                  : const TransferTable(),
            ),
          ],
        ),
      ),
    );
  }
}
