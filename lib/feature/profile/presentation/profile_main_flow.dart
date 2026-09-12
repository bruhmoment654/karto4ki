import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/profile/domain/bloc/profile_bloc.dart';
import 'package:quizzerg/feature/profile/presentation/profile_screen.dart';

@RoutePage()
class ProfileMainFlow extends StatelessWidget implements AutoRouteWrapper {
  const ProfileMainFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();

    return BlocProvider(
      create: (_) => ProfileBloc(
        questionStatsRepository: scope.questionStatsRepository,
        groupsListRepository: scope.groupsListRepository,
        testsListRepository: scope.testsListRepository,
      )..add(const ProfileEvent.started()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ProfileScreen();
  }
}
