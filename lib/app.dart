import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/blocs/blocs.dart';
import 'package:app/blocs/product_images/product_images_cubit.dart';
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

  final structureUnitsCubit = StructureUnitsCubit();
  final usersCubit = UsersCubit();
  final authCubit = AuthCubit();
  final categoriesCubit = CategoriesCubit();
  final productsCubit = ProductsCubit();
  final favoritesCubit = FavoritesCubit();
  final productImagesCubit = ProductImagesCubit();
  final orderCubit = OrderCubit();
  final cashRegistersCubit = CashRegistersCubit();
  final settingsCubit = SettingsCubit();
  final notificationCubit = NotificationCubit();

  late final ChecksCubit checksCubit;

  Future initCubits() async {
    checksCubit = ChecksCubit(settingsCubit);

    await structureUnitsCubit.update();
    await usersCubit.update();
    await categoriesCubit.update();
    await productsCubit.update();
    await productImagesCubit.update();
    await cashRegistersCubit.update();
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
        BlocProvider.value(value: structureUnitsCubit),
        BlocProvider.value(value: usersCubit),
        BlocProvider.value(value: categoriesCubit),
        BlocProvider.value(value: productsCubit),
        BlocProvider.value(value: productImagesCubit),
        BlocProvider.value(value: cashRegistersCubit),
        BlocProvider.value(value: authCubit),
        BlocProvider.value(value: favoritesCubit),
        BlocProvider.value(value: orderCubit),
        BlocProvider.value(value: settingsCubit),
        BlocProvider.value(value: checksCubit),
        BlocProvider.value(value: notificationCubit),
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
