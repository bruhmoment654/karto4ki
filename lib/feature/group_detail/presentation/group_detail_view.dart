import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/group_detail/domain/bloc/group_detail_bloc.dart';
import 'package:quizzerg/feature/group_detail/presentation/group_detail_screen.dart';
import 'package:quizzerg/feature/group_detail/presentation/widget/group_summary_card.dart';
import 'package:quizzerg/feature/group_detail/presentation/widget/test_stats_card.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/question_stats/presentation/study_progress_format.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/empty_state/app_empty_state.dart';
import 'package:quizzerg/uikit/motion/staggered_appear.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// UI-слой экрана деталки группы.
class GroupDetailView extends StatelessWidget {
  final IGroupDetailViewModel viewModel;

  const GroupDetailView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<GroupDetailState>(
      bloc: viewModel.groupDetailState,
      builder: (context, state) => ValueListenableBuilder<Set<String>>(
        valueListenable: viewModel.removedTestIds,
        builder: (context, removedIds, _) => _buildScaffold(
          context,
          state,
          // Убранные тесты пропадают сразу, ещё до записи в базу: снек
          // «Отменить» может вернуть их на место.
          tests: switch (state) {
            GroupDetailState$Loaded(:final tests) => tests
                .where((test) => !removedIds.contains(test.id))
                .toList(),
            _ => const [],
          },
        ),
      ),
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    GroupDetailState state, {
    required List<TestEntity> tests,
  }) {
    return AppScaffold(
      useSafeArea: false,
      // В пустой группе новый тест предлагает кнопка пустого состояния —
      // FAB рядом с ней дублировал бы действие.
      floatingActionButton:
          state is GroupDetailState$Loaded && tests.isNotEmpty
              ? AppFloatingActionButton(
                  label: context.l10n.groupDetailNewTestButton,
                  onPressed: viewModel.onAddTestPressed,
                )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: switch (state) {
        GroupDetailState$Loading() => const Center(
            child: CircularProgressIndicator(),
          ),
        GroupDetailState$Error(:final failure) => Center(
            child: Text(
              context.l10n.groupDetailErrorMessage(
                failure.message ?? context.l10n.groupDetailUnknownError,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        GroupDetailState$Loaded(:final group) => _LoadedBody(
            group: group,
            tests: tests,
            viewModel: viewModel,
            onBackPressed: viewModel.onBackPressed,
          ),
      },
    );
  }
}

class _LoadedBody extends StatelessWidget {
  final TestGroupEntity group;
  final List<TestEntity> tests;
  final IGroupDetailViewModel viewModel;
  final VoidCallback onBackPressed;

  const _LoadedBody({
    required this.group,
    required this.tests,
    required this.viewModel,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (tests.isEmpty) {
      // Заглушка — по центру всего экрана, а не места под шапкой: иначе
      // она заметно съезжает вниз.
      return Stack(
        children: [
          Positioned.fill(
            child: _EmptyTestsPlaceholder(
              onAddTestPressed: viewModel.onAddTestPressed,
            ),
          ),
          _GroupDetailHeader(
            group: group,
            onBackPressed: onBackPressed,
            viewModel: viewModel,
          ),
        ],
      );
    }

    return AnimationLimiter(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _GroupDetailHeader(
              group: group,
              onBackPressed: onBackPressed,
              viewModel: viewModel,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GroupSummaryCard(progress: group.progress),
            ),
          ),
          const SliverToBoxAdapter(child: _TestsHeader()),
          _TestListSliver(tests: tests, viewModel: viewModel),
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

class _GroupDetailHeader extends StatelessWidget {
  final TestGroupEntity group;
  final VoidCallback onBackPressed;
  final IGroupDetailViewModel viewModel;

  const _GroupDetailHeader({
    required this.group,
    required this.onBackPressed,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return AppPageHeader.withBack(
      title: group.title,
      subtitle: StudyProgressFormat.groupSubtitle(
        l10n: context.l10n,
        testCount: group.testCount,
        lastStudiedAt: group.progress.lastStudiedAt,
        now: DateTime.now(),
      ),
      onBackPressed: onBackPressed,
      onTitlePressed: viewModel.onEditTitlePressed,
      action: IconButton(
        onPressed: viewModel.onSettingsPressed,
        tooltip: context.l10n.groupDetailSettingsButton,
        icon: const Icon(Icons.tune_rounded),
      ),
    );
  }
}

class _EmptyTestsPlaceholder extends StatelessWidget {
  final VoidCallback onAddTestPressed;

  const _EmptyTestsPlaceholder({required this.onAddTestPressed});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      title: context.l10n.groupDetailEmptyTitle,
      message: context.l10n.groupDetailEmptyMessage,
      primaryLabel: context.l10n.groupDetailNewTestButton,
      onPrimaryPressed: onAddTestPressed,
    );
  }
}

class _TestListSliver extends StatelessWidget {
  final List<TestEntity> tests;
  final IGroupDetailViewModel viewModel;

  const _TestListSliver({
    required this.tests,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: tests.length,
        separatorBuilder: (_, __) => const Height(10),
        itemBuilder: (context, index) {
          final test = tests[index];
          return StaggeredAppear(
            position: index,
            child: _TestListItem(
              test: test,
              onTap: () => viewModel.onTestTapped(test),
              onLongPress: () => viewModel.onTestLongPressed(test),
              onDismissed: () => viewModel.onTestRemovePressed(test),
            ),
          );
        },
      ),
    );
  }
}

class _TestListItem extends StatelessWidget {
  final TestEntity test;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onDismissed;

  const _TestListItem({
    required this.test,
    required this.onTap,
    required this.onLongPress,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(test.id),
      direction: DismissDirection.endToStart,
      background: Icon(
        Icons.remove_circle_outline,
        color: colorScheme.onSurface,
      ),
      onDismissed: (_) => onDismissed(),
      child: ScalePressable(
        onTap: onTap,
        onLongPress: onLongPress,
        child: TestStatsCard(test: test, onAddCardsPressed: onTap),
      ),
    );
  }
}

/// Подпись «ТЕСТЫ» над списком.
class _TestsHeader extends StatelessWidget {
  const _TestsHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      child: Text(
        context.l10n.groupDetailTestsHeader.toUpperCase(),
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
