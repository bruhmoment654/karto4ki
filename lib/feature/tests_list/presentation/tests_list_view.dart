import 'package:flutter/material.dart';

import 'package:quizzerg/feature/tests_list/domain/bloc/tests_list_bloc.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/feature/tests_list/presentation/tests_list_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/buttons/app_fab.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';

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
    return AppScaffold(
      appBar: DefaultAppBar(
        title: context.l10n.testsListAppBarTitle,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.testsListEmptyMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              )
            : _TestsList(
                tests: tests,
                viewModel: viewModel,
              ),
      },
      floatingActionButton: AppFloatingActionButton(
        label: context.l10n.testsListAddTestFab,
        onPressed: viewModel.onAddTestPressed,
        icon: Icons.add,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(test.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          Icons.delete,
          color: colorScheme.onError,
        ),
      ),
      confirmDismiss: (direction) async {
        return showDialog<bool>(
          context: context,
          builder: (context) => AppDialog(
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
