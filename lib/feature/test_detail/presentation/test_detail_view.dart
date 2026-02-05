import 'package:flutter/material.dart';

import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:karto4ki/feature/test_detail/presentation/test_detail_screen.dart';
import 'package:karto4ki/feature/tests_list/domain/entity/test_entity.dart';
import 'package:karto4ki/l10n/app_localizations_x.dart';
import 'package:karto4ki/uikit/pressable/scale_pressable.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final canStartTest = switch (state) {
      TestDetailState$Loaded(:final cards) => cards.isNotEmpty,
      _ => false,
    };
    final startIcon = switch (state) {
      TestDetailState$Loaded(:final cards) when cards.isEmpty => Icons.close,
      _ => Icons.play_arrow_rounded,
    };

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Material(
            color: colorScheme.primary,
            child: InkWell(
              onTap: canStartTest ? viewModel.onStartTestPressed : null,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: 150,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        startIcon,
                        color: colorScheme.onPrimary,
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        switch (state) {
                          TestDetailState$Loaded(:final test) =>
                            test.title.toUpperCase(),
                          _ => context.l10n.testDetailLoadingTitle,
                        },
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
      body: switch (state) {
        TestDetailState$Loading() => const Center(
            child: CircularProgressIndicator(),
          ),
        TestDetailState$Error(:final failure) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.testDetailErrorMessage(
                    failure.message ?? context.l10n.testDetailUnknownError,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(context.l10n.testDetailRetryButton),
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
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (test.description != null && test.description!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              test.description!,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.testDetailCardsTitle(cards.length),
                style: textTheme.titleMedium,
              ),
              TextButton.icon(
                onPressed: viewModel.onImportCsvPressed,
                icon: const Icon(Icons.upload_file, size: 18),
                label: Text(context.l10n.csvImportButton),
              ),
            ],
          ),
        ),
        Expanded(
          child: cards.isEmpty
              ? Center(
                  child: Text(
                    context.l10n.testDetailEmptyCardsMessage,
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
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(card.id),
      direction: DismissDirection.endToStart,
      background: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
      confirmDismiss: (direction) async {
        return showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(context.l10n.testDetailDeleteCardTitle),
            content: Text(context.l10n.testDetailDeleteCardMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(context.l10n.testDetailDeleteCardCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(context.l10n.testDetailDeleteCardConfirm),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onDelete(),
      child: ScalePressable(
        onTap: onTap,
        child: Card(
          shape: const BeveledRectangleBorder(),
          color: colorScheme.secondary,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            title: Text(
              card.front,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colorScheme.onSecondary),
            ),
            subtitle: Text(
              card.back,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colorScheme.onSecondary),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
