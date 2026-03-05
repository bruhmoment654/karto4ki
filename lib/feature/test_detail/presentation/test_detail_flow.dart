import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_screen.dart';

/// Entry point for test detail screen.
///
/// This Flow provides [TestDetailBloc] for the entire test detail screen subtree.
@RoutePage()
class TestDetailFlow extends StatelessWidget implements AutoRouteWrapper {
  final int testId;
  final bool mixup;
  final int mixupMin;
  final int mixupMax;

  const TestDetailFlow({
    @PathParam('testId') required this.testId,
    this.mixup = false,
    this.mixupMin = 1,
    this.mixupMax = 5,
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();
    return BlocProvider(
      create: (context) => TestDetailBloc(
        repository: scope.testDetailRepository,
      )..add(TestDetailEvent.started(testId: testId)),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TestDetailScreen(
      mixup: mixup,
      mixupMin: mixupMin,
      mixupMax: mixupMax,
    );
  }
}
