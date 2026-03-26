import 'package:flutter/material.dart';

import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_screen.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/buttons/app_glow_button.dart';
import 'package:quizzerg/uikit/item_card/app_item_card.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

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
    return AppScaffold(
      useSafeArea: false,
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
                const Height(16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(context.l10n.testDetailRetryButton),
                ),
              ],
            ),
          ),
        TestDetailState$Loaded(:final test, :final cards) => _TestDetailLoadedBody(
            test: test,
            cards: cards,
            viewModel: viewModel,
            onBackPressed: viewModel.onBackPressed,
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

class _TestDetailLoadedBody extends StatelessWidget {
  final TestEntity test;
  final List<CardEntity> cards;
  final ITestDetailViewModel viewModel;
  final VoidCallback onBackPressed;

  const _TestDetailLoadedBody({
    required this.test,
    required this.cards,
    required this.viewModel,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      slivers: [
        const SliverFillRemaining(),
        SliverToBoxAdapter(
          child: _TestDetailHeader(
            test: test,
            canStart: cards.isNotEmpty,
            viewModel: viewModel,
            onBackPressed: onBackPressed,
          ),
        ),
        SliverToBoxAdapter(
          child: _TestSettingsButton(onPressed: viewModel.onTestSettingsPressed),
        ),
        SliverToBoxAdapter(
          child: _ActionsRow(
            cardsCount: cards.length,
            onImportCsvPressed: viewModel.onImportCsvPressed,
          ),
        ),
        if (cards.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyCardsPlaceholder(),
          )
        else
          SliverList.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return _CardListItem(
                card: card,
                onTap: () => viewModel.onCardTapped(card),
                onConfirmDismiss: () => viewModel.confirmCardDelete(card),
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
    );
  }
}

class _TestDetailHeader extends StatelessWidget {
  final TestEntity test;
  final bool canStart;
  final ITestDetailViewModel viewModel;
  final VoidCallback onBackPressed;

  const _TestDetailHeader({
    required this.test,
    required this.canStart,
    required this.viewModel,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppPageHeader.withBack(
      title: test.title,
      subtitle: test.description,
      onBackPressed: onBackPressed,
      onTitlePressed: viewModel.onEditTestPressed,
      action: _StartTestButton(
        canStart: canStart,
        onPressed: viewModel.onStartTestPressed,
      ),
    );
  }
}

class _StartTestButton extends StatelessWidget {
  final bool canStart;
  final VoidCallback onPressed;

  const _StartTestButton({
    required this.canStart,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (!canStart) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.onSurface.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Icon(
            Icons.play_arrow_rounded,
            color: colorScheme.onSurface.withValues(alpha: 0.38),
            size: 20,
          ),
        ),
      );
    }

    return AppGlowButton(
      onPressed: onPressed,
      child: const Icon(Icons.play_arrow_rounded),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  final int cardsCount;
  final VoidCallback onImportCsvPressed;

  const _ActionsRow({
    required this.cardsCount,
    required this.onImportCsvPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Text(
              context.l10n.testDetailCardsTitle(cardsCount),
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: onImportCsvPressed,
            icon: const Icon(Icons.upload_file, size: 18),
            label: Text(context.l10n.csvImportButton),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: AppGlowButton(
          onPressed: onPressed,
          color: Theme.of(context).colorScheme.secondary,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.tune, size: 18),
              SizedBox(width: 6),
              Text('Настройки'),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyCardsPlaceholder extends StatelessWidget {
  const _EmptyCardsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.testDetailEmptyCardsMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const Height(12),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _CardListItem extends StatelessWidget {
  final CardEntity card;
  final VoidCallback onTap;
  final Future<bool?> Function() onConfirmDismiss;
  final VoidCallback onDelete;

  const _CardListItem({
    required this.card,
    required this.onTap,
    required this.onConfirmDismiss,
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
      confirmDismiss: (_) => onConfirmDismiss(),
      onDismissed: (_) => onDelete(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ScalePressable(
          onTap: onTap,
          child: AppItemCard(
            icon: Icons.style_outlined,
            title: card.front,
            subtitle: card.formattedBack,
            trailing: Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
