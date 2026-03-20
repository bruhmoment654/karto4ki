import 'package:flutter/material.dart';

import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/sliver_height.dart';

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
      appBar: _TestDetailAppBar(
        state: state,
        canStartTest: canStartTest,
        startIcon: startIcon,
        viewModel: viewModel,
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
        TestDetailState$Loaded(:final cards) => _TestDetailContent(
            cards: cards,
            viewModel: viewModel,
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

class _TestDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TestDetailState state;
  final bool canStartTest;
  final IconData startIcon;
  final ITestDetailViewModel viewModel;

  const _TestDetailAppBar({
    required this.state,
    required this.canStartTest,
    required this.startIcon,
    required this.viewModel,
  });

  @override
  Size get preferredSize {
    double bottomHeight = 0;
    if (state case TestDetailState$Loaded(:final test)) {
      if (test.description != null && test.description!.isNotEmpty) {
        bottomHeight += 56.0;
      }
    }
    return Size.fromHeight(
      DefaultAppBar.expandedToolbarHeight +
          bottomHeight +
          DefaultAppBar.dividerHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleText = switch (state) {
      TestDetailState$Loaded(:final test) => test.title.toUpperCase(),
      _ => context.l10n.testDetailLoadingTitle,
    };

    final hasDescription = switch (state) {
      TestDetailState$Loaded(:final test) =>
        test.description != null && test.description!.isNotEmpty,
      _ => false,
    };

    final bottom = hasDescription
        ? PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: _TestDescription(
              description: (state as TestDetailState$Loaded).test.description!,
            ),
          )
        : null;

    return DefaultAppBar.expanded(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(startIcon),
          const SizedBox(height: 8),
          Text(titleText),
        ],
      ),
      onTap: canStartTest ? viewModel.onStartTestPressed : null,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.close, color: Colors.white),
      ),
      bottom: bottom,
      elevation: 1,
    );
  }
}

class _TestDescription extends StatelessWidget {
  final String description;

  const _TestDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}

class _TestSettingsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _TestSettingsButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.tune, size: 18),
        label: const Text('Настройка теста'),
      ),
    );
  }
}

class _CardsCountWithImport extends StatelessWidget {
  final int count;
  final VoidCallback onImportPressed;

  const _CardsCountWithImport({
    required this.count,
    required this.onImportPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Text(
              context.l10n.testDetailCardsTitle(count),
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          const Spacer(),
          TextButton.icon(
            onPressed: onImportPressed,
            icon: const Icon(Icons.upload_file, size: 18),
            label: Text(context.l10n.csvImportButton),
          ),
        ],
      ),
    );
  }
}

class _TestDetailContent extends StatelessWidget {
  final List<CardEntity> cards;
  final ITestDetailViewModel viewModel;

  const _TestDetailContent({
    required this.cards,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: CustomScrollView(
        slivers: [
          const SliverHeight(8),
          SliverToBoxAdapter(
            child: _TestSettingsButton(
              onPressed: viewModel.onTestSettingsPressed,
            ),
          ),
          SliverToBoxAdapter(
            child: _CardsCountWithImport(
              count: cards.length,
              onImportPressed: viewModel.onImportCsvPressed,
            ),
          ),
          if (cards.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.testDetailEmptyCardsMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
              ),
            )
          else
            SliverList.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return _CardListItem(
                  card: card,
                  onTap: () => viewModel.onCardTapped(card),
                  onDelete: () => viewModel.onCardDeletePressed(card),
                );
              },
            ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 80,
            ),
          ),
        ],
      ),
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
            elevation: 5,
            type: ContentCardType.smallWide,
            padding: EdgeInsets.zero,
            child: ListTile(
              title: Text(
                card.front,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                card.formattedBack,
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
