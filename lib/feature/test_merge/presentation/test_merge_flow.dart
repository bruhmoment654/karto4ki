import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/test_merge/domain/bloc/test_merge_bloc.dart';
import 'package:quizzerg/feature/test_merge/presentation/test_merge_screen.dart';

@RoutePage()
class TestMergeFlow extends StatelessWidget implements AutoRouteWrapper {
  final int initialTestId;

  const TestMergeFlow({
    required this.initialTestId,
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();
    return BlocProvider(
      create: (context) => TestMergeBloc(
        repository: scope.testMergeRepository,
      )..add(TestMergeEvent.started(initialTestId: initialTestId)),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const TestMergeScreen();
  }
}
