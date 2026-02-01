import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:karto4ki/app/di/app_scope.dart';
import 'package:karto4ki/feature/tinder_test/domain/bloc/tinder_test_bloc.dart';
import 'package:karto4ki/feature/tinder_test/presentation/tinder_test_screen.dart';

/// Entry point for tinder test screen.
///
/// This Flow provides [TinderTestBloc] for the entire tinder test screen subtree.
@RoutePage()
class TinderTestFlow extends StatelessWidget implements AutoRouteWrapper {
  final int testId;

  const TinderTestFlow({
    @PathParam('testId') required this.testId,
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();
    return BlocProvider(
      create: (context) => TinderTestBloc(
        cardRepository: scope.cardRepository,
      )..add(TinderTestEvent.started(testId: testId)),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const TinderTestScreen();
  }
}
