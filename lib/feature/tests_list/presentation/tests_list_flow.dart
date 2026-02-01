import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:karto4ki/app/di/app_scope.dart';
import 'package:karto4ki/feature/tests_list/domain/bloc/tests_list_bloc.dart';
import 'package:karto4ki/feature/tests_list/presentation/tests_list_screen.dart';

/// Entry point for tests list screen.
///
/// This Flow provides [TestsListBloc] for the entire tests list screen subtree.
@RoutePage()
class TestsListFlow extends StatelessWidget implements AutoRouteWrapper {
  const TestsListFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();
    return BlocProvider(
      create: (context) => TestsListBloc(
        repository: scope.testsListRepository,
      )..add(const TestsListEvent.started()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const TestsListScreen();
  }
}
