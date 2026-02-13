import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/card_detail/domain/bloc/card_detail_bloc.dart';
import 'package:quizzerg/feature/card_detail/presentation/card_detail_screen.dart';

/// Entry point for card detail screen.
///
/// This Flow provides [CardDetailBloc] for the entire card screen subtree.
/// Used for viewing, creating and editing cards.
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
