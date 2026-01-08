import 'package:app/core/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [HomeRoute()],
      scrollDirection: Axis.horizontal,
      builder: (context, child, tabController) {
        return Scaffold(body: child);
      },
    );
  }
}
