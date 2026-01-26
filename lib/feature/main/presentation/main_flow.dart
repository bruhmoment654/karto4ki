import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karto4ki/feature/main/domain/bloc/main_bloc.dart';
import 'package:karto4ki/feature/main/presentation/main_screen.dart';

/// Точка входа в главный экран приложения.
///
/// Этот Flow предоставляет [MainBloc] для всего поддерева главного экрана.
/// Является первым экраном, с которого пользователь начинает взаимодействие
/// с приложением после запуска.
///
/// TODO: Уточнить функциональность главного экрана.
@RoutePage()
class MainFlow extends StatelessWidget implements AutoRouteWrapper {
  const MainFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => MainBloc(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}
