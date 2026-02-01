import 'package:flutter/material.dart';
import 'package:karto4ki/feature/card_detail/presentation/card_detail_view.dart';

/// Экран карточки.
///
/// Содержит логику просмотра, создания и редактирования карточки:
/// ввод вопроса и ответа, валидация данных.
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

/// Интерфейс ViewModel для экрана карточки.
///
/// Определяет контракт взаимодействия между [CardDetailScreen] и [CardDetailView].
abstract interface class ICardDetailViewModel {}
