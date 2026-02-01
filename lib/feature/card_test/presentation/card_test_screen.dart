import 'package:flutter/material.dart';
import 'package:karto4ki/feature/card_test/presentation/card_test_view.dart';

/// Card testing screen.
///
/// Contains user interaction logic with test:
/// card display, side switching, card navigation,
/// answer evaluation (know/don't know).
class CardTestScreen extends StatefulWidget {
  const CardTestScreen({super.key});

  @override
  State<CardTestScreen> createState() => _CardTestScreenState();
}

class _CardTestScreenState extends State<CardTestScreen>
    implements ICardTestViewModel {
  @override
  Widget build(BuildContext context) {
    return CardTestView(viewModel: this);
  }
}

/// ViewModel interface for card testing screen.
///
/// Defines interaction contract between [CardTestScreen] and [CardTestView].
abstract interface class ICardTestViewModel {}
