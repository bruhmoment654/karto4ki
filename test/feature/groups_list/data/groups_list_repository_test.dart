import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/groups_list/data/repository/groups_list_repository.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/question_stats/data/service/study_progress_reader.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

import '../../auth/auth_fakes.dart';

final _created = DateTime.utc(2026, 9);

void main() {
  late AppDatabase database;
  late GroupsListRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = GroupsListRepository(
      groupsDatabase: database.groupsDatabase,
      testsDatabase: database.testsDatabase,
      progressReader: StudyProgressReader(
        cardsDatabase: database.cardsDatabase,
        testAttemptsDatabase: database.testAttemptsDatabase,
      ),
      errorLogger: const SilentErrorLogger(),
    );
  });

  tearDown(() => database.close());

  Future<void> seedGroup(String id) => database.groupsDatabase.insertGroup(
    TestGroupsCompanion.insert(
      id: id,
      title: id,
      createdAt: _created,
      updatedAt: _created,
    ),
  );

  /// Тест [testId] с одной карточкой; [streak] — статистика её вопроса,
  /// `null` — вопрос ещё не показывался.
  Future<void> seedTest(String testId, {int? streak}) async {
    await database.testsDatabase.insertTest(
      TestsCompanion.insert(
        id: testId,
        title: testId,
        type: 'tinder',
        createdAt: _created,
        updatedAt: _created,
      ),
    );
    final key = QuestionKeyNormalizer.normalize('q-$testId', ['a']);
    await database.cardsDatabase.insertCard(
      CardsCompanion.insert(
        id: 'card-$testId',
        testId: testId,
        front: 'q-$testId',
        answers: '["a"]',
        questionKey: key,
        createdAt: _created,
        updatedAt: _created,
      ),
    );
    if (streak == null) return;

    await database
        .into(database.questionStats)
        .insert(
          QuestionStatsCompanion.insert(
            questionKey: key,
            frontText: 'q-$testId',
            backText: 'a',
            streak: Value(streak),
            totalShown: const Value(3),
            createdAt: _created,
            updatedAt: _created,
          ),
        );
  }

  Future<Map<String, TestGroupEntity>> groups() async {
    final result = await repository.getGroups();
    final list = (result as ResultOk<List<TestGroupEntity>, Object>).data;
    return {for (final group in list) group.id: group};
  }

  test('прогресс группы собирается из её тестов', () async {
    await seedGroup('a');
    await seedTest('weak', streak: -2);
    await seedTest('fresh');
    await database.groupsDatabase.addTestToGroup('a', 'weak');
    await database.groupsDatabase.addTestToGroup('a', 'fresh');

    final progress = (await groups())['a']!.progress;

    expect(progress.weakCount, 1);
    expect(progress.newCount, 1);
    expect(progress.isNotStarted, isFalse);
  });

  test('перенос теста меняет прогресс обеих групп', () async {
    await seedGroup('a');
    await seedGroup('b');
    await seedTest('mastered', streak: 5);
    await database.groupsDatabase.addTestToGroup('a', 'mastered');

    var byId = await groups();
    expect(byId['a']!.progress.masteredCount, 1);
    expect(byId['b']!.progress.total, 0);

    await repository.updateTestGroups(testId: 'mastered', groupIds: ['b']);

    byId = await groups();
    expect(byId['a']!.progress.total, 0);
    expect(byId['b']!.progress.masteredCount, 1);
  });

  test('удалённый тест в прогресс группы не входит', () async {
    await seedGroup('a');
    await seedTest('deleted', streak: -1);
    await database.groupsDatabase.addTestToGroup('a', 'deleted');
    await database.testsDatabase.softDeleteTestById('deleted');

    expect((await groups())['a']!.progress.total, 0);
  });
}
