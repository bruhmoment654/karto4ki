import 'package:flutter/material.dart';
import 'package:karto4ki/feature/card_detail/presentation/card_detail_view.dart';

/// Card detail screen.
///
/// Contains card viewing, creation and editing logic:
/// question and answer input, data validation.
class CardDetailScreen extends StatefulWidget {
  const CardDetailScreen({super.key});

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen>
    implements ICardDetailViewModel {
  @override
  Widget build(BuildContext context) {
    return CardDetailView(viewModel: this);
  }
}

/// ViewModel interface for card detail screen.
///
/// Defines interaction contract between [CardDetailScreen] and [CardDetailView].
abstract interface class ICardDetailViewModel {}
