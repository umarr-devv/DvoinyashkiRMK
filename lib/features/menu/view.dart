import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/blocs/blocs.dart';
import 'package:app/core/router/router.dart';
import 'package:app/features/menu/widgets/widgets.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    BlocProvider.of<SessionCubit>(context).getCurrentWorkShift();
    BlocProvider.of<WarehouseCubit>(context).update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: WidgetOrderTraversalPolicy(),
      child: AutoTabsRouter.tabBar(
        routes: [
          OrderRoute(),
          SellHistoryRoute(),
          WarehouseRoute(),
          WithdrawRoute(),
          MovementRoute(),
          StatisticRoute(),
          WorkTimeRoute(),
        ],
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        builder: (context, child, tabController) {
          return ThemeSwitchingArea(
            child: Scaffold(
              body: Column(
                children: [
                  WindowBar(),
                  MenuNavBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
