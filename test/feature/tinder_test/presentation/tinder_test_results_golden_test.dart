import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/settings/domain/bloc/settings_bloc.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/test_attempt_entity.dart';
import 'package:quizzerg/feature/test_execution/domain/service/attempt_summary_builder.dart';
import 'package:quizzerg/feature/tinder_test/domain/bloc/tinder_test_bloc.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/feature/tinder_test/presentation/tinder_test_screen.dart';
import 'package:quizzerg/feature/tinder_test/presentation/tinder_test_view.dart';
import 'package:zoloto/zoloto.dart';

import '../../../util/fake_state_streamable.dart';

// --- Mocks ---

class _MockViewModel implements ITinderTestViewModel {
  _MockViewModel(TinderTestState state)
    : tinderState = FakeStateStreamable(state);

  @override
  final StateStreamable<TinderTestState> tinderState;

  /// Экрану результата настройки карточки не нужны.
  @override
  StateStreamable<SettingsState> get settingsState =>
      throw UnimplementedError();

  @override
  void onSwipeLeft(CardEntity card) {}

  @override
  void onSwipeRight(CardEntity card) {}

  @override
  void onRestartPressed() {}

  @override
  void onBackPressed() {}

  @override
  void onDiscardPressed() {}
}

// --- Test Data ---

final _created = DateTime(2026, 9);

/// Вопрос, ответ и история ответов в прохождениях теста; последний —
/// текущий. Повторяет данные макета.
const _questions = [
  ('apple', 'яблоко', [false, false, true, true, true]),
  ('cat', 'кот | кошка', [true, true, true, true, true]),
  ('dog', 'собака | пёс', [false, true, false, true, true]),
  ('run', 'бежать', [true, true, true, true, false]),
  ('window', 'окно', [false, false, false, false, true]),
  ('tree', 'дерево', [true, true, true, true, true]),
  ('yesterday', 'вчера', [false, true, true, true, true]),
  ('bridge', 'мост', [true, false, true, true, true]),
  ('cloud', 'облако', [true, true, true, true, true]),
  ('weather', 'погода', [false, false, true, false, true]),
];

CardEntity _card(String front, String back) => CardEntity(
  id: front,
  testId: 'test',
  front: front,
  answers: back.split(' | '),
  createdAt: _created,
  updatedAt: _created,
);

TestSession _session({bool allCorrect = false}) {
  final cards = [for (final (front, back, _) in _questions) _card(front, back)];
  return TestSession(
    testId: 'test',
    cards: cards,
    currentIndex: cards.length,
    results: [
      for (final (front, _, history) in _questions)
        CardResult(
          cardId: front,
          isCorrect: allCorrect || history.last,
          answeredAt: _created,
        ),
    ],
    startedAt: _created,
  );
}

TestAttemptEntity _attempt(int day, int correct) => TestAttemptEntity(
  id: 'attempt-$day',
  testId: 'test',
  startedAt: DateTime(2026, 9, day, 12),
  completedAt: DateTime(2026, 9, day, 12, 5),
  total: 10,
  correct: correct,
);

AttemptSummary _repeatSummary(TestSession session) =>
    AttemptSummaryBuilder.build(
      session: session,
      recentAttempts: [
        _attempt(12, 5),
        _attempt(18, 6),
        _attempt(24, 7),
        _attempt(29, 7),
        _attempt(30, session.correctCount),
      ],
      totalAttempts: 12,
      previousAnswers: {
        for (final (front, back, history) in _questions)
          AttemptSummaryBuilder.questionKeyOf(_card(front, back)): history
              .sublist(0, history.length - 1),
      },
    );

AttemptSummary _firstSummary(TestSession session) =>
    AttemptSummaryBuilder.build(
      session: session,
      recentAttempts: [_attempt(30, session.correctCount)],
      totalAttempts: 1,
      previousAnswers: const {},
    );

// --- Golden Tests ---

/// Кольцо колышется бесконечно, а `zolotoTest` снимает кадр через
/// `pumpAndSettle`. В reduced-motion вода сразу на финальном уровне, блоки
/// и столбики — в финальном состоянии.
Widget _view(TinderTestState state) => Builder(
  builder: (context) => MediaQuery(
    data: MediaQuery.of(context).copyWith(disableAnimations: true),
    child: TinderTestView(viewModel: _MockViewModel(state)),
  ),
);

void main() {
  final session = _session();
  final perfectSession = _session(allCorrect: true);

  // 1. Первое прохождение: чип, заглушка динамики, «Знаю / Не знаю».
  Zoloto.zolotoTest(
    'tinder_test_results_first_attempt',
    widgetBuilder: (context, tester, testCase) => _view(
      TinderTestState.completed(
        session: session,
        summary: _firstSummary(session),
      ),
    ),
    testHeight: const TestHeight.fixed(1300),
  );

  // 2. Повтор: дельта, столбики, история и тренды по вопросам.
  Zoloto.zolotoTest(
    'tinder_test_results_repeat',
    widgetBuilder: (context, tester, testCase) => _view(
      TinderTestState.completed(
        session: session,
        summary: _repeatSummary(session),
      ),
    ),
    testHeight: const TestHeight.fixed(1300),
  );

  // 3. Всё верно: фильтр «Ошибки 0» недоступен.
  Zoloto.zolotoTest(
    'tinder_test_results_perfect',
    widgetBuilder: (context, tester, testCase) => _view(
      TinderTestState.completed(
        session: perfectSession,
        summary: _repeatSummary(perfectSession),
      ),
    ),
  );

  // 4. Сводка ещё пишется: только кольцо и кнопки.
  Zoloto.zolotoTest(
    'tinder_test_results_pending',
    widgetBuilder: (context, tester, testCase) =>
        _view(TinderTestState.completed(session: session)),
  );
}
