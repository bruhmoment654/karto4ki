import 'package:flutter/material.dart';
import 'package:quizzerg/feature/card_detail/presentation/card_detail_screen.dart';

/// UI layer for card detail screen.
///
/// Responsible for visual representation of card form:
/// input fields for question/answer, save button.
class CardDetailView extends StatelessWidget {
  final ICardDetailViewModel viewModel;

  const CardDetailView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
