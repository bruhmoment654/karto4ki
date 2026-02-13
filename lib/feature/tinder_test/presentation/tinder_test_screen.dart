import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/tinder_test/domain/bloc/tinder_test_bloc.dart';
import 'package:quizzerg/feature/tinder_test/presentation/tinder_test_view.dart';

/// Tinder test screen.
///
/// Contains logic for handling test execution interactions.
class TinderTestScreen extends StatefulWidget {
  const TinderTestScreen({super.key});

  @override
  State<TinderTestScreen> createState() => _TinderTestScreenState();
}

class _TinderTestScreenState extends State<TinderTestScreen>
    implements ITinderTestViewModel {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TinderTestBloc, TinderTestState>(
      builder: (context, state) {
        return TinderTestView(viewModel: this, state: state);
      },
    );
  }

  @override
  void onSwipeLeft(CardEntity card) {
    context.read<TinderTestBloc>().add(
          TinderTestEvent.swipedLeft(cardId: card.id),
        );
  }

  @override
  void onSwipeRight(CardEntity card) {
    context.read<TinderTestBloc>().add(
          TinderTestEvent.swipedRight(cardId: card.id),
        );
  }

  @override
  void onRestartPressed() {
    context.read<TinderTestBloc>().add(
          const TinderTestEvent.restarted(),
        );
  }

  @override
  void onBackPressed() {
    context.router.maybePop();
  }

  @override
  void onDiscardPressed() {
    context.read<TinderTestBloc>().add(
          const TinderTestEvent.discard(),
        );
  }
}

/// ViewModel interface for tinder test screen.
///
/// Defines interaction contract between [TinderTestScreen] and [TinderTestView].
abstract interface class ITinderTestViewModel {
  /// Called when card is swiped left (incorrect).
  void onSwipeLeft(CardEntity card);

  /// Called when card is swiped right (correct).
  void onSwipeRight(CardEntity card);

  /// Called when restart button is pressed.
  void onRestartPressed();

  /// Called when back button is pressed.
  void onBackPressed();

  /// Called when discard answer button is pressed.
  void onDiscardPressed();
}
