import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:karto4ki/feature/home/presentation/home_screen.dart';

/// Точка входа в домашний экран с вложенной навигацией.
///
/// Служит контейнером для основной навигации приложения.
/// Содержит [AutoRouter] для переключения между экранами внутри Home.
@RoutePage()
class HomeFlow extends StatelessWidget implements AutoRouteWrapper {
  const HomeFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
