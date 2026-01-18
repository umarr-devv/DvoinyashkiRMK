import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/core/router/router.dart';
import 'package:app/features/menu/widgets/widgets.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [
        OrderRoute(),
        SellHistoryRoute(),
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
    );
  }
}
