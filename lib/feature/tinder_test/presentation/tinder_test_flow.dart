import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/tinder_test/domain/bloc/tinder_test_bloc.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_candidate_loader.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/question_mixup_service.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/scoring_mixup_service.dart';
import 'package:quizzerg/feature/tinder_test/presentation/tinder_test_screen.dart';

/// Entry point for tinder test screen.
///
/// This Flow provides [TinderTestBloc] for the entire tinder test screen subtree.
@RoutePage()
class TinderTestFlow extends StatelessWidget implements AutoRouteWrapper {
  final int testId;
  final bool swapSides;
  final int answerIndex;
  final bool mixup;
  final int mixupMin;
  final int mixupMax;

  const TinderTestFlow({
    @PathParam('testId') required this.testId,
    this.swapSides = false,
    this.answerIndex = 0,
    this.mixup = false,
    this.mixupMin = 1,
    this.mixupMax = 5,
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();
    final algorithm = scope.mixupBloc.state.algorithm;

    final candidateLoader = MixupCandidateLoader(
      cardRepository: scope.cardRepository,
      groupsDatabase: scope.database.groupsDatabase,
      questionStatsRepository: scope.questionStatsRepository,
    );

    final mixupService = switch (algorithm) {
      MixupAlgorithm.classic => QuestionMixupService(
          candidateLoader: candidateLoader,
        ),
      MixupAlgorithm.scoring => ScoringMixupService(
          candidateLoader: candidateLoader,
        ),
    };

    return BlocProvider(
      create: (context) => TinderTestBloc(
        cardRepository: scope.cardRepository,
        questionStatsRepository: scope.questionStatsRepository,
        mixupService: mixupService,
      )..add(TinderTestEvent.started(
          testId: testId,
          swapSides: swapSides,
          answerIndex: answerIndex,
          mixup: mixup,
          mixupMin: mixupMin,
          mixupMax: mixupMax,
        )),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const TinderTestScreen();
  }
}
