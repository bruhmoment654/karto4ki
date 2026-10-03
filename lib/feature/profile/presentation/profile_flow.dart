import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/app/navigation/active_tab_ticker_mode.dart';

@RoutePage()
class ProfileFlow extends StatelessWidget implements AutoRouteWrapper {
  const ProfileFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    // Бесконечные анимации профиля (вращение плашек) не тикают, пока таб
    // скрыт.
    return const ActiveTabTickerMode(child: AutoRouter());
  }
}
