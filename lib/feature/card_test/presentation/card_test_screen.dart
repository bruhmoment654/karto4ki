import 'package:flutter/material.dart';
import 'package:karto4ki/feature/card_test/presentation/card_test_view.dart';

/// Экран тестирования карточек.
///
/// Содержит логику взаимодействия пользователя с тестом:
/// показ карточки, переключение между сторонами, навигация по карточкам,
/// оценка ответа (знаю/не знаю).
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

/// Интерфейс ViewModel для экрана тестирования карточек.
///
/// Определяет контракт взаимодействия между [CardTestScreen] и [CardTestView].
abstract interface class ICardTestViewModel {}
