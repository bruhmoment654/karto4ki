import 'package:flutter/material.dart';

import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:karto4ki/feature/test_detail/presentation/test_detail_screen.dart';
import 'package:karto4ki/feature/tests/domain/entity/test_entity.dart';

/// UI layer for test detail screen.
///
/// Responsible for visual representation of test detail:
/// test info, list of cards, add/edit/delete functionality.
class TestDetailView extends StatelessWidget {
  final ITestDetailViewModel viewModel;
  final TestDetailState state;

  const TestDetailView({
    required this.viewModel,
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          switch (state) {
            TestDetailState$Loaded(:final test) => test.title,
            _ => 'Загрузка...',
          },
        ),
        actions: [
          if (state is TestDetailState$Loaded)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: viewModel.onEditTestPressed,
              tooltip: 'Редактировать тест',
            ),
        ],
      ),
      body: switch (state) {
        TestDetailState$Loading() => const Center(
            child: CircularProgressIndicator(),
          ),
        TestDetailState$Error(:final failure) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ошибка: ${failure.message ?? "Неизвестная ошибка"}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Повторить'),
                ),
              ],
            ),
          ),
        TestDetailState$Loaded(:final test, :final cards) => _TestDetailContent(
            test: test,
            cards: cards,
            viewModel: viewModel,
          ),
      },
      floatingActionButton: state is TestDetailState$Loaded
          ? FloatingActionButton(
              onPressed: viewModel.onAddCardPressed,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class _TestDetailContent extends StatelessWidget {
  final TestEntity test;
  final List<CardEntity> cards;
  final ITestDetailViewModel viewModel;

  const _TestDetailContent({
    required this.test,
    required this.cards,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (test.description != null && test.description!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              test.description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ),
        if (cards.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: viewModel.onStartTestPressed,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Начать тест'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Карточки (${cards.length})',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: cards.isEmpty
              ? const Center(
                  child: Text(
                    'Нет карточек.\nНажмите + чтобы добавить первую.',
                    textAlign: TextAlign.center,
                  ),
                )
              : _CardsList(
                  cards: cards,
                  viewModel: viewModel,
                ),
        ),
      ],
    );
  }
}

class _CardsList extends StatelessWidget {
  final List<CardEntity> cards;
  final ITestDetailViewModel viewModel;

  const _CardsList({
    required this.cards,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return _CardListItem(
          card: card,
          onTap: () => viewModel.onCardTapped(card),
          onDelete: () => viewModel.onCardDeletePressed(card),
        );
      },
    );
  }
}

class _CardListItem extends StatelessWidget {
  final CardEntity card;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _CardListItem({
    required this.card,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(card.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        return showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Удалить карточку?'),
            content: const Text('Вы уверены, что хотите удалить эту карточку?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Удалить'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          title: Text(
            card.front,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            card.back,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}
