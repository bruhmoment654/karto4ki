import 'package:flutter/material.dart';
import 'package:karto4ki/feature/card_test/presentation/card_test_screen.dart';

/// UI layer for card testing screen.
///
/// Responsible for visual test representation: card display,
/// navigation buttons, progress indicator.
class CardTestView extends StatelessWidget {
  final ICardTestViewModel viewModel;

  const CardTestView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
