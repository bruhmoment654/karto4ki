import 'package:karto4ki/feature/tests_list/domain/entity/test_entity.dart';

/// Интерфейс репозитория для объединения тестов.
abstract interface class ITestMergeRepository {
  /// Получить все тесты.
  Future<List<TestEntity>> getTests();

  /// Объединить тесты: создать новый тест и скопировать вопросы.
  /// Возвращает ID нового теста.
  Future<int> mergeTests({
    required String title,
    required List<int> testIds,
    String? description,
  });
}
