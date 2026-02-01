import 'package:flutter/material.dart';
import 'package:karto4ki/feature/card_detail/presentation/card_detail_screen.dart';

/// UI-слой экрана карточки.
///
/// Отвечает за визуальное представление формы карточки:
/// поля ввода для вопроса/ответа, кнопка сохранения.
class CardDetailView extends StatelessWidget {
  final ICardDetailViewModel viewModel;

  const CardDetailView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
