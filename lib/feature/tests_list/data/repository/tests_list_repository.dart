import 'package:karto4ki/feature/tests_list/data/converters/test_converter.dart';
import 'package:karto4ki/feature/tests_list/data/database/tests_database.dart';
import 'package:karto4ki/feature/tests_list/domain/entity/test_entity.dart';
import 'package:karto4ki/feature/tests_list/domain/repository/i_tests_list_repository.dart';

/// Repository implementation for tests list.
class TestsListRepository implements ITestsListRepository {
  final TestsDatabase _testsDatabase;

  const TestsListRepository({required TestsDatabase testsDatabase})
      : _testsDatabase = testsDatabase;

  @override
  Future<List<TestEntity>> getTests() async {
    final dtos = await _testsDatabase.getAllTests();
    return dtos.map(TestConverter.fromDto).toList();
  }

  @override
  Future<void> addTest({
    required String title,
    String? description,
  }) async {
    await _testsDatabase.insertTest(
      TestConverter.toNewCompanion(
        title: title,
        description: description,
      ),
    );
  }

  @override
  Future<void> deleteTest(int testId) async {
    await _testsDatabase.deleteTestById(testId);
  }
}
