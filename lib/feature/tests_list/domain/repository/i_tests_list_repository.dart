import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Repository interface for tests list.
abstract interface class ITestsListRepository {
  /// Эмитит при любом изменении таблицы тестов — включая pull-синхронизацию.
  Stream<void> get testChanges;

  /// Get all tests.
  RequestOperation<List<TestEntity>> getTests();

  /// Get test by id. Returns `null` if not found.
  RequestOperation<TestEntity?> getTestById(String testId);

  /// Add new test.
  RequestOperation<void> addTest({
    required String title,
    String? description,
  });

  /// Delete test by id.
  RequestOperation<void> deleteTest(String testId);
}
