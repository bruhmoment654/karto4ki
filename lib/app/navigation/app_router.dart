import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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

part 'app_router.gr.dart';

extension TransitionsBuildersX on TransitionsBuilders {
  static Widget zoomInWithFade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final scale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(scale: scale, child: child),
    );
  }
}

/// {@template router.class}
/// Main point of the application navigation.
/// {@endtemplate}
@AutoRouterConfig(replaceInRouteName: 'Component|Flow,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.custom(
        transitionsBuilder: TransitionsBuildersX.zoomInWithFade,
        durationInMilliseconds: 150,
        reverseDurationInMilliseconds: 100,
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
            AutoRoute(
              page: ProfileRoute.page,
              children: [
                AutoRoute(page: ProfileMainRoute.page, initial: true),
                AutoRoute(page: SettingsRoute.page),
                AutoRoute(page: QuestionStatsRoute.page),
              ],
            ),
          ],
        ),
      ];

  AppRouter({super.navigatorKey});
}
