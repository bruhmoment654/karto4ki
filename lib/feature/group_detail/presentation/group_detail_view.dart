import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/group_detail/domain/bloc/group_detail_bloc.dart';
import 'package:quizzerg/feature/group_detail/presentation/group_detail_screen.dart';
import 'package:quizzerg/feature/mixup/domain/bloc/mixup_bloc.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/dropdown/app_dropdown.dart';
import 'package:quizzerg/uikit/item_card/app_item_card.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/slider/app_range_slider.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/switch/app_switch.dart';

/// UI-слой экрана деталки группы.
class GroupDetailView extends StatelessWidget {
  final IGroupDetailViewModel viewModel;
  final GroupDetailState state;

  const GroupDetailView({
    required this.viewModel,
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useSafeArea: false,
      floatingActionButton: state is GroupDetailState$Loaded
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
        GroupDetailState$Loaded(:final group, :final tests) => _LoadedBody(
            groupTitle: group.title,
            tests: tests,
            viewModel: viewModel,
            onBackPressed: viewModel.onBackPressed,
          ),
      },
    );
  }
}

class _LoadedBody extends StatelessWidget {
  final String groupTitle;
  final List<TestEntity> tests;
  final IGroupDetailViewModel viewModel;
  final VoidCallback onBackPressed;

  const _LoadedBody({
    required this.groupTitle,
    required this.tests,
    required this.viewModel,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (tests.isEmpty) {
      return Column(
        children: [
          _GroupDetailHeader(
            groupTitle: groupTitle,
            onBackPressed: onBackPressed,
            viewModel: viewModel,
          ),
          const Expanded(child: _EmptyTestsPlaceholder()),
        ],
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _GroupDetailHeader(
            groupTitle: groupTitle,
            onBackPressed: onBackPressed,
            viewModel: viewModel,
          ),
        ),
        SliverToBoxAdapter(
          child: _MixupSettingsSection(viewModel: viewModel),
        ),
        _TestListSliver(tests: tests, viewModel: viewModel),
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 80,
          ),
        ),
      ],
    );
  }
}

class _GroupDetailHeader extends StatelessWidget {
  final String groupTitle;
  final VoidCallback onBackPressed;
  final IGroupDetailViewModel viewModel;

  const _GroupDetailHeader({
    required this.groupTitle,
    required this.onBackPressed,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return AppPageHeader.withBack(
      title: groupTitle,
      onBackPressed: onBackPressed,
      onTitlePressed: viewModel.onEditTitlePressed,
    );
  }
}

class _EmptyTestsPlaceholder extends StatelessWidget {
  const _EmptyTestsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.groupDetailEmptyMessage,
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

class _MixupSettingsSection extends StatelessWidget {
  final IGroupDetailViewModel viewModel;

  const _MixupSettingsSection({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MixupBloc, MixupState>(
      builder: (context, mixupState) {
        final showStreak = mixupState.enabled &&
            mixupState.algorithm == MixupAlgorithm.scoring;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Карточка настроек подмешивания.
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: ContentCard(
                type: ContentCardType.medium,
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _MixupToggle(
                      value: mixupState.enabled,
                      onChanged: (value) =>
                          viewModel.onMixupChanged(value: value),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      alignment: Alignment.topCenter,
                      child: mixupState.enabled
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Divider(
                                  height: 1,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                _MixupAlgorithmSelector(
                                  algorithm: mixupState.algorithm,
                                  onChanged: (algorithm) =>
                                      viewModel.onMixupAlgorithmChanged(
                                    algorithm: algorithm,
                                  ),
                                ),
                                _MixupCountSlider(
                                  min: mixupState.mixupMin,
                                  max: mixupState.mixupMax,
                                  onChanged: viewModel.onMixupRangeChanged,
                                ),
                              ],
                            )
                          : const SizedBox(width: double.infinity),
                    ),
                  ],
                ),
              ),
            ),
            // Отдельный блок коэффициентов streak (только для «Умного»).
            AnimatedSize(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastEaseInToSlowEaseOut,
              alignment: Alignment.topCenter,
              child: showStreak
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: ContentCard(
                        type: ContentCardType.medium,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: _StreakCoefficientsEditor(viewModel: viewModel),
                      ),
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        );
      },
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
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final test = tests[index];
          return _TestListItem(
            test: test,
            onTap: () => viewModel.onTestTapped(test),
            onLongPress: () => viewModel.onTestLongPressed(test),
            onConfirmDismiss: () => viewModel.confirmTestRemove(test),
            onDismissed: () => viewModel.onTestRemoveConfirmed(test),
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
  final Future<bool?> Function() onConfirmDismiss;
  final VoidCallback onDismissed;

  const _TestListItem({
    required this.test,
    required this.onTap,
    required this.onLongPress,
    required this.onConfirmDismiss,
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
      confirmDismiss: (_) => onConfirmDismiss(),
      onDismissed: (_) => onDismissed(),
      child: ScalePressable(
        onTap: onTap,
        onLongPress: onLongPress,
        child: AppItemCard(
          icon: Icons.auto_stories_outlined,
          title: test.title,
          subtitle: test.description,
          caption: context.l10n.groupDetailQuestionCount(test.questionCount),
        ),
      ),
    );
  }
}

class _MixupCountSlider extends StatelessWidget {
  final int min;
  final int max;
  final void Function({required int min, required int max}) onChanged;

