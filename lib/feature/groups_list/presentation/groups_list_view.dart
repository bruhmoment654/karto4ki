import 'package:flutter/material.dart';

import 'package:quizzerg/feature/groups_list/domain/bloc/groups_list_bloc.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/presentation/groups_list_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/buttons/app_glow_button.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

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
        GroupsListState$Loaded(:final groups) => _GroupsBody(
            groups: groups,
            viewModel: viewModel,
          ),
      },
    );
  }
}

class _GroupsBody extends StatelessWidget {
  final List<TestGroupEntity> groups;
  final IGroupsListViewModel viewModel;

  const _GroupsBody({
    required this.groups,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AppPageHeader(
            title: 'Мои группы',
            subtitle: 'Группы тестов для обучения по карточкам',
            action: AppGlowButton(
              onPressed: viewModel.onAddGroupPressed,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 6),
                  Text('Новая группа'),
                ],
              ),
            ),
          ),
        ),
        if (groups.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.l10n.groupsListEmptyMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
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
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemCount: groups.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final group = groups[index];
                return _GroupListTile(
                  group: group,
                  index: index,
                  onTap: () => viewModel.onGroupTapped(group),
                  onLongPress: () => viewModel.onGroupLongPressed(group),
                );
              },
            ),
          ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    );
  }
}


class _GroupListTile extends StatelessWidget {
  final TestGroupEntity group;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _GroupListTile({
    required this.group,
    required this.index,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tint = _groupPalette(isDark)[index % _groupPalette(isDark).length];
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ScalePressable(
      onTap: onTap,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: ContentCard(
          backgroundColor: tint.background,
          borderColor: tint.border.withValues(alpha: 0.35),
          borderWidth: 0.5,
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: tint.iconBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    tint.emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                group.title,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.foreground,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tint.border.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_stories_outlined,
                      size: 14,
                      color: tint.border,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      context.l10n.groupsListTestCount(group.testCount),
                      style: textTheme.labelSmall?.copyWith(
                        color: tint.border,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

class _GroupTint {
  final Color background;
  final Color border;
  final Color iconBackground;
  final String emoji;

  const _GroupTint({
    required this.background,
    required this.border,
    required this.iconBackground,
    required this.emoji,
  });
}

List<_GroupTint> _groupPalette(bool isDark) => isDark ? _darkPalette : _lightPalette;

const _darkPalette = [
  _GroupTint(
    background: Color(0xFF1A1A35),
    border: Color(0xFF7B6FD4),
    iconBackground: Color(0xFF2A2650),
    emoji: '🧬',
  ),
  _GroupTint(
    background: Color(0xFF251E15),
    border: Color(0xFFC4873A),
    iconBackground: Color(0xFF3A2E1E),
    emoji: '⚡',
  ),
  _GroupTint(
    background: Color(0xFF152520),
    border: Color(0xFF3DAA7A),
    iconBackground: Color(0xFF1E3A30),
    emoji: '🌍',
  ),
  _GroupTint(
    background: Color(0xFF251520),
    border: Color(0xFFC44E7A),
    iconBackground: Color(0xFF3A1E30),
    emoji: '🎨',
  ),
  _GroupTint(
    background: Color(0xFF152535),
    border: Color(0xFF4A8AC4),
    iconBackground: Color(0xFF1E3050),
    emoji: '📐',
  ),
  _GroupTint(
    background: Color(0xFF252015),
    border: Color(0xFFB8A03A),
    iconBackground: Color(0xFF3A351E),
    emoji: '📚',
  ),
];

const _lightPalette = [
  _GroupTint(
    background: Color(0xFFF0EEFA),
    border: Color(0xFF8B7FE8),
    iconBackground: Color(0xFFE0DCFF),
    emoji: '🧬',
  ),
  _GroupTint(
    background: Color(0xFFFAF0E6),
    border: Color(0xFFD4974A),
    iconBackground: Color(0xFFF5E0C5),
    emoji: '⚡',
  ),
  _GroupTint(
    background: Color(0xFFE8F5F0),
    border: Color(0xFF4DBB8A),
    iconBackground: Color(0xFFD0F0E0),
    emoji: '🌍',
  ),
  _GroupTint(
    background: Color(0xFFFAE8F0),
    border: Color(0xFFD45E8A),
    iconBackground: Color(0xFFF5D0E0),
    emoji: '🎨',
  ),
  _GroupTint(
    background: Color(0xFFE8F0FA),
    border: Color(0xFF5A9AD4),
    iconBackground: Color(0xFFD0E5FF),
    emoji: '📐',
  ),
  _GroupTint(
    background: Color(0xFFFAF5E8),
    border: Color(0xFFC8B04A),
    iconBackground: Color(0xFFF0E8C5),
    emoji: '📚',
  ),
];
