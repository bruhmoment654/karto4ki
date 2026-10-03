import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/groups_list/domain/bloc/groups_list_bloc.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/presentation/groups_list_view.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_dialog.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/active_session_bloc.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/fields/karto4ki_text_field.dart';

/// Экран списка групп.
class GroupsListScreen extends StatefulWidget {
  const GroupsListScreen({super.key});

  @override
  State<GroupsListScreen> createState() => _GroupsListScreenState();
}

class _GroupsListScreenState extends State<GroupsListScreen>
    implements IGroupsListViewModel {
  @override
  StateStreamable<GroupsListState> get groupsListState =>
      context.read<GroupsListBloc>();

  @override
  StateStreamable<SyncState> get syncState => context.read<SyncBloc>();

  @override
  StateStreamable<ActiveSessionState> get activeSessionState =>
      context.read<ActiveSessionBloc>();

  @override
  Widget build(BuildContext context) {
    return GroupsListView(viewModel: this);
  }

  @override
  void onSyncBadgeTap() {
    showSyncStatusDialog(
      context: context,
      syncState: context.read<SyncBloc>(),
      onSignInTap: onSignInTap,
      onSyncTap: () => context.read<SyncBloc>().add(
            const SyncEvent.requested(),
          ),
    );
  }

  @override
  void onSignInTap() {
    context.router.root.push(const AuthRoute());
  }

  @override
  void onSessionResumeTap(ActiveTestSession session) {
    context.router.push(
      TinderTestRoute(
        testId: session.session.testId,
        swapSides: session.params.swapSides,
        answerIndex: session.params.answerIndex,
        mixup: session.params.mixup,
        mixupMin: session.params.mixupMin,
        mixupMax: session.params.mixupMax,
        resume: true,
        groupId: session.params.groupId,
      ),
    );
  }

  @override
  void onSessionDismissTap() {
    context.read<ActiveSessionBloc>().add(const ActiveSessionEvent.cleared());
  }

  @override
  void onAddGroupPressed() {
    _showAddGroupDialog();
  }

  @override
  void onGroupTapped(TestGroupEntity group) {
    context.router.push(GroupDetailRoute(groupId: group.id));
  }

  @override
  void onGroupDeletePressed(TestGroupEntity group) {
    _showDeleteGroupDialog(group);
  }

  @override
  void onGroupLongPressed(TestGroupEntity group) {
    _showDeleteGroupDialog(group);
  }

  void _showAddGroupDialog() {
    final titleController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(context.l10n.groupsListNewGroupDialogTitle),
        content: Karto4kiTextField(
          controller: titleController,
          labelText: context.l10n.groupsListNewGroupNameHint,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.groupsListNewGroupCancel),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                context.read<GroupsListBloc>().add(
                      GroupsListEvent.groupAdded(title: title),
                    );
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(context.l10n.groupsListNewGroupCreate),
          ),
        ],
      ),
    );
  }

  void _showDeleteGroupDialog(TestGroupEntity group) {
    showDialog<bool>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(context.l10n.groupsListDeleteDialogTitle),
        content: Text(
          context.l10n.groupsListDeleteDialogMessage(group.title),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(context.l10n.groupsListDeleteDialogCancel),
          ),
          TextButton(
            onPressed: () {
              context.read<GroupsListBloc>().add(
                    GroupsListEvent.groupDeleted(
                      groupId: group.id,
                    ),
                  );
              Navigator.of(dialogContext).pop(true);
            },
            child: Text(context.l10n.groupsListDeleteDialogConfirm),
          ),
        ],
      ),
    );
  }
}

/// ViewModel интерфейс для экрана списка групп.
abstract interface class IGroupsListViewModel {
  /// Список групп: загрузка, данные, ошибка.
  StateStreamable<GroupsListState> get groupsListState;

  /// Состояние синхронизации: индикатор в шапке, прогресс и баннер входа.
  StateStreamable<SyncState> get syncState;

  /// Незавершённая сессия прохождения теста.
  StateStreamable<ActiveSessionState> get activeSessionState;

  /// Тап по индикатору синхронизации в шапке.
  void onSyncBadgeTap();

  /// Тап по «Войти» в баннере протухшей сессии.
  void onSignInTap();

  /// Продолжить незавершённую сессию.
  void onSessionResumeTap(ActiveTestSession session);

  /// Убрать карточку незавершённой сессии.
  void onSessionDismissTap();

  void onAddGroupPressed();

  void onGroupTapped(TestGroupEntity group);

  void onGroupDeletePressed(TestGroupEntity group);

  void onGroupLongPressed(TestGroupEntity group);
}
