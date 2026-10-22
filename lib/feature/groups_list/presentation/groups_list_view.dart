import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/feature/groups_list/domain/bloc/groups_list_bloc.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/presentation/groups_list_screen.dart';
import 'package:quizzerg/feature/groups_list/presentation/widget/active_session_card.dart';
import 'package:quizzerg/feature/groups_list/presentation/widget/group_card.dart';
import 'package:quizzerg/feature/groups_list/presentation/widget/groups_list_skeleton.dart';
import 'package:quizzerg/feature/sync/presentation/sync_reauth_banner.dart';
import 'package:quizzerg/feature/sync/presentation/widget/sync_status_badge.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/active_session_bloc.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/app_page_header.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/empty_state/app_empty_state.dart';
import 'package:quizzerg/uikit/motion/app_animated_switcher.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/motion/staggered_appear.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/sliver_height.dart';

/// UI-слой экрана списка групп.
class GroupsListView extends StatelessWidget {
  final IGroupsListViewModel viewModel;

  const GroupsListView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<GroupsListState>(
      bloc: viewModel.groupsListState,
      builder: (context, state) => AppScaffold(
        // Пока групп нет, создать первую предлагает кнопка в пустом
        // состоянии — FAB рядом с ней дублировал бы действие.
        floatingActionButton: AppFloatingActionButton(
          label: context.l10n.groupsListAddGroupFab,
          onPressed: viewModel.onAddGroupPressed,
          isVisible: switch (state) {
            GroupsListState$Loading() => false,
            GroupsListState$Error() => true,
            GroupsListState$Loaded(:final groups) => groups.isNotEmpty,
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // Скелетон → список: если сплеш успел уйти, а данные ещё не пришли,
        // пользователь видит каркас экрана, а не пустоту. Список встаёт
        // поверх сразу (карточки сами проявляются каскадом), скелетон гаснет
        // под ним — без провала посередине смены.
        body: AppAnimatedSwitcher(
          transition: AppSwitcherTransition.fadeOutBehind,
          child: switch (state) {
            GroupsListState$Loading() => _GroupsSkeletonBody(
                key: const ValueKey('groups_loading'),
                viewModel: viewModel,
              ),
            GroupsListState$Error(:final failure) => _GroupsErrorBody(
                key: const ValueKey('groups_error'),
                failure: failure,
              ),
            GroupsListState$Loaded(:final groups) => _GroupsBody(
                key: const ValueKey('groups_loaded'),
                groups: groups,
                viewModel: viewModel,
              ),
          },
        ),
      ),
    );
  }
}

/// Шапка экрана — одинакова во всех состояниях, поэтому не «прыгает»
/// при переходе от скелетона к списку.
class _GroupsHeaderSliver extends StatelessWidget {
  final IGroupsListViewModel viewModel;

  const _GroupsHeaderSliver({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppPageHeader(
        title: context.l10n.groupsListTitle,
        subtitle: context.l10n.groupsListSubtitle,
        // У гостя индикатор возвращает пустоту, и шапка выглядит как раньше.
        action: SyncStatusBadge(
          syncState: viewModel.syncState,
          onTap: viewModel.onSyncBadgeTap,
        ),
      ),
    );
  }
}

/// Баннер «нужно войти заново» под шапкой.
class _ReauthBannerSliver extends StatelessWidget {
  final IGroupsListViewModel viewModel;

  const _ReauthBannerSliver({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SyncReauthBanner(
        syncState: viewModel.syncState,
        onSignInTap: viewModel.onSignInTap,
      ),
    );
  }
}

/// Состояние загрузки: шапка + карточки-заглушки.
class _GroupsSkeletonBody extends StatelessWidget {
  final IGroupsListViewModel viewModel;

  const _GroupsSkeletonBody({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        _GroupsHeaderSliver(viewModel: viewModel),
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(child: GroupsListSkeleton()),
        ),
        const SliverHeight(32),
      ],
    );
  }
}

class _GroupsErrorBody extends StatelessWidget {
  final Failure failure;

