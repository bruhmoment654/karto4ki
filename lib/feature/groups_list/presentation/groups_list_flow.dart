import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/groups_list/domain/bloc/groups_list_bloc.dart';
import 'package:quizzerg/feature/groups_list/presentation/groups_list_screen.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/active_session_bloc.dart';

/// Точка входа в экран списка групп.
@RoutePage()
class GroupsListFlow extends StatelessWidget implements AutoRouteWrapper {
  const GroupsListFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GroupsListBloc(
            repository: scope.groupsListRepository,
          )..add(const GroupsListEvent.started()),
        ),
        BlocProvider(
          create: (_) => ActiveSessionBloc(
            repository: scope.activeSessionRepository,
          )..add(const ActiveSessionEvent.started()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const GroupsListScreen();
  }
}
