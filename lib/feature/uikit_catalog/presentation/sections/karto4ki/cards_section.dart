import 'package:flutter/material.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/item_card/app_item_card.dart';
import 'package:quizzerg/uikit/question_card/question_card.dart';
import 'package:quizzerg/uikit/question_card/swipable_card_wrapper.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// Карточки: контейнеры, элементы списков, карточки вопросов.
class CardsSection extends StatelessWidget {
  const CardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogItem(
          title: 'ContentCard',
          description: 'Все ContentCardType, рамка, тень',
          child: _ContentCards(),
        ),
        CatalogItem(
          title: 'AppItemCard',
          description: 'С подзаголовком, подписью и trailing',
          child: AppItemCard(
            icon: Icons.auto_stories_outlined,
            title: 'Английский: глаголы',
            subtitle: 'Неправильные глаголы',
            caption: '42 вопроса',
            trailing: Icon(Icons.chevron_right),
          ),
        ),
        CatalogItem(
          title: 'QuestionCard',
          description: 'Тап переворачивает',
          child: SizedBox(height: 260, child: _QuestionCardDemo()),
        ),
        CatalogItem(
          title: 'SwipeableCardWrapper',
          description: 'Тап — ответ, свайп — следующая карточка',
          child: _SwipeDemo(),
        ),
      ],
    );
  }
}

class _ContentCards extends StatelessWidget {
  const _ContentCards();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final type in ContentCardType.values) ...[
          ContentCard(type: type, child: Text('type: ${type.name}')),
          const Height(8),
        ],
        ContentCard(
          borderColor: colorScheme.primary,
          borderWidth: 2,
          child: const Text('borderColor + borderWidth'),
        ),
        const Height(8),
        const ContentCard(elevation: 4, child: Text('elevation: 4')),
      ],
    );
  }
}

class _QuestionCardDemo extends StatelessWidget {
  const _QuestionCardDemo();

  @override
  Widget build(BuildContext context) {
    return QuestionCard.fromText(
      frontText: 'Столица Франции?',
      backText: 'Париж',
    );
  }
}

class _SwipeDemo extends StatefulWidget {
  const _SwipeDemo();

  @override
  State<_SwipeDemo> createState() => _SwipeDemoState();
}

class _SwipeDemoState extends State<_SwipeDemo> {
  static final _createdAt = DateTime(2026);
  static final _cards = [
    ('apple', ['яблоко']),
    ('to run', ['бежать', 'бегать']),
    ('tree', ['дерево']),
  ];

  int _index = 0;
  int _known = 0;
  int _unknown = 0;
  bool _showAnswer = false;

  CardEntity get _card {
    final (front, answers) = _cards[_index % _cards.length];

    return CardEntity(
      id: '$_index',
      testId: 'catalog',
      front: front,
      answers: answers,
      createdAt: _createdAt,
      updatedAt: _createdAt,
    );
  }

  void _next({required bool isKnown}) {
    setState(() {
      isKnown ? _known++ : _unknown++;
      _index++;
      _showAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 280,
          child: SwipeableCardWrapper(
            card: _card,
            showAnswer: _showAnswer,
            enableFlipAnimation: true,
            onTap: () => setState(() => _showAnswer = !_showAnswer),
            onSwipeLeft: () => _next(isKnown: false),
            onSwipeRight: () => _next(isKnown: true),
          ),
        ),
        const Height(8),
        Text('Знаю: $_known · Не знаю: $_unknown'),
      ],
    );
  }
}
