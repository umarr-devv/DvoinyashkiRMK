import 'package:app/features/warehouse/view.dart';
import 'package:app/features/auth/view.dart';
import 'package:app/features/init/view.dart';
import 'package:app/features/menu/view.dart';
import 'package:app/features/movement/view.dart';
import 'package:app/features/order/view.dart';
import 'package:app/features/sell_history/view.dart';
import 'package:app/features/settings/view.dart';
import 'package:app/features/statistic/view.dart';
import 'package:app/features/withdraw/view.dart';
import 'package:app/features/work_time/view.dart';
import 'package:auto_route/auto_route.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: InitRoute.page, initial: true),
    CustomRoute(
      page: AuthRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    AutoRoute(
      page: MenuRoute.page,
      children: [
        AutoRoute(page: OrderRoute.page),
        AutoRoute(page: SellHistoryRoute.page),
        AutoRoute(page: WarehouseRoute.page),
        AutoRoute(page: WithdrawRoute.page),
        AutoRoute(page: MovementRoute.page),
        AutoRoute(page: StatisticRoute.page),
        AutoRoute(page: WorkTimeRoute.page),
      ],
    ),
    CustomRoute(
      page: SettingsRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ];
}
