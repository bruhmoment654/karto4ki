import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/question_stats/domain/bloc/question_stats_bloc.dart';
import 'package:quizzerg/feature/question_stats/presentation/question_stats_screen.dart';

@RoutePage()
class QuestionStatsFlow extends StatelessWidget implements AutoRouteWrapper {
  const QuestionStatsFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();

    return BlocProvider(
      create: (_) => QuestionStatsBloc(
        repository: scope.questionStatsRepository,
      )..add(const QuestionStatsEvent.started()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const QuestionStatsScreen();
  }
}
