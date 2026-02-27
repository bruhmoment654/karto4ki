import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/feature/question_stats/presentation/question_stats_screen.dart';

@RoutePage()
class QuestionStatsFlow extends StatelessWidget implements AutoRouteWrapper {
  const QuestionStatsFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return const QuestionStatsScreen();
  }
}
