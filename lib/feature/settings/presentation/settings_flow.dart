import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/settings/presentation/settings_screen.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/attempt_history_bloc.dart';

/// Экран настроек.
///
/// Провайдит [AttemptHistoryBloc]: размер истории нужен только здесь, а
/// `SettingsBloc` живёт в app-скоупе и работу с БД туда не тянем.
@RoutePage()
class SettingsFlow extends StatelessWidget implements AutoRouteWrapper {
  const SettingsFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();
    return BlocProvider(
      create: (context) => AttemptHistoryBloc(
        repository: scope.testAttemptRepository,
      )..add(const AttemptHistoryEvent.started()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SettingsScreen();
  }
}
