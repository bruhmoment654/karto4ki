import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/tests_list/domain/bloc/tests_list_bloc.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/feature/tests_list/presentation/tests_list_view.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';

/// Tests list screen.
///
/// Contains logic for displaying, adding and deleting tests.
class TestsListScreen extends StatefulWidget {
  const TestsListScreen({super.key});

  @override
  State<TestsListScreen> createState() => _TestsListScreenState();
}

class _TestsListScreenState extends State<TestsListScreen>
    implements ITestsListViewModel {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestsListBloc, TestsListState>(
      builder: (context, state) {
        return TestsListView(viewModel: this, state: state);
      },
    );
  }

  @override
  void onAddTestPressed() {
    _showAddTestDialog();
  }

  @override
  void onTestTapped(TestEntity test) {
    context.router.push(TestDetailRoute(testId: int.parse(test.id)));
  }

  @override
  void onTestDeletePressed(TestEntity test) {
    context.read<TestsListBloc>().add(
          TestsListEvent.testDeleted(testId: int.parse(test.id)),
        );
  }

  @override
  void onTestLongPressed(TestEntity test) {
    _showActionsDialog(test);
  }

  void _showActionsDialog(TestEntity test) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(test.title),
        content: ScalePressable(
          onTap: () async {
            Navigator.of(dialogContext).pop();
            final result = await context.router.push(
              TestMergeRoute(initialTestId: int.parse(test.id)),
            );
            if (result == true && mounted) {
              context
                  .read<TestsListBloc>()
                  .add(const TestsListEvent.started());
            }
          },
          child: Row(
            children: [
              const Icon(Icons.merge),
              const SizedBox(width: 16),
              Text(context.l10n.testActionMerge),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddTestDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: const Text('Новый тест'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Название',
                hintText: 'Введите название теста',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Описание',
                hintText: 'Введите описание (необязательно)',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                context.read<TestsListBloc>().add(
                      TestsListEvent.testAdded(
                        title: title,
                        description: descriptionController.text.trim().isEmpty
                            ? null
                            : descriptionController.text.trim(),
                      ),
                    );
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }
}

/// ViewModel interface for tests list screen.
///
/// Defines interaction contract between [TestsListScreen] and [TestsListView].
abstract interface class ITestsListViewModel {
  /// Called when add test button is pressed.
  void onAddTestPressed();

  /// Called when a test is tapped.
  void onTestTapped(TestEntity test);

  /// Called when delete test button is pressed.
  void onTestDeletePressed(TestEntity test);

  /// Called when a test is long pressed.
  void onTestLongPressed(TestEntity test);
}
