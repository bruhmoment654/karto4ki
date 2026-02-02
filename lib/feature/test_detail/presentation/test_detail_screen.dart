import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:karto4ki/app/navigation/app_router.dart';
import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:karto4ki/feature/test_detail/presentation/test_detail_view.dart';
import 'package:karto4ki/feature/tests_list/domain/entity/test_type.dart';

/// Test detail screen.
///
/// Contains logic for displaying test info, managing cards.
class TestDetailScreen extends StatefulWidget {
  const TestDetailScreen({super.key});

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen>
    implements ITestDetailViewModel {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestDetailBloc, TestDetailState>(
      builder: (context, state) {
        return TestDetailView(viewModel: this, state: state);
      },
    );
  }

  @override
  void onAddCardPressed() {
    _showAddCardDialog();
  }

  @override
  void onCardTapped(CardEntity card) {
    _showEditCardDialog(card);
  }

  @override
  void onCardDeletePressed(CardEntity card) {
    context.read<TestDetailBloc>().add(
          TestDetailEvent.cardDeleted(cardId: int.parse(card.id)),
        );
  }

  @override
  void onEditTestPressed() {
    final state = context.read<TestDetailBloc>().state;
    if (state is TestDetailState$Loaded) {
      _showEditTestDialog(state.test.title, state.test.description);
    }
  }

  void _showAddCardDialog() {
    final frontController = TextEditingController();
    final backController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Новая карточка'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: frontController,
              decoration: const InputDecoration(
                labelText: 'Вопрос',
                hintText: 'Введите вопрос',
              ),
              autofocus: true,
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: backController,
              decoration: const InputDecoration(
                labelText: 'Ответ',
                hintText: 'Введите ответ',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              final front = frontController.text.trim();
              final back = backController.text.trim();
              if (front.isNotEmpty && back.isNotEmpty) {
                context.read<TestDetailBloc>().add(
                      TestDetailEvent.cardAdded(
                        front: front,
                        back: back,
                      ),
                    );
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }

  void _showEditCardDialog(CardEntity card) {
    final frontController = TextEditingController(text: card.front);
    final backController = TextEditingController(text: card.back);

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Редактировать карточку'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: frontController,
              decoration: const InputDecoration(
                labelText: 'Вопрос',
              ),
              autofocus: true,
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: backController,
              decoration: const InputDecoration(
                labelText: 'Ответ',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              final front = frontController.text.trim();
              final back = backController.text.trim();
              if (front.isNotEmpty && back.isNotEmpty) {
                final updatedCard = CardEntity(
                  id: card.id,
                  testId: card.testId,
                  front: front,
                  back: back,
                  createdAt: card.createdAt,
                  updatedAt: DateTime.now(),
                );
                context.read<TestDetailBloc>().add(
                      TestDetailEvent.cardUpdated(card: updatedCard),
                    );
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showEditTestDialog(String currentTitle, String? currentDescription) {
    final titleController = TextEditingController(text: currentTitle);
    final descriptionController =
        TextEditingController(text: currentDescription ?? '');

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Редактировать тест'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Название',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Описание',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                context.read<TestDetailBloc>().add(
                      TestDetailEvent.testUpdated(
                        title: title,
                        description: descriptionController.text.trim().isEmpty
                            ? null
                            : descriptionController.text.trim(),
                      ),
                    );
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  @override
  void onStartTestPressed() {
    final state = context.read<TestDetailBloc>().state;
    if (state is! TestDetailState$Loaded) return;

    final test = state.test;
    final testId = int.parse(test.id);

    switch (test.type) {
      case TestType.tinder:
        context.router.push(TinderTestRoute(testId: testId));
    }
  }
}

/// ViewModel interface for test detail screen.
///
/// Defines interaction contract between [TestDetailScreen] and [TestDetailView].
abstract interface class ITestDetailViewModel {
  /// Called when add card button is pressed.
  void onAddCardPressed();

  /// Called when a card is tapped.
  void onCardTapped(CardEntity card);

  /// Called when delete card button is pressed.
  void onCardDeletePressed(CardEntity card);

  /// Called when edit test button is pressed.
  void onEditTestPressed();

  /// Called when start test button is pressed.
  void onStartTestPressed();
}
