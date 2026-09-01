import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/feature/developer/presentation/developer_debug_screen.dart';

/// Точка входа в дебаг-экран.
///
/// Экран доступен только в dev-сборке: вход — лонг-тап по табу профиля.
@RoutePage()
class DeveloperDebugFlow extends StatelessWidget implements AutoRouteWrapper {
  const DeveloperDebugFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const DeveloperDebugScreen();
  }
}
