import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:karto4ki/feature/card_detail/presentation/card_detail_flow.dart';
import 'package:karto4ki/feature/card_test/presentation/card_test_flow.dart';
import 'package:karto4ki/feature/home/presentation/home_flow.dart';
import 'package:karto4ki/feature/main/presentation/main_flow.dart';
import 'package:karto4ki/feature/test_detail/presentation/test_detail_flow.dart';
import 'package:karto4ki/feature/tests_list/presentation/tests_list_flow.dart';
import 'package:karto4ki/feature/tinder_test/presentation/tinder_test_flow.dart';

part 'app_router.gr.dart';

/// {@template router.class}
/// Main point of the application navigation.
/// {@endtemplate}
@AutoRouterConfig(replaceInRouteName: 'Component|Flow,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(page: TestsListRoute.page,),
            AutoRoute(page: MainRoute.page),
            AutoRoute(page: CardTestRoute.page),
            AutoRoute(page: CardDetailRoute.page),
            AutoRoute(page: TinderTestRoute.page),
            AutoRoute(page: TestDetailRoute.page),
          ],
        ),
      ];

  AppRouter({super.navigatorKey});
}
