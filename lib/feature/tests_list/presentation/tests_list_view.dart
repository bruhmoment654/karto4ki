import 'package:flutter/material.dart';

import 'package:karto4ki/feature/tests_list/domain/entity/test_entity.dart';
import 'package:karto4ki/feature/tests_list/domain/bloc/tests_list_bloc.dart';
import 'package:karto4ki/feature/tests_list/presentation/tests_list_screen.dart';

/// UI layer for tests list screen.
///
/// Responsible for visual representation of tests list:
/// list of tests, add button, delete functionality.
class TestsListView extends StatelessWidget {
  final ITestsListViewModel viewModel;
  final TestsListState state;

  const TestsListView({
    required this.viewModel,
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тесты'),
      ),
      body: switch (state) {
        TestsListState$Loading() => const Center(
            child: CircularProgressIndicator(),
          ),
        TestsListState$Error(:final failure) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ошибка: ${failure.message ?? "Неизвестная ошибка"}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Повторить'),
                ),
              ],
            ),
          ),
        TestsListState$Loaded(:final tests) => tests.isEmpty
            ? const Center(
                child: Text(
                  'Нет тестов.\nНажмите + чтобы создать первый тест.',
                  textAlign: TextAlign.center,
                ),
              )
            : _TestsList(
                tests: tests,
                viewModel: viewModel,
              ),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.onAddTestPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TestsList extends StatelessWidget {
  final List<TestEntity> tests;
  final ITestsListViewModel viewModel;

  const _TestsList({
    required this.tests,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tests.length,
      itemBuilder: (context, index) {
        final test = tests[index];
        return _TestListItem(
          test: test,
          onTap: () => viewModel.onTestTapped(test),
          onDelete: () => viewModel.onTestDeletePressed(test),
        );
      },
    );
  }
}

class _TestListItem extends StatelessWidget {
  final TestEntity test;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _TestListItem({
    required this.test,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(test.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        return showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Удалить тест?'),
            content: Text('Вы уверены, что хотите удалить "${test.title}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Удалить'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onDelete(),
      child: ListTile(
        title: Text(test.title),
        subtitle: test.description != null ? Text(test.description!) : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
