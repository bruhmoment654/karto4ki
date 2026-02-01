import 'package:karto4ki/feature/tests/domain/entity/test_entity.dart';

/// Repository interface for tests list.
abstract interface class ITestsListRepository {
  /// Get all tests.
  Future<List<TestEntity>> getTests();

  /// Add new test.
  Future<void> addTest({
    required String title,
    String? description,
  });

  /// Delete test by id.
  Future<void> deleteTest(int testId);
}
