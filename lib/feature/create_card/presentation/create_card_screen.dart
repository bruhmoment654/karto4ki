import 'package:flutter/material.dart';
import 'package:karto4ki/feature/create_card/presentation/create_card_view.dart';

/// Экран создания карточки.
///
/// Содержит логику создания новой карточки: ввод вопроса и ответа,
/// выбор набора для добавления, валидация данных.
class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen>
    implements ICreateCardViewModel {
  @override
  Widget build(BuildContext context) {
    return CreateCardView(viewModel: this);
  }
}

/// Интерфейс ViewModel для экрана создания карточки.
///
/// Определяет контракт взаимодействия между [CreateCardScreen] и [CreateCardView].
abstract interface class ICreateCardViewModel {}
