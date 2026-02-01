import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:karto4ki/feature/home/presentation/home_screen.dart';

/// Entry point for home screen with nested navigation.
///
/// Serves as container for main application navigation.
/// Contains [AutoRouter] for switching between screens inside Home.
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
