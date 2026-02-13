import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/feature/main_tab/presentation/main_tab_screen.dart';

/// Entry point for main tab with nested navigation.
@RoutePage()
class MainTabFlow extends StatelessWidget implements AutoRouteWrapper {
  const MainTabFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const MainTabScreen();
  }
}
