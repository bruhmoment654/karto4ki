import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:material_3_expressive/material_3_expressive.dart'
    show M3EIcons;
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/group_detail/presentation/widget/group_mixup_sheet.dart';
import 'package:quizzerg/feature/groups_list/domain/bloc/groups_list_bloc.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/presentation/groups_list_view.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_dialog.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/active_session_bloc.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_action_sheet.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/dialogs/dialog_controller.dart';
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
  Future<void> onGroupLongPressed(TestGroupEntity group) async {
    final l10n = context.l10n;
    final accuracy = group.progress.accuracy;

    final action = await AppActionSheet.show<_GroupAction>(
      context,
      title: group.title,
      subtitle: [
        l10n.groupsListTestCount(group.testCount),
        if (accuracy != null) l10n.actionSheetAccuracy((accuracy * 100).round()),
      ].join(' · '),
      items: [
        AppActionSheetItem(
          icon: M3EIcons.edit_outlined,
          label: l10n.groupsListActionRename,
          value: _GroupAction.rename,
        ),
        AppActionSheetItem(
          icon: M3EIcons.tune_rounded,
          label: l10n.groupsListActionSettings,
          value: _GroupAction.settings,
        ),
        AppActionSheetItem(
          icon: M3EIcons.delete_outline_rounded,
          label: l10n.groupsListActionDelete,
          value: _GroupAction.delete,
          isDestructive: true,
        ),
      ],
    );
    if (!mounted) return;

    switch (action) {
      case _GroupAction.rename:
        _showRenameGroupDialog(group);
      case _GroupAction.settings:
        _showMixupSettings();
      case _GroupAction.delete:
        _showDeleteGroupDialog(group);
      case null:
        break;
    }
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

  void _showRenameGroupDialog(TestGroupEntity group) {
    final titleController = TextEditingController(text: group.title);

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(context.l10n.groupDetailEditTitleDialogTitle),
        content: Karto4kiTextField(
          controller: titleController,
          labelText: context.l10n.groupDetailEditTitleHint,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.groupDetailEditTitleCancel),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty && title != group.title) {
                context.read<GroupsListBloc>().add(
                      GroupsListEvent.groupRenamed(
                        groupId: group.id,
                        title: title,
                      ),
                    );
              }
              Navigator.of(dialogContext).pop();
            },
            child: Text(context.l10n.groupDetailEditTitleSave),
          ),
        ],
      ),
    );
  }

  /// Настройки подмешивания — общие для всех групп, та же шторка, что по
  /// кнопке tune в деталке группы.
  void _showMixupSettings() {
    final mixupBloc = context.read<IAppScope>().mixupBloc;
    DialogController.showBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      builder: (_) => BlocProvider.value(
        value: mixupBloc,
        child: const GroupMixupSheet(),
      ),
    );
  }

  void _showDeleteGroupDialog(TestGroupEntity group) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        icon: Icon(M3EIcons.delete_outline_rounded, color: colorScheme.error),
        title: Text(context.l10n.groupsListDeleteGroupTitle(group.title)),
        content: Text(context.l10n.groupsListDeleteGroupBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.groupsListDeleteDialogCancel),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: colorScheme.error),
            onPressed: () {
              context.read<GroupsListBloc>().add(
                    GroupsListEvent.groupDeleted(groupId: group.id),
                  );
              Navigator.of(dialogContext).pop();
            },
            child: Text(context.l10n.groupsListDeleteDialogConfirm),
          ),
        ],
      ),
    );
  }
}

/// Действия шторки группы по долгому нажатию.
enum _GroupAction { rename, settings, delete }

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
