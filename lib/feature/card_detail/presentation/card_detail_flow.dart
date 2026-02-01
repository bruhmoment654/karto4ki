import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karto4ki/feature/card_detail/domain/bloc/card_detail_bloc.dart';
import 'package:karto4ki/feature/card_detail/presentation/card_detail_screen.dart';

/// Точка входа в экран карточки.
///
/// Этот Flow предоставляет [CardDetailBloc] для всего поддерева экрана карточки.
/// Используется для просмотра, создания и редактирования карточек.
@RoutePage()
class CardDetailFlow extends StatelessWidget implements AutoRouteWrapper {
  const CardDetailFlow({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => CardDetailBloc(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return const CardDetailScreen();
  }
}
