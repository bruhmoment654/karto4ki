import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karto4ki/feature/card_test/domain/bloc/card_test_bloc.dart';
import 'package:karto4ki/feature/card_test/presentation/card_test_screen.dart';

/// Точка входа в экран тестирования карточек.
///
/// Этот Flow предоставляет [CardTestBloc] для всего поддерева экрана тестирования.
/// Используется для прохождения теста по выбранному набору карточек.
@RoutePage()
class CardTestFlow extends StatelessWidget implements AutoRouteWrapper {
  const CardTestFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => CardTestBloc(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return const CardTestScreen();
  }
}
