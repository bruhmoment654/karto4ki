import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/groups_list/domain/bloc/groups_list_bloc.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/presentation/groups_list_view.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';

/// Экран списка групп.
class GroupsListScreen extends StatefulWidget {
  const GroupsListScreen({super.key});

  @override
  State<GroupsListScreen> createState() => _GroupsListScreenState();
}

class _GroupsListScreenState extends State<GroupsListScreen>
    implements IGroupsListViewModel {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsListBloc, GroupsListState>(
      builder: (context, state) {
        return GroupsListView(viewModel: this, state: state);
      },
    );
  }

  @override
  void onAddGroupPressed() {
    _showAddGroupDialog();
  }

  @override
  void onGroupTapped(TestGroupEntity group) {
    context.router.push(GroupDetailRoute(groupId: int.parse(group.id)));
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
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: context.l10n.groupsListNewGroupNameHint,
          ),
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
                      groupId: int.parse(group.id),
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
  void onAddGroupPressed();

  void onGroupTapped(TestGroupEntity group);

  void onGroupDeletePressed(TestGroupEntity group);

  void onGroupLongPressed(TestGroupEntity group);
}
