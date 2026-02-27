import 'package:flutter/material.dart';

import 'package:quizzerg/feature/groups_list/domain/bloc/groups_list_bloc.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/presentation/groups_list_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';

/// UI-слой экрана списка групп.
class GroupsListView extends StatelessWidget {
  final IGroupsListViewModel viewModel;
  final GroupsListState state;

  const GroupsListView({
    required this.viewModel,
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar(
        title: context.l10n.groupsListAppBarTitle,
      ),
      body: switch (state) {
        GroupsListState$Loading() => const Center(
            child: CircularProgressIndicator(),
          ),
        GroupsListState$Error(:final failure) => Center(
            child: Text(
              context.l10n.groupsListErrorMessage(
                failure.message ?? context.l10n.groupsListUnknownError,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        GroupsListState$Loaded(:final groups) => groups.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.groupsListEmptyMessage,
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
            : _GroupsGrid(
                groups: groups,
                viewModel: viewModel,
              ),
      },
      floatingActionButton: AppFloatingActionButton(
        label: context.l10n.groupsListAddGroupFab,
        onPressed: viewModel.onAddGroupPressed,
        icon: Icons.add,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _GroupsGrid extends StatelessWidget {
  final List<TestGroupEntity> groups;
  final IGroupsListViewModel viewModel;

  const _GroupsGrid({
    required this.groups,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return _GroupGridTile(
          group: group,
          onTap: () => viewModel.onGroupTapped(group),
          onLongPress: () => viewModel.onGroupLongPressed(group),
        );
      },
    );
  }
}

class _GroupGridTile extends StatelessWidget {
  final TestGroupEntity group;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _GroupGridTile({
    required this.group,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ScalePressable(
      onTap: onTap,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: ContentCard(
          elevation: 5,
          type: ContentCardType.medium,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  group.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  context.l10n.groupsListTestCount(group.testCount),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
