import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/group_detail/domain/bloc/group_detail_bloc.dart';
import 'package:quizzerg/feature/group_detail/presentation/group_detail_view.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';

/// Экран деталки группы.
class GroupDetailScreen extends StatefulWidget {
  const GroupDetailScreen({super.key});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen>
    implements IGroupDetailViewModel {
  bool _mixup = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDetailBloc, GroupDetailState>(
      builder: (context, state) {
        return GroupDetailView(
          viewModel: this,
          state: state,
          mixup: _mixup,
        );
      },
    );
  }

  @override
  void onAddTestPressed() {
    _showAddTestDialog();
  }

  @override
  void onTestTapped(TestEntity test) {
    context.router.push(
      TestDetailRoute(testId: int.parse(test.id), mixup: _mixup),
    );
  }

  @override
  void onMixupChanged({required bool value}) {
    setState(() => _mixup = value);
  }

  @override
  void onTestLongPressed(TestEntity test) {
    _showTestActionsDialog(test);
  }

  @override
  void onTestRemovePressed(TestEntity test) {
    _showRemoveTestDialog(test);
  }

  @override
  void onEditTitlePressed() {
    final state = context.read<GroupDetailBloc>().state;
    if (state is GroupDetailState$Loaded) {
      _showEditTitleDialog(state.group.title);
    }
  }

  void _showAddTestDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(context.l10n.groupDetailNewTestDialogTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: context.l10n.groupDetailNewTestNameHint,
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: context.l10n.groupDetailNewTestDescriptionHint,
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.groupDetailNewTestCancel),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                context.read<GroupDetailBloc>().add(
                      GroupDetailEvent.testAdded(
                        title: title,
                        description: descriptionController.text.trim().isEmpty
                            ? null
                            : descriptionController.text.trim(),
                      ),
                    );
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(context.l10n.groupDetailNewTestCreate),
          ),
        ],
      ),
    );
  }

  Future<void> _showRemoveTestDialog(TestEntity test) async {
    final scope = context.read<IAppScope>();
    final bloc = context.read<GroupDetailBloc>();
    final countResult =
        await scope.groupDetailRepository.getGroupCountForTest(
      int.parse(test.id),
    );

    if (!mounted) return;

    final isLastGroup = countResult.dataOrNull == 1;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(
          isLastGroup
              ? context.l10n.groupDetailRemoveTestLastGroupTitle
              : context.l10n.groupDetailRemoveTestTitle,
        ),
        content: Text(
          isLastGroup
              ? context.l10n
                  .groupDetailRemoveTestLastGroupMessage(test.title)
              : context.l10n.groupDetailRemoveTestMessage(test.title),
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

    if ((confirmed ?? false) && mounted) {
      bloc.add(
        GroupDetailEvent.testRemoved(testId: int.parse(test.id)),
      );
    }
  }

  void _showTestActionsDialog(TestEntity test) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(context.l10n.groupDetailTestActionsTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.play_arrow_rounded),
              title: Text(context.l10n.groupDetailTestActionsOpen),
              onTap: () {
                Navigator.of(dialogContext).pop();
                onTestTapped(test);
              },
            ),
            ListTile(
              leading: const Icon(Icons.playlist_add),
              title: Text(context.l10n.groupDetailTestActionsAddToGroup),
              onTap: () {
                Navigator.of(dialogContext).pop();
                _showAddToGroupDialog(test);
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove_circle_outline),
              title: Text(context.l10n.groupDetailTestActionsRemove),
              onTap: () {
                Navigator.of(dialogContext).pop();
                onTestRemovePressed(test);
              },
            ),
          ],
        ),
        actions: const [],
      ),
    );
  }

  Future<void> _showAddToGroupDialog(TestEntity test) async {
    final bloc = context.read<GroupDetailBloc>();
    final state = bloc.state;
    if (state is! GroupDetailState$Loaded) return;

    final currentGroupId = int.parse(state.group.id);
    final testId = int.parse(test.id);

    final repo = context.read<IAppScope>().groupDetailRepository;
    final groupsResult = await repo.getAllGroups();
    final groupIdsResult = await repo.getGroupIdsForTest(testId);

    if (!mounted) return;

    final allGroups = groupsResult.dataOrNull;
    final currentGroupIds = groupIdsResult.dataOrNull;
    if (allGroups == null || currentGroupIds == null) return;

    final selectedIds = Set<int>.from(currentGroupIds);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AppDialog(
          title: Text(this.context.l10n.groupDetailAddToGroupTitle),
          content: allGroups.length <= 1
              ? Text(this.context.l10n.groupDetailAddToGroupEmpty)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final group in allGroups)
                      CheckboxListTile(
                        value: selectedIds.contains(int.parse(group.id)),
                        onChanged: int.parse(group.id) == currentGroupId
                            ? null
                            : (value) {
                                setDialogState(() {
                                  if (value ?? false) {
                                    selectedIds.add(int.parse(group.id));
                                  } else {
                                    selectedIds.remove(int.parse(group.id));
                                  }
                                });
                              },
                        title: Text(group.title),
                      ),
                  ],
                ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(this.context.l10n.groupDetailAddToGroupCancel),
            ),
            if (allGroups.length > 1)
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  bloc.add(GroupDetailEvent.testGroupsUpdated(
                    testId: testId,
                    groupIds: selectedIds.toList(),
                  ));
                },
                child: Text(this.context.l10n.groupDetailAddToGroupSave),
              ),
          ],
        ),
      ),
    );
  }

  void _showEditTitleDialog(String currentTitle) {
    final titleController = TextEditingController(text: currentTitle);

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(context.l10n.groupDetailEditTitleDialogTitle),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: context.l10n.groupDetailEditTitleHint,
          ),
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
              if (title.isNotEmpty) {
                context.read<GroupDetailBloc>().add(
                      GroupDetailEvent.titleUpdated(title: title),
                    );
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(context.l10n.groupDetailEditTitleSave),
          ),
        ],
      ),
    );
  }
}

/// ViewModel интерфейс для экрана деталки группы.
abstract interface class IGroupDetailViewModel {
  void onAddTestPressed();

  void onTestTapped(TestEntity test);

  void onTestLongPressed(TestEntity test);

  void onTestRemovePressed(TestEntity test);

  void onEditTitlePressed();

  void onMixupChanged({required bool value});
}
