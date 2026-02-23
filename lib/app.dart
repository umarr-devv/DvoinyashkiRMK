import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/blocs/blocs.dart';
import 'package:app/core/router/router.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/utils/scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final appRoute = AppRouter();

  final dataCubit = DataCubit();

  final authCubit = AuthCubit();
  final favoritesCubit = FavoritesCubit();
  final settingsCubit = SettingsCubit();
  final notificationCubit = NotificationCubit();

  late final OrderCubit orderCubit;
  late final ChecksCubit checksCubit;
  late final WithdrawsCubit withdrawsCubit;
  late final MovementsCubit movementsCubit;
  late final StatisticCubit statisticCubit;
  late final WorkShiftsCubit workShiftsCubit;
  late final WarehouseCubit warehouseCubit;

  late final SessionCubit sessionCubit;

  Future initCubits() async {
    dataCubit.update();
    orderCubit = OrderCubit(settingsCubit);
    checksCubit = ChecksCubit(settingsCubit);
    withdrawsCubit = WithdrawsCubit(settingsCubit);
    movementsCubit = MovementsCubit(settingsCubit);
    statisticCubit = StatisticCubit(settingsCubit);
    workShiftsCubit = WorkShiftsCubit(settingsCubit);
    sessionCubit = SessionCubit(settingsCubit, authCubit);
    warehouseCubit = WarehouseCubit(settingsCubit);
  }

  @override
  void initState() {
    super.initState();
    initCubits();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: dataCubit),
        BlocProvider.value(value: authCubit),
        BlocProvider.value(value: favoritesCubit),
        BlocProvider.value(value: orderCubit),
        BlocProvider.value(value: settingsCubit),
        BlocProvider.value(value: notificationCubit),
        BlocProvider.value(value: checksCubit),
        BlocProvider.value(value: withdrawsCubit),
        BlocProvider.value(value: movementsCubit),
        BlocProvider.value(value: statisticCubit),
        BlocProvider.value(value: workShiftsCubit),
        BlocProvider.value(value: sessionCubit),
        BlocProvider.value(value: warehouseCubit),
      ],
      child: ThemeProvider(
        initTheme: settingsCubit.state.isDarkTheme
            ? darkTheme.toTheme()
            : lightTheme.toTheme(),
        builder: (context, theme) {
          return FTheme(
            data: theme.brightness == Brightness.dark
                ? darkTheme.toFTheme()
                : lightTheme.toFTheme(),
            child: FToaster(
              child: MediaQuery(
                data: MediaQuery.of(context).scale(),
                child: MaterialApp.router(
                  title: 'Dvoinyashki RMK',
                  theme: theme,
                  debugShowCheckedModeBanner: false,
                  scrollBehavior: CustomScrollBehavior(),
                  routerConfig: appRoute.config(
                    navigatorObservers: () => [
                      TalkerRouteObserver(GetIt.I<Talker>()),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
