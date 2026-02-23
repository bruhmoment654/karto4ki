import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Repository interface for tests list.
abstract interface class ITestsListRepository {
  /// Get all tests.
  RequestOperation<List<TestEntity>> getTests();

  /// Add new test.
  RequestOperation<void> addTest({
    required String title,
    String? description,
  });

  /// Delete test by id.
  RequestOperation<void> deleteTest(int testId);
}