  const _MixupCountSlider({
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.groupDetailMixupCountLabel,
                style: theme.textTheme.titleMedium,
              ),
              Text(
                '$min–$max',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          AppRangeSlider(
            values: RangeValues(min.toDouble(), max.toDouble()),
            min: 1,
            max: 20,
            divisions: 19,
            labels: RangeLabels('$min', '$max'),
            onChanged: (values) {
              onChanged(
                min: values.start.round(),
                max: values.end.round(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MixupAlgorithmSelector extends StatelessWidget {
  final MixupAlgorithm algorithm;
  final ValueChanged<MixupAlgorithm> onChanged;

  const _MixupAlgorithmSelector({
    required this.algorithm,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final classicText = context.l10n.groupDetailMixupAlgorithmClassic;
    final scoringText = context.l10n.groupDetailMixupAlgorithmScoring;
    final currentText =
        algorithm == MixupAlgorithm.classic ? classicText : scoringText;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.l10n.groupDetailMixupAlgorithm,
              style: theme.textTheme.titleMedium,
            ),
          ),
          PopupMenuButton<MixupAlgorithm>(
            initialValue: algorithm,
            onSelected: onChanged,
            position: PopupMenuPosition.under,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: MixupAlgorithm.classic,
                child: Text(classicText),
              ),
              PopupMenuItem(
                value: MixupAlgorithm.scoring,
                child: Text(scoringText),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppDimens.radius8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentText,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakCoefficientsEditor extends StatelessWidget {
  final IGroupDetailViewModel viewModel;

  const _StreakCoefficientsEditor({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final labelStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        );
    return AppDropdown(
      title: context.l10n.groupDetailStreakCoefficients,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(AppDimens.radius12),
        ),
        child: Icon(
          Icons.local_fire_department,
          size: 22,
          color: colorScheme.onTertiaryContainer,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.groupDetailStreakNegativeBonus,
                  style: labelStyle,
                ),
                const Height(4),
                SizedBox(
                  width: 56,
                  child: TextField(
                    controller: viewModel.streakNegativeBonusController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                    ),
                    onEditingComplete:
                        viewModel.onStreakCoefficientsSubmitted,
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                      viewModel.onStreakCoefficientsSubmitted();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.groupDetailStreakPositivePenalty,
                  style: labelStyle,
                ),
                const Height(4),
                SizedBox(
                  width: 56,
                  child: TextField(
                    controller: viewModel.streakPositivePenaltyController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                    ),
                    onEditingComplete:
                        viewModel.onStreakCoefficientsSubmitted,
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                      viewModel.onStreakCoefficientsSubmitted();
                    },
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: viewModel.onStreakCoefficientsReset,
            icon: const Icon(Icons.restart_alt, size: 20),
            tooltip: context.l10n.groupDetailStreakReset,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 36,
              minHeight: 36,
            ),
          ),
        ],
      ),
    );
  }
}

class _MixupToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _MixupToggle({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.groupDetailMixup,
                  style: theme.textTheme.titleMedium,
                ),
                const Height(3),
                Text(
                  context.l10n.groupDetailMixupDescription,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          AppSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
