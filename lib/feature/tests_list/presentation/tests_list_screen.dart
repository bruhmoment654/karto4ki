import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:karto4ki/feature/tests/domain/entity/test_entity.dart';
import 'package:karto4ki/feature/tests_list/domain/bloc/tests_list_bloc.dart';
import 'package:karto4ki/feature/tests_list/presentation/tests_list_view.dart';

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
    // TODO(karto4ki): Navigate to test detail screen.
  }

  @override
  void onTestDeletePressed(TestEntity test) {
    context.read<TestsListBloc>().add(
          TestsListEvent.testDeleted(testId: int.parse(test.id)),
        );
  }

  void _showAddTestDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
}
