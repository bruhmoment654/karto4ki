import 'package:flutter/material.dart';
import 'package:quizzerg/feature/groups_list/presentation/widget/active_session_card.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_session_launch_params.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';
import 'package:zoloto/zoloto.dart';

final _created = DateTime(2026, 9);

ActiveTestSession _session({required int done}) {
  final cards = [
    for (var i = 0; i < 70; i++)
      CardEntity(
        id: 'card-$i',
        testId: 'test',
        front: 'q$i',
        answers: ['a$i'],
        createdAt: _created,
        updatedAt: _created,
      ),
  ];
  return ActiveTestSession(
    session: TestSession(
      testId: 'test',
      cards: cards,
      currentIndex: done,
      results: const [],
      startedAt: _created,
    ),
    params: const ActiveSessionLaunchParams(
      swapSides: false,
      answerIndex: 0,
      mixup: true,
      mixupMin: 1,
      mixupMax: 5,
      algorithm: MixupAlgorithm.scoring,
      groupId: 'group',
    ),
    testTitle: 'Test 21-40',
    updatedAt: _created,
  );
}

/// Волна прогресса бежит бесконечно, а `zolotoTest` ждёт `pumpAndSettle`:
/// тикеры выключены, прогресс в reduced-motion сразу на финальном значении.
/// `Align` — чтобы карточка мерилась по содержимому, а не по экрану.
Widget _wrap(Widget child) => Builder(
  builder: (context) => MediaQuery(
    data: MediaQuery.of(context).copyWith(disableAnimations: true),
    child: TickerMode(
      enabled: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    ),
  ),
);

void main() {
  Zoloto.zolotoTest(
    'active_session_card',
    widgetBuilder: (context, tester, testCase) => _wrap(
      ActiveSessionCard(
        session: _session(done: 24),
        groupTitle: 'Kanji',
        onResume: () {},
        onDismiss: () {},
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );

  // Тест запущен не из группы — строки группы нет.
  Zoloto.zolotoTest(
    'active_session_card_no_group',
    widgetBuilder: (context, tester, testCase) => _wrap(
      ActiveSessionCard(
        session: _session(done: 24),
        onResume: () {},
        onDismiss: () {},
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'active_session_card_just_started',
    widgetBuilder: (context, tester, testCase) => _wrap(
      ActiveSessionCard(
        session: _session(done: 0),
        groupTitle: 'Kanji',
        onResume: () {},
        onDismiss: () {},
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
