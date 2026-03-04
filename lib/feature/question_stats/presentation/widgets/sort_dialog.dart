import 'package:flutter/material.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_sort.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';

Future<QuestionStatsSort?> showSortDialog({
  required BuildContext context,
  required QuestionStatsSort currentSort,
}) {
  return showDialog<QuestionStatsSort>(
    context: context,
    builder: (dialogContext) => _SortDialog(currentSort: currentSort),
  );
}

class _SortDialog extends StatelessWidget {
  final QuestionStatsSort currentSort;

  const _SortDialog({required this.currentSort});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final labels = {
      QuestionStatsSort.byDate: l10n.questionStatsSortByDate,
      QuestionStatsSort.byStreak: l10n.questionStatsSortByStreak,
      QuestionStatsSort.byAccuracy: l10n.questionStatsSortByAccuracy,
    };

    return AppDialog(
      title: Text(l10n.questionStatsSortTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final sort in QuestionStatsSort.values)
            RadioListTile<QuestionStatsSort>(
              value: sort,
              groupValue: currentSort,
              onChanged: (value) => Navigator.of(context).pop(value),
              title: Text(labels[sort]!),
              contentPadding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }
}
