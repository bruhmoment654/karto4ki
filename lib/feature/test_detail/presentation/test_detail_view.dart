import 'package:flutter/material.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_screen.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        _TestDetailHeader(
          test: test,
          cardsCount: cards.length,
          canStart: cards.isNotEmpty,
          viewModel: viewModel,
          onBackPressed: onBackPressed,
        ),
        SliverToBoxAdapter(
          child: _ActionsRow(
            cardsCount: cards.length,
            onImportCsvPressed: viewModel.onImportCsvPressed,
            onSettingsPressed: viewModel.onTestSettingsPressed,
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
  final int cardsCount;
  final bool canStart;
  final ITestDetailViewModel viewModel;
  final VoidCallback onBackPressed;

  const _TestDetailHeader({
    required this.test,
    required this.cardsCount,
    required this.canStart,
    required this.viewModel,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final onContainer = colorScheme.onPrimaryContainer;
    final topInset = MediaQuery.of(context).padding.top;

    return SliverAppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 0,
      expandedHeight: topInset + _contentHeight,
      pinned: true,
      stretch: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(AppDimens.radius28),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 56,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: onBackPressed,
                          icon: Icon(Icons.arrow_back, color: onContainer),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed:
                              canStart ? viewModel.onStartTestPressed : null,
                          icon: Icon(Icons.play_arrow, color: onContainer),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: viewModel.onEditTestPressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            test.title,
                            style: textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.5,
                              color: onContainer,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Height(6),
                          Text(
                            context.l10n.testDetailCardsCount(cardsCount),
                            style: textTheme.bodyMedium?.copyWith(
                              color: onContainer.withValues(alpha: 0.78),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Высота контента шапки без учёта верхнего системного отступа.
  static const double _contentHeight = 152;
}

class _ActionsRow extends StatelessWidget {
  final int cardsCount;
  final VoidCallback onImportCsvPressed;
  final VoidCallback onSettingsPressed;

  const _ActionsRow({
    required this.cardsCount,
    required this.onImportCsvPressed,
    required this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.testDetailCardsTitle(cardsCount),
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.tonalIcon(
                onPressed: onSettingsPressed,
                icon: const Icon(Icons.tune, size: 18),
                label: Text(context.l10n.testDetailSettingsButton),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onImportCsvPressed,
              icon: const Icon(Icons.upload_file, size: 18),
              label: Text(context.l10n.csvImportButton),
            ),
          ),
        ],
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
    final textTheme = Theme.of(context).textTheme;

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: ScalePressable(
          onTap: onTap,
          child: ContentCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.front,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const Height(2),
                      Text(
                        card.formattedBack,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 22,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
