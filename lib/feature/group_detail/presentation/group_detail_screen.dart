import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show M3EIcons;

import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/group_detail/domain/bloc/group_detail_bloc.dart';
import 'package:quizzerg/feature/group_detail/presentation/group_detail_view.dart';
import 'package:quizzerg/feature/group_detail/presentation/widget/group_mixup_sheet.dart';
import 'package:quizzerg/feature/mixup/domain/bloc/mixup_bloc.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_action_sheet.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/dialogs/dialog_controller.dart';
import 'package:quizzerg/uikit/fields/karto4ki_text_field.dart';
import 'package:quizzerg/uikit/snackbars/deferred_removal.dart';

/// Экран деталки группы.
class GroupDetailScreen extends StatefulWidget {
  final String groupId;

  const GroupDetailScreen({required this.groupId, super.key});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen>
    implements IGroupDetailViewModel {
  final _testRemoval = DeferredRemoval();

  @override
  StateStreamable<GroupDetailState> get groupDetailState =>
      context.read<GroupDetailBloc>();

  @override
  ValueListenable<Set<String>> get removedTestIds => _testRemoval.pending;

  @override
  void dispose() {
    _testRemoval.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GroupDetailView(viewModel: this);
  }

  @override
  void onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  void onAddTestPressed() {
    _showAddTestDialog();
  }

  @override
  void onTestTapped(TestEntity test) => _openTestDetail(test);

  @override
  void onSettingsPressed() {
    final mixupBloc = context.read<MixupBloc>();
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

  @override
  void onTestLongPressed(TestEntity test) {
    _showTestActionsSheet(test);
  }

  /// Тест сразу пропадает из списка, снек «Отменить» возвращает его, а из
  /// группы он убирается, когда снек закрылся без отмены.
  @override
  void onTestRemovePressed(TestEntity test) {
    final bloc = context.read<GroupDetailBloc>();
    final isLastGroup = bloc.state.isLastGroupForTest(test.id);

    _testRemoval.schedule(
      context,
      id: test.id,
      message: isLastGroup
          ? context.l10n.groupDetailTestRemovedLastGroupSnack(test.title)
          : context.l10n.groupDetailTestRemovedSnack(test.title),
      undoLabel: context.l10n.commonUndo,
      commit: () => bloc.add(GroupDetailEvent.testRemoved(testId: test.id)),
    );
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
            Karto4kiTextField(
              controller: titleController,
              labelText: context.l10n.groupDetailNewTestNameHint,
              autofocus: true,
            ),
            const SizedBox(height: 16),
            Karto4kiTextField(
              controller: descriptionController,
              labelText: context.l10n.groupDetailNewTestDescriptionHint,
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

  Future<void> _showTestActionsSheet(TestEntity test) async {
    final l10n = context.l10n;
    final progress = test.progress;
    final accuracy = progress.accuracy;

    final action = await AppActionSheet.show<_TestAction>(
      context,
      title: test.title,
      subtitle: [
        l10n.groupDetailQuestionCount(test.questionCount),
        if (accuracy != null) l10n.actionSheetAccuracy((accuracy * 100).round()),
        if (progress.weakCount > 0) l10n.progressWeakCount(progress.weakCount),
      ].join(' · '),
      buttons: [
        if (test.questionCount > 0)
          AppActionSheetButton(
            icon: M3EIcons.play_arrow_rounded,
            label: l10n.groupDetailTestActionsStart,
            value: _TestAction.start,
          ),
      ],
      items: [
        AppActionSheetItem(
          icon: M3EIcons.edit_outlined,
          label: l10n.groupDetailTestActionsRename,
          value: _TestAction.rename,
        ),
        AppActionSheetItem(
          icon: M3EIcons.drive_file_move_outlined,
          label: l10n.groupDetailTestActionsMove,
          value: _TestAction.move,
        ),
        AppActionSheetItem(
          icon: M3EIcons.upload_file_outlined,
          label: l10n.groupDetailTestActionsImport,
          value: _TestAction.import,
        ),
        AppActionSheetItem(
          icon: M3EIcons.remove_circle_outline_rounded,
          label: l10n.groupDetailTestActionsRemove,
          value: _TestAction.remove,
          isDestructive: true,
        ),
      ],
    );
    if (!mounted) return;

    switch (action) {
      case _TestAction.start:
        _startTest(test);
      case _TestAction.rename:
        _showRenameTestDialog(test);
      case _TestAction.move:
        await _showAddToGroupDialog(test);
      case _TestAction.import:
        _openTestDetail(test, openImport: true);
      case _TestAction.remove:
        onTestRemovePressed(test);
      case null:
        break;
    }
  }

  /// Запуск с настройками по умолчанию — как кнопка ▶ в деталке теста,
  /// пока там ничего не меняли.
  void _startTest(TestEntity test) {
    final mixupState = context.read<MixupBloc>().state;
    context.router.push(
      TinderTestRoute(
        testId: test.id,
        mixup: mixupState.enabled,
        mixupMin: mixupState.mixupMin,
        mixupMax: mixupState.mixupMax,
        groupId: widget.groupId,
      ),
    );
  }

  void _openTestDetail(TestEntity test, {bool openImport = false}) {
    final mixupState = context.read<MixupBloc>().state;
    context.router.push(
      TestDetailRoute(
        testId: test.id,
        mixup: mixupState.enabled,
        mixupMin: mixupState.mixupMin,
        mixupMax: mixupState.mixupMax,
        groupId: widget.groupId,
        openImport: openImport,
      ),
    );
  }

  void _showRenameTestDialog(TestEntity test) {
    final titleController = TextEditingController(text: test.title);

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(context.l10n.groupDetailRenameTestTitle),
        content: Karto4kiTextField(
          controller: titleController,
          labelText: context.l10n.groupDetailRenameTestHint,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty && title != test.title) {
                context.read<GroupDetailBloc>().add(
                      GroupDetailEvent.testRenamed(
                        testId: test.id,
                        title: title,
                      ),
                    );
              }
              Navigator.of(dialogContext).pop();
            },
            child: Text(context.l10n.commonSave),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddToGroupDialog(TestEntity test) async {
    final bloc = context.read<GroupDetailBloc>();
    final state = bloc.state;
    if (state is! GroupDetailState$Loaded) return;

    final currentGroupId = state.group.id;
    final testId = test.id;
    final allGroups = state.allGroups;
    final selectedIds = Set<String>.from(state.groupIdsByTest[testId] ?? []);

    final selected = ValueNotifier<Set<String>>(selectedIds);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => ValueListenableBuilder<Set<String>>(
        valueListenable: selected,
        builder: (context, checkedIds, child) => AppDialog(
          title: Text(this.context.l10n.groupDetailAddToGroupTitle),
          content: allGroups.length <= 1
              ? Text(this.context.l10n.groupDetailAddToGroupEmpty)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final group in allGroups)
                      CheckboxListTile(
                        value: checkedIds.contains(group.id),
                        onChanged: group.id == currentGroupId
                            ? null
                            : (value) => selected.value = _toggled(
                                  checkedIds,
                                  group.id,
                                  isSelected: value ?? false,
                                ),
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
                    groupIds: checkedIds.toList(),
                  ));
                },
                child: Text(this.context.l10n.groupDetailAddToGroupSave),
              ),
          ],
        ),
      ),
    );

    selected.dispose();
  }

  Set<String> _toggled(
    Set<String> ids,
    String id, {
    required bool isSelected,
  }) {
    final updated = Set<String>.of(ids);
    if (isSelected) {
      updated.add(id);
    } else {
      updated.remove(id);
    }
    return updated;
  }

  void _showEditTitleDialog(String currentTitle) {
    final titleController = TextEditingController(text: currentTitle);

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

/// Действия шторки теста по долгому нажатию.
enum _TestAction { start, rename, move, import, remove }

/// ViewModel интерфейс для экрана деталки группы.
abstract interface class IGroupDetailViewModel {
  /// Состояние деталки группы: группа, тесты и привязки.
  StateStreamable<GroupDetailState> get groupDetailState;

  void onBackPressed();

  void onAddTestPressed();

  void onTestTapped(TestEntity test);

  void onTestLongPressed(TestEntity test);

  /// Тесты, убранные из группы, пока это можно отменить: в списке их нет.
  ValueListenable<Set<String>> get removedTestIds;

  /// Убрать тест из группы с отменой через снек.
  void onTestRemovePressed(TestEntity test);

  void onEditTitlePressed();

  /// Открыть шторку настроек подмешивания.
  void onSettingsPressed();
}
