import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Repository interface for tests list.
abstract interface class ITestsListRepository {
  /// Get all tests (включая soft-deleted).
  RequestOperation<List<TestEntity>> getTests();

  /// Get test by id. Returns `null` if not found.
  RequestOperation<TestEntity?> getTestById(String testId);

  /// Add new test.
  RequestOperation<void> addTest({
    required String title,
    String? description,
  });

  /// Soft delete test by id.
  RequestOperation<void> deleteTest(String testId);

  /// Restore soft-deleted test by id.
  RequestOperation<void> restoreTest(String testId);
}
