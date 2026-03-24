import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/feature/group_detail/domain/bloc/group_detail_bloc.dart';
import 'package:quizzerg/feature/group_detail/presentation/group_detail_screen.dart';
import 'package:quizzerg/feature/mixup/domain/bloc/mixup_bloc.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/buttons/app_glow_button.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/slider/app_range_slider.dart';
import 'package:quizzerg/uikit/switch/app_switch.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

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
            onBackPressed: () => Navigator.of(context).pop(),
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
          AppPageHeader.withBack(
            title: groupTitle,
            onBackPressed: onBackPressed,
            onTitlePressed: viewModel.onEditTitlePressed,
            action: AppGlowButton(
              onPressed: viewModel.onAddTestPressed,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 6),
                  Text('Новый тест'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.l10n.groupDetailEmptyMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
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
          ),
        ],
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AppPageHeader.withBack(
            title: groupTitle,
            onBackPressed: onBackPressed,
            onTitlePressed: viewModel.onEditTitlePressed,
            action: AppGlowButton(
              onPressed: viewModel.onAddTestPressed,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 6),
                  Text('Новый тест'),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<MixupBloc, MixupState>(
            builder: (context, mixupState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MixupToggle(
                    value: mixupState.enabled,
                    onChanged: (value) =>
                        viewModel.onMixupChanged(value: value),
                  ),
                  AnimatedCrossFade(
                    firstChild: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _MixupAlgorithmSelector(
                          algorithm: mixupState.algorithm,
                          onChanged: (algorithm) =>
                              viewModel.onMixupAlgorithmChanged(
                            algorithm: algorithm,
                          ),
                        ),
                        _MixupRangeSlider(
                          min: mixupState.mixupMin,
                          max: mixupState.mixupMax,
                          onChanged: viewModel.onMixupRangeChanged,
                        ),
                      ],
                    ),
                    firstCurve: Curves.easeOut,
                    sizeCurve: Curves.fastEaseInToSlowEaseOut,
                    secondChild: const SizedBox(width: double.infinity),
                    crossFadeState: mixupState.enabled
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 200),
                  ),
                ],
              );
            },
          ),
        ),
        SliverPadding(
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
                onRemove: () => viewModel.onTestRemovePressed(test),
              );
            },
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    );
  }
}

class _TestListItem extends StatelessWidget {
  final TestEntity test;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onRemove;

  const _TestListItem({
    required this.test,
    required this.onTap,
    required this.onLongPress,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dismissible(
      key: ValueKey(test.id),
      direction: DismissDirection.endToStart,
      background: Icon(
        Icons.remove_circle_outline,
        color: colorScheme.onSurface,
      ),
      confirmDismiss: (direction) async {
        return showDialog<bool>(
          context: context,
          builder: (dialogContext) => AppDialog(
            title: Text(context.l10n.groupDetailRemoveTestTitle),
            content: Text(
              context.l10n.groupDetailRemoveTestMessage(test.title),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(context.l10n.groupDetailRemoveTestCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(context.l10n.groupDetailRemoveTestConfirm),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onRemove(),
      child: ScalePressable(
        onTap: onTap,
        onLongPress: onLongPress,
        child: ContentCard(
          borderColor: colorScheme.border.withValues(alpha: 0.35),
          borderWidth: 0.5,
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.auto_stories_outlined,
                  size: 20,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      test.title,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.foreground,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (test.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        test.description!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.mutedForeground,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MixupRangeSlider extends StatelessWidget {
  final int min;
  final int max;
  final void Function({required int min, required int max}) onChanged;

  const _MixupRangeSlider({
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.groupDetailMixupRange(min, max),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            context.l10n.groupDetailMixupAlgorithm,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const Spacer(),
          SegmentedButton<MixupAlgorithm>(
            segments: [
              ButtonSegment(
                value: MixupAlgorithm.classic,
                label: Text(context.l10n.groupDetailMixupAlgorithmClassic),
              ),
              ButtonSegment(
                value: MixupAlgorithm.scoring,
                label: Text(context.l10n.groupDetailMixupAlgorithmScoring),
              ),
            ],
            selected: {algorithm},
            onSelectionChanged: (selected) => onChanged(selected.first),
            showSelectedIcon: false,
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.groupDetailMixup,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  context.l10n.groupDetailMixupDescription,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          AppSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
