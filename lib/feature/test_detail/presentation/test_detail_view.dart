import 'package:flutter/material.dart';

import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_screen.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';

/// UI layer for test detail screen.
///
/// Responsible for visual representation of test detail:
/// test info, list of cards, add/edit/delete functionality.
class TestDetailView extends StatelessWidget {
  final ITestDetailViewModel viewModel;
  final TestDetailState state;
  final bool swapSides;

  const TestDetailView({
    required this.viewModel,
    required this.state,
    required this.swapSides,
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

    return AppScaffold(
      useSafeArea: false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: ContentCard(
            type: ContentCardType.medium,
            backgroundColor: colorScheme.primary,
            borderRadius: BorderRadius.zero,
            padding: EdgeInsets.zero,
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  InkWell(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: colorScheme.onPrimary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 4,
                    top: MediaQuery.of(context).padding.top,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.chevron_left,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
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
            swapSides: swapSides,
          ),
      },
      floatingActionButton: state is TestDetailState$Loaded
          ? AppFloatingActionButton(
              label: context.l10n.testDetailAddCardFab,
              onPressed: viewModel.onAddCardPressed,
              icon: Icons.add,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _TestDetailContent extends StatelessWidget {
  final TestEntity test;
  final List<CardEntity> cards;
  final ITestDetailViewModel viewModel;
  final bool swapSides;

  const _TestDetailContent({
    required this.test,
    required this.cards,
    required this.viewModel,
    required this.swapSides,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (test.description != null && test.description!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              test.description!,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        SwitchListTile(
          title: Text(
            context.l10n.testDetailSwapSides,
            style: textTheme.bodyMedium,
          ),
          value: swapSides,
          onChanged: (v) => viewModel.onSwapSidesChanged(value: v),
          dense: true,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.testDetailEmptyCardsMessage,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
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
      padding: const EdgeInsets.only(bottom: 100),
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
      background: Icon(
        Icons.delete,
        color: colorScheme.onSurface,
      ),
      confirmDismiss: (direction) async {
        return showDialog<bool>(
          context: context,
          builder: (context) => AppDialog(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ScalePressable(
          onTap: onTap,
          child: ContentCard(
            type: ContentCardType.smallWide,
            padding: EdgeInsets.zero,
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
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      ),
    );
  }
}
