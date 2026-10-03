import 'package:flutter/material.dart';
import 'package:quizzerg/core/bloc/side_effect_value.dart';
import 'package:quizzerg/feature/settings/presentation/widget/attempt_history_card.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/attempt_history_bloc.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_history_usage.dart';
import 'package:zoloto/zoloto.dart';

const _usage = AttemptHistoryUsage(bytes: 1200000);

/// Скелетон и прогресс в кнопке крутятся бесконечно, а `zolotoTest` ждёт
/// `pumpAndSettle`: тикеры выключены, анимации — в reduced-motion.
/// `Align` — чтобы карточка мерилась по содержимому, а не по экрану.
Widget _wrap(AttemptHistoryState state) => Builder(
  builder: (context) => MediaQuery(
    data: MediaQuery.of(context).copyWith(disableAnimations: true),
    child: TickerMode(
      enabled: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AttemptHistoryCard(state: state, onClearPressed: () {}),
        ),
      ),
    ),
  ),
);

void main() {
  Zoloto.zolotoTest(
    'attempt_history_card_loading',
    widgetBuilder: (context, tester, testCase) =>
        _wrap(const AttemptHistoryState.loading()),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'attempt_history_card_loaded',
    widgetBuilder: (context, tester, testCase) =>
        _wrap(const AttemptHistoryState.loaded(usage: _usage)),
    testHeight: const TestHeight$BasedOnContent(),
  );

  // SQLite без `dbstat` — размер оценён по числу строк.
  Zoloto.zolotoTest(
    'attempt_history_card_estimate',
    widgetBuilder: (context, tester, testCase) => _wrap(
      const AttemptHistoryState.loaded(
        usage: AttemptHistoryUsage(bytes: 1200000, isEstimate: true),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'attempt_history_card_empty',
    widgetBuilder: (context, tester, testCase) => _wrap(
      AttemptHistoryState.loaded(
        usage: AttemptHistoryUsage.empty,
        clearResult: SideEffectValue(AttemptHistoryClearResult.cleared),
      ),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );

  Zoloto.zolotoTest(
    'attempt_history_card_clearing',
    widgetBuilder: (context, tester, testCase) => _wrap(
      const AttemptHistoryState.loaded(usage: _usage, isClearing: true),
    ),
    testHeight: const TestHeight$BasedOnContent(),
  );
}
