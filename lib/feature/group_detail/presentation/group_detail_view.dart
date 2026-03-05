import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/feature/group_detail/domain/bloc/group_detail_bloc.dart';
import 'package:quizzerg/feature/group_detail/presentation/group_detail_screen.dart';
import 'package:quizzerg/feature/mixup/domain/bloc/mixup_bloc.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
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
    final titleText = switch (state) {
      GroupDetailState$Loaded(:final group) => group.title.toUpperCase(),
      _ => context.l10n.groupDetailLoadingTitle,
    };

    return AppScaffold(
      useSafeArea: false,
      appBar: DefaultAppBar(
        title: Text(titleText),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        actions: [
          if (state is GroupDetailState$Loaded)
            IconButton(
              onPressed: viewModel.onEditTitlePressed,
              icon: const Icon(Icons.edit, color: Colors.white),
            ),
        ],
      ),
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
        GroupDetailState$Loaded(:final tests) => tests.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.groupDetailEmptyMessage,
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
              )
            : Column(
                children: [
                  BlocBuilder<MixupBloc, MixupState>(
                    builder: (context, mixupState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _MixupToggle(
                            value: mixupState.enabled,
                            onChanged: (v) =>
                                viewModel.onMixupChanged(value: v),
                          ),
                          if (mixupState.enabled)
                            _MixupRangeSlider(
                              min: mixupState.mixupMin,
                              max: mixupState.mixupMax,
                              onChanged: viewModel.onMixupRangeChanged,
                            ),
                        ],
                      );
                    },
                  ),
                  Expanded(
                    child: _TestsList(
                      tests: tests,
                      viewModel: viewModel,
                    ),
                  ),
                ],
              ),
      },
      floatingActionButton: state is GroupDetailState$Loaded
          ? AppFloatingActionButton(
              label: context.l10n.groupDetailAddTestFab,
              onPressed: viewModel.onAddTestPressed,
              icon: Icons.add,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _TestsList extends StatelessWidget {
  final List<TestEntity> tests;
  final IGroupDetailViewModel viewModel;

  const _TestsList({
    required this.tests,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: tests.length,
      itemBuilder: (context, index) {
        final test = tests[index];
        return _TestListItem(
          test: test,
          onTap: () => viewModel.onTestTapped(test),
          onLongPress: () => viewModel.onTestLongPressed(test),
          onRemove: () => viewModel.onTestRemovePressed(test),
        );
      },
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ScalePressable(
          onTap: onTap,
          onLongPress: onLongPress,
          child: ContentCard(
            elevation: 5,
            type: ContentCardType.smallWide,
            padding: EdgeInsets.zero,
            child: ListTile(
              title: Text(
                test.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: test.description != null
                  ? Text(
                      test.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : null,
              trailing: const Icon(Icons.chevron_right),
            ),
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
          RangeSlider(
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
