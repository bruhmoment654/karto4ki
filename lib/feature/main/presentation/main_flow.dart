import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karto4ki/app/di/app_scope.dart';
import 'package:karto4ki/feature/main/domain/bloc/main_bloc.dart';
import 'package:karto4ki/feature/main/presentation/main_screen.dart';

/// Entry point for main application screen.
@RoutePage()
class MainFlow extends StatelessWidget implements AutoRouteWrapper {
  const MainFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final appScope = context.read<IAppScope>();
    return BlocProvider(
      create: (context) => MainBloc(appScope.mainRepository),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}
