import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karto4ki/feature/create_card/domain/bloc/create_card_bloc.dart';
import 'package:karto4ki/feature/create_card/presentation/create_card_screen.dart';

/// Точка входа в экран создания карточки.
///
/// Этот Flow предоставляет [CreateCardBloc] для всего поддерева экрана создания.
/// Используется для добавления новых карточек в наборы пользователя.
@RoutePage()
class CreateCardFlow extends StatelessWidget implements AutoRouteWrapper {
  const CreateCardFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => CreateCardBloc(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return const CreateCardScreen();
  }
}
