import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/uikit/question_card/swipable_card_wrapper.dart';

final _created = DateTime(2026, 9);

CardEntity _card(String id) => CardEntity(
  id: id,
  testId: 'test',
  front: 'q$id',
  answers: ['a$id'],
  createdAt: _created,
  updatedAt: _created,
);

Widget _wrapper(CardEntity card, {CardEntrySide? enterFrom}) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: SwipeableCardWrapper(
      card: card,
      showAnswer: false,
      enableFlipAnimation: false,
      enterFrom: enterFrom,
      onTap: () {},
      onSwipeLeft: () {},
      onSwipeRight: () {},
    ),
  ),
);

double _cardOffset(WidgetTester tester) => tester
    .widget<Transform>(
      find
          .descendant(
            of: find.byType(SwipeableCardWrapper),
            matching: find.byType(Transform),
          )
          .first,
    )
    .transform
    .getTranslation()
    .x;

void main() {
  for (final (side, isFromRight) in [
    (CardEntrySide.left, false),
    (CardEntrySide.right, true),
  ]) {
    testWidgets('отменённая карточка заезжает с ${side.name} стороны', (
      tester,
    ) async {
      await tester.pumpWidget(_wrapper(_card('1')));
      await tester.pumpWidget(_wrapper(_card('2'), enterFrom: side));
      await tester.pump(const Duration(milliseconds: 50));

      final offset = _cardOffset(tester);
      expect(isFromRight ? offset > 0 : offset < 0, isTrue);

      await tester.pumpAndSettle();
      expect(_cardOffset(tester), 0);
    });
  }
}
