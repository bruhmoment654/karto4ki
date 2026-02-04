import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:karto4ki/feature/profile/presentation/profile_screen.dart';

/// Entry point for profile screen.
@RoutePage()
class ProfileFlow extends StatelessWidget implements AutoRouteWrapper {
  const ProfileFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const ProfileScreen();
  }
}
