import 'package:app/blocs/blocs.dart';
import 'package:app/core/router/router.dart';
import 'package:app/features/init/widgets/progress.dart';
import 'package:app/shared/widgets/windowsbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  Future init() async {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final router = AutoRouter.of(context);

    await Future.delayed(const Duration(seconds: 5));

    if (authCubit.state.user != null) {
      router.push(MenuRoute());
    } else {
      router.push(AuthRoute());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: InitProgress()),
          WindowBar(),
        ],
      ),
    );
  }
}
