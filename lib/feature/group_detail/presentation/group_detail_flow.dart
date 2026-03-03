import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/group_detail/domain/bloc/group_detail_bloc.dart';
import 'package:quizzerg/feature/group_detail/presentation/group_detail_screen.dart';

/// Точка входа в экран деталки группы.
@RoutePage()
class GroupDetailFlow extends StatelessWidget implements AutoRouteWrapper {
  final int groupId;

  const GroupDetailFlow({
    @PathParam('groupId') required this.groupId,
    super.key,
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GroupDetailBloc(
            repository: scope.groupDetailRepository,
          )..add(GroupDetailEvent.started(groupId: groupId)),
        ),
        BlocProvider.value(value: scope.mixupBloc),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const GroupDetailScreen();
  }
}
