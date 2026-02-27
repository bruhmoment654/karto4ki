import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/feature/settings/presentation/settings_screen.dart';

@RoutePage()
class SettingsFlow extends StatelessWidget implements AutoRouteWrapper {
  const SettingsFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen();
  }
}
