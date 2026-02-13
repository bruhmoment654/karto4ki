import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/feature/test_merge/domain/bloc/test_merge_bloc.dart';
import 'package:quizzerg/feature/test_merge/presentation/test_merge_view.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';

class TestMergeScreen extends StatefulWidget {
  const TestMergeScreen({super.key});

  @override
  State<TestMergeScreen> createState() => _TestMergeScreenState();
}

class _TestMergeScreenState extends State<TestMergeScreen>
    implements ITestMergeViewModel {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestMergeBloc, TestMergeState>(
      listener: (context, state) {
        if (state is TestMergeState$Success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.testMergeSuccessMessage),
            ),
          );
          context.router.maybePop();
        }
      },
      builder: (context, state) {
        return TestMergeView(viewModel: this, state: state);
      },
    );
  }

  @override
  void onTestToggled(TestEntity test) {
    context.read<TestMergeBloc>().add(
          TestMergeEvent.testToggled(testId: test.id),
        );
  }

  @override
  void onMergePressed() {
    _showTitleDialog();
  }

  @override
  void onBackPressed() {
    context.router.maybePop();
  }

  void _showTitleDialog() {
    final titleController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: Text(context.l10n.testMergeNewTestTitle),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(
            hintText: context.l10n.testMergeNewTestTitle,
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.testsListDeleteDialogCancel),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                context.read<TestMergeBloc>().add(
                      TestMergeEvent.mergeConfirmed(title: title),
                    );
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(context.l10n.testMergeConfirmButton),
          ),
        ],
      ),
    );
  }
}

/// ViewModel интерфейс для экрана объединения тестов.
abstract interface class ITestMergeViewModel {
  void onTestToggled(TestEntity test);

  void onMergePressed();

  void onBackPressed();
}
