import 'package:app/blocs/blocs.dart';
import 'package:app/core/router/router.dart';
import 'package:app/features/init/widgets/progress.dart';
import 'package:app/shared/widgets/windowsbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocListener<DataCubit, DataState>(
      listener: (context, state) {
        if (state is DataLoaded) {
          if (authCubit.state.user != null) {
            AutoRouter.of(context).push(MenuRoute());
          } else {
            AutoRouter.of(context).push(AuthRoute());
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Center(child: InitProgress()),
            WindowBar(),
          ],
        ),
      ),
    );
  }
}
