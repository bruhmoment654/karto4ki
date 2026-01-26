import 'package:flutter/material.dart';
import 'package:karto4ki/feature/create_card/presentation/create_card_screen.dart';

/// UI-слой экрана создания карточки.
///
/// Отвечает за визуальное представление формы создания:
/// поля ввода для вопроса/ответа, кнопка сохранения.
class CreateCardView extends StatelessWidget {
  final ICreateCardViewModel viewModel;

  const CreateCardView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
