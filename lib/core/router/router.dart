import 'package:app/features/auth/view.dart';
import 'package:app/features/init/view.dart';
import 'package:app/features/menu/view.dart';
import 'package:app/features/order/view.dart';
import 'package:auto_route/auto_route.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MenuRoute.page,
      children: [
        AutoRoute(page: OrderRoute.page),
      ],
    ),
    AutoRoute(page: AuthRoute.page, initial: true),
    AutoRoute(page: InitRoute.page),
  ];
}
