import 'package:app/blocs/cubit/theme_cubit.dart';
import 'package:app/core/router/router.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final appRoute = AppRouter();
  final themeCubit = ThemeCubit();

  @override
  void initState() {
    themeCubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<ThemeCubit>(create: (context) => themeCubit)],
      child: BlocBuilder<ThemeCubit, bool?>(
        bloc: themeCubit,
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Flutter Template',
            theme: state == true ? darkTheme : lightTheme,
            routerConfig: appRoute.config(
              navigatorObservers: () => [
                TalkerRouteObserver(GetIt.I<Talker>()),
              ],
            ),
          );
        },
      ),
    );
  }
}
