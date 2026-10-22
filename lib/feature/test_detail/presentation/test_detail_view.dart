import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_detail/domain/bloc/test_detail_bloc.dart';
import 'package:quizzerg/feature/test_detail/presentation/test_detail_screen.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/empty_state/app_empty_state.dart';
import 'package:quizzerg/uikit/motion/staggered_appear.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// UI layer for test detail screen.
///
/// Responsible for visual representation of test detail:
/// test info, list of cards, add/edit/delete functionality.
class TestDetailView extends StatelessWidget {
  final ITestDetailViewModel viewModel;

  const TestDetailView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<TestDetailState>(
      bloc: viewModel.testDetailState,
      builder: (context, state) => ValueListenableBuilder<Set<String>>(
        valueListenable: viewModel.deletedCardIds,
        // Удалённые карточки пропадают сразу, ещё до записи в базу: снек
        // «Отменить» может вернуть их на место.
        builder: (context, deletedIds, _) => _Body(
          viewModel: viewModel,
          state: switch (state) {
            TestDetailState$Loaded(:final cards) when deletedIds.isNotEmpty =>
              state.copyWith(
                cards: cards
                    .where((card) => !deletedIds.contains(card.id))
                    .toList(),
              ),
            _ => state,
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final ITestDetailViewModel viewModel;
  final TestDetailState state;

  const _Body({required this.viewModel, required this.state});

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
        TestDetailState$Loaded(:final test, :final cards) =>
          _TestDetailLoadedBody(
            test: test,
            cards: cards,
            viewModel: viewModel,
            onBackPressed: viewModel.onBackPressed,
          ),
      },
      // В пустом тесте первую карточку предлагает кнопка пустого состояния —
      // FAB рядом с ней дублировал бы действие.
      floatingActionButton: switch (state) {
        TestDetailState$Loaded(:final cards) when cards.isNotEmpty =>
          AppFloatingActionButton(
            label: context.l10n.testDetailAddCardFab,
            onPressed: viewModel.onAddCardPressed,
            icon: Icons.add,
          ),
        _ => null,
      },
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
    return AnimationLimiter(
      child: CustomScrollView(
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
            // Не SliverFillRemaining: тот меряет заглушку intrinsic-высотой,
            // M3E-кнопки её занижают, и на низком экране низ обрезается.
            // Здесь заглушка занимает остаток вьюпорта, но может быть выше.
            SliverLayoutBuilder(
              builder: (context, constraints) => SliverToBoxAdapter(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: math.max(
                      0,
                      constraints.viewportMainAxisExtent -
                          constraints.precedingScrollExtent,
                    ),
                  ),
                  child: _EmptyCardsPlaceholder(
                    onAddCardPressed: viewModel.onAddCardPressed,
                    onImportCsvPressed: viewModel.onImportCsvPressed,
                  ),
                ),
              ),
            )
          else
            SliverList.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return StaggeredAppear(
                  position: index,
                  child: _CardListItem(
                    card: card,
                    onTap: () => viewModel.onCardTapped(card),
                    onDelete: () => viewModel.onCardDeletePressed(card),
                  ),
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
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: canStart ? viewModel.onStartTestPressed : null,
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
          // В пустом тесте импорт предлагает пустое состояние.
          if (cardsCount > 0)
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
  final VoidCallback onAddCardPressed;
  final VoidCallback onImportCsvPressed;

  const _EmptyCardsPlaceholder({
    required this.onAddCardPressed,
    required this.onImportCsvPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      title: context.l10n.testDetailEmptyCardsTitle,
      message: context.l10n.testDetailEmptyCardsMessage,
      primaryLabel: context.l10n.testDetailEmptyAddCardButton,
      onPrimaryPressed: onAddCardPressed,
      secondaryLabel: context.l10n.csvImportButton,
      secondaryIcon: Icons.upload_file,
      onSecondaryPressed: onImportCsvPressed,
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
    final textTheme = Theme.of(context).textTheme;

    return Dismissible(
      key: ValueKey(card.id),
      direction: DismissDirection.endToStart,
      background: Icon(
        Icons.delete,
        color: colorScheme.onSurface,
      ),
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
