import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:quizzerg/feature/auth/presentation/auth_screen.dart';

@RoutePage()
class AuthFlow extends StatelessWidget implements AutoRouteWrapper {
  const AuthFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    // `AuthBloc` глобальный и уже отдан в дерево в app_flow — здесь только
    // экран, чтобы состояние входа переживало закрытие роута.
    return const AuthScreen();
  }
}
