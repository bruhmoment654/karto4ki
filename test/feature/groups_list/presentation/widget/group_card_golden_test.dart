import 'package:flutter/material.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/presentation/widget/group_card.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/study_progress_entity.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';
import 'package:quizzerg/uikit/theme/palette/monochrome_palette.dart';
import 'package:zoloto/zoloto.dart';

final _created = DateTime(2026, 9);

TestGroupEntity _group(
  String title, {
  required int testCount,
  StudyProgressEntity progress = StudyProgressEntity.empty,
}) => TestGroupEntity(
  id: title,
  title: title,
  createdAt: _created,
  updatedAt: _created,
  testCount: testCount,
  progress: progress,
);

DateTime _daysAgo(int days) => DateTime.now().subtract(Duration(days: days));

/// Состояния карточки группы из макета (`CardStates`, колонка «Группа») и
/// «статистика есть, точности нет» — второе устройство или очищенная
/// история прохождений.
final _groups = [
  _group(
    'Kanji',
    testCount: 10,
    progress: StudyProgressEntity(
      newCount: 20,
      learningCount: 40,
      masteredCount: 124,
      weakCount: 16,
      accuracy: 0.78,
      lastStudiedAt: _daysAgo(2),
    ),
  ),
  _group(
    'Lexica',
    testCount: 6,
    progress: StudyProgressEntity(
      learningCount: 30,
      masteredCount: 90,
      accuracy: 0.94,
      lastStudiedAt: _daysAgo(0),
    ),
  ),
  _group(
    'Grammatics',
    testCount: 3,
    progress: const StudyProgressEntity(newCount: 60),
  ),
  _group('Phrases', testCount: 0),
  _group(
    'Синк с другого устройства',
    testCount: 4,
    progress: const StudyProgressEntity(
      newCount: 5,
      learningCount: 30,
      weakCount: 3,
    ),
  ),
];

/// Кольцо заполняется анимацией, а `zolotoTest` ждёт `pumpAndSettle`:
/// в reduced-motion оно сразу на финальном значении.
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
                for (var index = 0; index < _groups.length; index++) ...[
                  if (index > 0) const Height(12),
                  GroupCard(
                    group: _groups[index],
                    index: index,
                    onTap: () {},
                    onLongPress: () {},
                  ),
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
    'group_card_states',
    widgetBuilder: (context, tester, testCase) => _cards(),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'group_card_states_monochrome',
    widgetBuilder: (context, tester, testCase) =>
        _cards(theme: AppTheme.dark(palette: const MonochromePalette())),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
