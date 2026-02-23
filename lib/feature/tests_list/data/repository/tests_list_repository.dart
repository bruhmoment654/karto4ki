import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/tests_list/data/converters/test_converter.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/repository/i_tests_list_repository.dart';

/// Repository implementation for tests list.
class TestsListRepository extends BaseRepository
    implements ITestsListRepository {
  final TestsDatabase _testsDatabase;

  const TestsListRepository({
    required TestsDatabase testsDatabase,
    required super.errorLogger,
  }) : _testsDatabase = testsDatabase;

  @override
  RequestOperation<List<TestEntity>> getTests() => makeCall(() async {
        final dtos = await _testsDatabase.getAllTests();
        return dtos.map(TestConverter.fromDto).toList();
      });

  @override
  RequestOperation<void> addTest({
    required String title,
    String? description,
  }) =>
      makeCall(() async {
        await _testsDatabase.insertTest(
          TestConverter.toNewCompanion(
            title: title,
            description: description,
          ),
        );
      });

  @override
  RequestOperation<void> deleteTest(int testId) => makeCall(() async {
        await _testsDatabase.deleteTestById(testId);
      });
}
