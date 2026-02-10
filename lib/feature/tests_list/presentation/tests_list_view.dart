import 'package:flutter/material.dart';

import 'package:karto4ki/feature/tests_list/domain/bloc/tests_list_bloc.dart';
import 'package:karto4ki/feature/tests_list/domain/entity/test_entity.dart';
import 'package:karto4ki/feature/tests_list/presentation/tests_list_screen.dart';
import 'package:karto4ki/l10n/app_localizations_x.dart';

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
        title: Text(context.l10n.testsListAppBarTitle),
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
                  context.l10n.testsListErrorMessage(
                    failure.message ?? context.l10n.testsListUnknownError,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(context.l10n.testsListRetryButton),
                ),
              ],
            ),
          ),
        TestsListState$Loaded(:final tests) => tests.isEmpty
            ? Center(
                child: Text(
                  context.l10n.testsListEmptyMessage,
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
          onLongPress: () => viewModel.onTestLongPressed(test),
        );
      },
    );
  }
}

class _TestListItem extends StatelessWidget {
  final TestEntity test;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onLongPress;

  const _TestListItem({
    required this.test,
    required this.onTap,
    required this.onDelete,
    required this.onLongPress,
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
            title: Text(context.l10n.testsListDeleteDialogTitle),
            content: Text(
              context.l10n.testsListDeleteDialogMessage(test.title),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(context.l10n.testsListDeleteDialogCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(context.l10n.testsListDeleteDialogConfirm),
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
        onLongPress: onLongPress,
      ),
    );
  }
}
