import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/feature/auth/presentation/auth_flow.dart';
import 'package:quizzerg/feature/developer/presentation/developer_debug_flow.dart';
import 'package:quizzerg/feature/group_detail/presentation/group_detail_flow.dart';
import 'package:quizzerg/feature/groups_list/presentation/groups_list_flow.dart';
import 'package:quizzerg/feature/home/presentation/home_flow.dart';
import 'package:quizzerg/feature/main/presentation/main_flow.dart';
import 'package:quizzerg/feature/main_tab/presentation/main_tab_flow.dart';
import 'package:quizzerg/feature/profile/presentation/profile_flow.dart';
import 'package:quizzerg/feature/profile/presentation/profile_main_flow.dart';
import 'package:quizzerg/feature/question_stats/presentation/question_stats_flow.dart';
import 'package:quizzerg/feature/settings/presentation/settings_flow.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_flow.dart';
import 'package:quizzerg/feature/test_merge/presentation/test_merge_flow.dart';
import 'package:quizzerg/feature/tests_list/presentation/tests_list_flow.dart';
import 'package:quizzerg/feature/tinder_test/presentation/tinder_test_flow.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

part 'app_router.gr.dart';

extension TransitionsBuildersX on TransitionsBuilders {
  /// M3 shared axis по горизонтали — основной переход между экранами.
  static Widget sharedAxisHorizontal(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (AppMotion.reduced(context)) return child;

    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.horizontal,
      fillColor: Colors.transparent,
      child: child,
    );
  }
}

/// {@template router.class}
/// Main point of the application navigation.
/// {@endtemplate}
@AutoRouterConfig(replaceInRouteName: 'Component|Flow,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
    transitionsBuilder: TransitionsBuildersX.sharedAxisHorizontal,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 250),
  );

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
      children: [
        AutoRoute(
          page: MainTabRoute.page,
          initial: true,
          children: [
            AutoRoute(page: GroupsListRoute.page, initial: true),
            AutoRoute(page: GroupDetailRoute.page),
            AutoRoute(page: MainRoute.page),
            AutoRoute(page: TinderTestRoute.page),
            AutoRoute(page: TestDetailRoute.page),
            AutoRoute(page: TestMergeRoute.page),
          ],
        ),
        AutoRoute(page: QuestionStatsRoute.page),
        AutoRoute(
          page: ProfileRoute.page,
          children: [
            AutoRoute(page: ProfileMainRoute.page, initial: true),
            AutoRoute(page: SettingsRoute.page),
            AutoRoute(page: AuthRoute.page),
          ],
        ),
      ],
    ),
    // Экран входа — корневой, поверх табов: открывается и из профиля,
    // и из диалога синхронизации.
    // Дебаг-экран поверх навигации: вход — лонг-тап по табу профиля
    // в dev-сборке.
    AutoRoute(page: DeveloperDebugRoute.page),
  ];

  AppRouter({super.navigatorKey});
}
