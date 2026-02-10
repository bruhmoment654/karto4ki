import 'package:karto4ki/feature/card_detail/data/converters/card_converter.dart';
import 'package:karto4ki/feature/card_detail/data/database/cards_database.dart';
import 'package:karto4ki/feature/test_merge/domain/repository/i_test_merge_repository.dart';
import 'package:karto4ki/feature/tests_list/data/converters/test_converter.dart';
import 'package:karto4ki/feature/tests_list/data/database/tests_database.dart';
import 'package:karto4ki/feature/tests_list/domain/entity/test_entity.dart';
import 'package:karto4ki/persistence/database/app_database.dart';

/// Реализация репозитория для объединения тестов.
class TestMergeRepository implements ITestMergeRepository {
  final TestsDatabase _testsDatabase;
  final CardsDatabase _cardsDatabase;

  TestMergeRepository({
    required TestsDatabase testsDatabase,
    required CardsDatabase cardsDatabase,
  })  : _testsDatabase = testsDatabase,
        _cardsDatabase = cardsDatabase;

  @override
  Future<List<TestEntity>> getTests() async {
    final dtos = await _testsDatabase.getAllTests();
    return dtos.map(TestConverter.fromDto).toList();
  }

  @override
  Future<int> mergeTests({
    required String title,
    required List<int> testIds,
    String? description,
  }) async {
    final newTestCompanion = TestConverter.toNewCompanion(
      title: title,
      description: description,
    );
    final newTestId = await _testsDatabase.insertTest(newTestCompanion);

    final companions = <CardsCompanion>[];

    for (final testId in testIds) {
      final cards = await _cardsDatabase.getCardsByTestId(testId);
      for (final card in cards) {
        companions.add(
          CardConverter.toNewCompanion(
            testId: newTestId,
            front: card.question,
            back: card.answer,
          ),
        );
      }
    }

    if (companions.isNotEmpty) {
      await _cardsDatabase.insertCards(companions);
    }

    return newTestId;
  }
}
