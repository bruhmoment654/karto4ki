import 'package:flutter/material.dart';

import 'package:quizzerg/feature/test_merge/domain/bloc/test_merge_bloc.dart';
import 'package:quizzerg/feature/test_merge/presentation/test_merge_screen.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';

class TestMergeView extends StatelessWidget {
  final ITestMergeViewModel viewModel;
  final TestMergeState state;

  const TestMergeView({
    required this.viewModel,
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar(
        title: Text(context.l10n.testMergeAppBarTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: viewModel.onBackPressed,
        ),
        actions: [
          if (state is TestMergeState$Loaded)
            TextButton(
              onPressed: _isMergeEnabled(state as TestMergeState$Loaded)
                  ? viewModel.onMergePressed
                  : null,
              child: Text(context.l10n.testMergeConfirmButton),
            ),
        ],
      ),
      body: switch (state) {
        TestMergeState$Loading() || TestMergeState$Merging() => const Center(
            child: CircularProgressIndicator(),
          ),
        TestMergeState$Error(:final failure) => Center(
            child: Text(
              failure.message ?? context.l10n.testsListUnknownError,
            ),
          ),
        TestMergeState$Success() => const SizedBox.shrink(),
        TestMergeState$Loaded(
          :final tests,
          :final selectedTestIds,
          :final initialTestId,
        ) =>
          tests.isEmpty
              ? Center(
                  child: Text(context.l10n.testMergeSelectHint),
                )
              : _TestMergeList(
                  tests: tests,
                  selectedTestIds: selectedTestIds,
                  initialTestId: initialTestId,
                  viewModel: viewModel,
                ),
      },
    );
  }

  bool _isMergeEnabled(TestMergeState$Loaded loaded) =>
      loaded.selectedTestIds.length >= 2;
}

class _TestMergeList extends StatelessWidget {
  final List<TestEntity> tests;
  final Set<String> selectedTestIds;
  final String initialTestId;
  final ITestMergeViewModel viewModel;

  const _TestMergeList({
    required this.tests,
    required this.selectedTestIds,
    required this.initialTestId,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tests.length,
      itemBuilder: (context, index) {
        final test = tests[index];
        final isSelected = selectedTestIds.contains(test.id);
        final isInitial = test.id == initialTestId;

        return CheckboxListTile(
          value: isSelected,
          onChanged: isInitial ? null : (_) => viewModel.onTestToggled(test),
          title: Text(test.title),
          subtitle: test.description != null ? Text(test.description!) : null,
          enabled: !isInitial,
        );
      },
    );
  }
}
