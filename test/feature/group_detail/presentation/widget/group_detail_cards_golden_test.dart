import 'package:flutter/material.dart';
import 'package:quizzerg/feature/group_detail/presentation/widget/group_summary_card.dart';
import 'package:quizzerg/feature/group_detail/presentation/widget/test_stats_card.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/study_progress_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_type.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';
import 'package:quizzerg/uikit/theme/palette/monochrome_palette.dart';
import 'package:zoloto/zoloto.dart';

final _created = DateTime(2026, 9);

TestEntity _test(
  String title, {
  required int questionCount,
  StudyProgressEntity progress = StudyProgressEntity.empty,
  String? description,
}) => TestEntity(
  id: title,
  title: title,
  type: TestType.tinder,
  createdAt: _created,
  updatedAt: _created,
  description: description,
  questionCount: questionCount,
  progress: progress,
);

/// Состояния карточки теста из макета (`CardStates`, колонка «Тест») и
/// «статистика есть, точности нет».
final _tests = [
  _test(
    'Test 21-40',
    questionCount: 20,
    progress: const StudyProgressEntity(
      newCount: 2,
      learningCount: 12,
      masteredCount: 3,
      weakCount: 3,
      accuracy: 0.72,
    ),
  ),
  _test(
    'Test 1-20',
    questionCount: 20,
    description: 'Базовые иероглифы',
    progress: const StudyProgressEntity(masteredCount: 20, accuracy: 0.96),
  ),
  _test(
    'Test 61-80',
    questionCount: 20,
    progress: const StudyProgressEntity(newCount: 20),
  ),
  _test('Test 81-100', questionCount: 0),
  _test(
    'Test 101-120',
    questionCount: 20,
    progress: const StudyProgressEntity(newCount: 4, learningCount: 16),
  ),
];

Widget _cards({ThemeData? theme}) => Builder(
  builder: (context) {
    final content = MediaQuery(
      data: MediaQuery.of(context).copyWith(disableAnimations: true),
      child: Builder(
        builder: (context) => ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const GroupSummaryCard(
                  progress: StudyProgressEntity(
                    newCount: 20,
                    learningCount: 40,
                    masteredCount: 124,
                    weakCount: 16,
                    accuracy: 0.78,
                  ),
                ),
                const Height(10),
                const GroupSummaryCard(
                  progress: StudyProgressEntity(newCount: 60),
                ),
                for (final test in _tests) ...[
                  const Height(10),
                  TestStatsCard(test: test, onAddCardsPressed: () {}),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    return theme == null ? content : Theme(data: theme, child: content);
  },
);

void main() {
  Zoloto.zolotoTest(
    'group_detail_cards',
    widgetBuilder: (context, tester, testCase) => _cards(),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'group_detail_cards_monochrome',
    widgetBuilder: (context, tester, testCase) =>
        _cards(theme: AppTheme.dark(palette: const MonochromePalette())),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