  const _GroupsErrorBody({required this.failure, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.l10n.groupsListErrorMessage(
          failure.message ?? context.l10n.groupsListUnknownError,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _GroupsBody extends StatelessWidget {
  final List<TestGroupEntity> groups;
  final IGroupsListViewModel viewModel;

  const _GroupsBody({
    required this.groups,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: CustomScrollView(
        slivers: [
          _GroupsHeaderSliver(viewModel: viewModel),
          _ReauthBannerSliver(viewModel: viewModel),
          _ActiveSessionSliver(viewModel: viewModel, groups: groups),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList.separated(
                itemCount: groups.length,
                separatorBuilder: (_, __) => const Height(16),
                itemBuilder: (context, index) {
                  final group = groups[index];
                  final tile = GroupCard(
                    group: group,
                    index: index,
                    onTap: () => viewModel.onGroupTapped(group),
                    onLongPress: () => viewModel.onGroupLongPressed(group),
                  );

                  return StaggeredAppear(position: index, child: tile);
                },
              ),
            ),
          // Без прокручиваемого тела: пустой экран не прокручивается и шапка
          // не уезжает. Со списком занимает только остаток экрана (обычно 0).
          SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyGroupsSwitcher(
              isEmpty: groups.isEmpty,
              onCreatePressed: viewModel.onAddGroupPressed,
            ),
          ),
          const SliverHeight(32),
        ],
      ),
    );
  }
}

class _ActiveSessionSliver extends StatefulWidget {
  final IGroupsListViewModel viewModel;

  /// Список групп — из него берётся название группы сессии: так видно
  /// переименование, а у удалённой группы строка просто пропадает.
  final List<TestGroupEntity> groups;

  const _ActiveSessionSliver({required this.viewModel, required this.groups});

  @override
  State<_ActiveSessionSliver> createState() => _ActiveSessionSliverState();
}

class _ActiveSessionSliverState extends State<_ActiveSessionSliver> {
  /// Последняя показанная сессия: пока карточка уезжает, ей всё ещё нужны
  /// данные, которых в состоянии уже нет.
  ActiveTestSession? _lastSession;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StateStreamableBuilder<ActiveSessionState>(
        bloc: widget.viewModel.activeSessionState,
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
                      groupTitle: _groupTitleOf(session),
                      onResume: () =>
                          widget.viewModel.onSessionResumeTap(session),
                      onDismiss: widget.viewModel.onSessionDismissTap,
                    ),
                  ),
            secondChild: const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  String? _groupTitleOf(ActiveTestSession session) {
    final groupId = session.params.groupId;
    if (groupId == null) return null;
    for (final group in widget.groups) {
      if (group.id == groupId) return group.title;
    }
    return null;
  }
}

/// Пустое состояние появляется и уходит вместе с кнопкой «Создать группу»:
/// масштаб с проявлением. Когда группы есть, на его месте пусто.
class _EmptyGroupsSwitcher extends StatelessWidget {
  static const _hiddenScale = 0.85;

  final bool isEmpty;
  final VoidCallback onCreatePressed;

  const _EmptyGroupsSwitcher({
    required this.isEmpty,
    required this.onCreatePressed,
  });

  @override
  Widget build(BuildContext context) {
    final isReduced = AppMotion.reduced(context);

    return AnimatedSwitcher(
      duration: isReduced ? Duration.zero : AppMotion.medium,
      reverseDuration: isReduced ? Duration.zero : AppMotion.fast,
      switchInCurve: AppMotion.spring,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation.drive(CurveTween(curve: const Interval(0, 0.6))),
        child: ScaleTransition(
          scale: animation.drive(Tween(begin: _hiddenScale, end: 1)),
          child: child,
        ),
      ),
      child: isEmpty
          ? _EmptyGroupsState(onCreatePressed: onCreatePressed)
          : const SizedBox.shrink(),
    );
  }
}

class _EmptyGroupsState extends StatelessWidget {
  final VoidCallback onCreatePressed;

  const _EmptyGroupsState({required this.onCreatePressed});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      title: context.l10n.groupsListEmptyTitle,
      message: context.l10n.groupsListEmptyMessage,
      primaryLabel: context.l10n.groupsListEmptyCreateButton,
      onPrimaryPressed: onCreatePressed,
    );
  }
}
