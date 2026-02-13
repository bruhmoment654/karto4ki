import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/card_test/domain/bloc/card_test_bloc.dart';
import 'package:quizzerg/feature/card_test/presentation/card_test_screen.dart';

/// Entry point for card testing screen.
///
/// This Flow provides [CardTestBloc] for the entire testing screen subtree.
/// Used for executing tests on selected card sets.
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
