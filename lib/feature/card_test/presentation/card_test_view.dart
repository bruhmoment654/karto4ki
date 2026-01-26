import 'package:flutter/material.dart';
import 'package:karto4ki/feature/card_test/presentation/card_test_screen.dart';

/// UI-слой экрана тестирования карточек.
///
/// Отвечает за визуальное представление теста: отображение карточки,
/// кнопки навигации, индикатор прогресса.
class CardTestView extends StatelessWidget {
  final ICardTestViewModel viewModel;

  const CardTestView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
