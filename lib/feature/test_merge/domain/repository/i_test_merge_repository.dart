import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

/// Test merge repository interface.
abstract interface class ITestMergeRepository {
  /// Get all tests.
  RequestOperation<List<TestEntity>> getTests();

  /// Merge tests: create a new test and copy questions.
  /// Returns the new test ID.
  RequestOperation<int> mergeTests({
    required String title,
    required List<int> testIds,
    String? description,
  });
}
