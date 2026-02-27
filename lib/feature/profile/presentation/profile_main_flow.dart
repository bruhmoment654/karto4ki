import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/feature/profile/presentation/profile_screen.dart';

@RoutePage()
class ProfileMainFlow extends StatelessWidget implements AutoRouteWrapper {
  const ProfileMainFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const ProfileScreen();
  }
}
