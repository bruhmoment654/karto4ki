import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/groups_list/domain/bloc/groups_list_bloc.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/presentation/groups_list_screen.dart';
import 'package:quizzerg/feature/groups_list/presentation/widget/active_session_card.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/active_session_bloc.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
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
      floatingActionButton: AppFloatingActionButton(
        label: 'Новая группа',
        onPressed: viewModel.onAddGroupPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
        const SliverToBoxAdapter(
          child: AppPageHeader(
            title: 'Мои группы',
            subtitle: 'Группы тестов для обучения по карточкам',
          ),
        ),
        const _ActiveSessionSliver(),
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


class _ActiveSessionSliver extends StatefulWidget {
  const _ActiveSessionSliver();

  @override
  State<_ActiveSessionSliver> createState() => _ActiveSessionSliverState();
}

class _ActiveSessionSliverState extends State<_ActiveSessionSliver> {
  ActiveTestSession? _lastSession;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ActiveSessionBloc, ActiveSessionState>(
        builder: (context, state) {
          if (state is ActiveSessionState$Available) {
            _lastSession = state.session;
          }

          final session = _lastSession;
          final isVisible = state is ActiveSessionState$Available;

          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            sizeCurve: Curves.easeInOut,
            crossFadeState: isVisible
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: session == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: ActiveSessionCard(
                      session: session,
                      onResume: () => context.router.push(
                        TinderTestRoute(
                          testId: int.parse(session.session.testId),
                          swapSides: session.params.swapSides,
                          answerIndex: session.params.answerIndex,
                          mixup: session.params.mixup,
                          mixupMin: session.params.mixupMin,
                          mixupMax: session.params.mixupMax,
                          resume: true,
                        ),
                      ),
                      onDismiss: () => context
                          .read<ActiveSessionBloc>()
                          .add(const ActiveSessionEvent.cleared()),
                    ),
                  ),
            secondChild: const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

/// Пул иконок для карточек групп (Material Symbols), выбирается по индексу.
const _groupIcons = <IconData>[
  Icons.translate,
  Icons.bolt,
  Icons.menu_book,
  Icons.auto_stories,
  Icons.science_outlined,
  Icons.calculate_outlined,
];

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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    // Тональный контейнер из seed-пула — реагирует на смену seed-цвета.
    final pool = colorScheme.groupCardPool;
    final (background, foreground) = pool[index % pool.length];
    final icon = _groupIcons[index % _groupIcons.length];

    return ScalePressable(
      onTap: onTap,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: ContentCard(
          backgroundColor: background,
          borderRadius: BorderRadius.circular(AppDimens.radius28),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: foreground.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(AppDimens.radius16),
                    ),
                    child: Icon(icon, size: 28, color: foreground),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right,
                    size: 26,
                    color: foreground.withValues(alpha: 0.55),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                group.title,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.fromLTRB(11, 5, 14, 5),
                decoration: BoxDecoration(
                  color: foreground.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppDimens.radius8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu_book, size: 16, color: foreground),
                    const SizedBox(width: 7),
                    Text(
                      context.l10n.groupsListTestCount(group.testCount),
                      style: textTheme.labelLarge?.copyWith(
                        color: foreground,
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
