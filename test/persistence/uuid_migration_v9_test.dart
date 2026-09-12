import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart' as raw;

const _legacySchema = '''
CREATE TABLE tests (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT,
  type TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);
CREATE TABLE cards (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  test_id INTEGER NOT NULL REFERENCES tests(id) ON DELETE CASCADE,
  question TEXT NOT NULL,
  answer TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);
CREATE TABLE test_groups (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);
CREATE TABLE test_group_entries (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  group_id INTEGER NOT NULL,
  test_id INTEGER NOT NULL,
  UNIQUE(group_id, test_id)
);
CREATE TABLE question_stats (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  question_key TEXT NOT NULL UNIQUE,
  front_text TEXT NOT NULL,
  back_text TEXT NOT NULL,
  streak INTEGER NOT NULL DEFAULT 0,
  total_correct INTEGER NOT NULL DEFAULT 0,
  total_incorrect INTEGER NOT NULL DEFAULT 0,
  total_shown INTEGER NOT NULL DEFAULT 0,
  last_answered_at DATETIME,
  last_shown_at DATETIME,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);
CREATE TABLE active_sessions (
  id INTEGER NOT NULL PRIMARY KEY,
  data TEXT NOT NULL
);
''';

const _legacyData = '''
INSERT INTO test_groups (id, title, created_at, updated_at) VALUES
  (1, 'Биология', 1700000000, 1700000000),
  (2, 'Пустая группа', 1700000100, 1700000100);

INSERT INTO tests (id, title, description, type, created_at, updated_at)
VALUES
  (1, 'Клетка', 'Основы', 'tinder', 1700000200, 1700000300),
  (2, 'Генетика', NULL, 'tinder', 1700000400, 1700000400);

INSERT INTO cards (id, test_id, question, answer, created_at, updated_at)
VALUES
  (1, 1, 'Что такое митохондрия?', 'органелла', 1700000500, 1700000500),
  (2, 1, 'Кот', 'cat | kitty', 1700000500, 1700000500),
  (3, 2, 'ДНК', 'дезоксирибонуклеиновая кислота', 1700000600, 1700000600);

INSERT INTO test_group_entries (group_id, test_id) VALUES (1, 1), (1, 2);

INSERT INTO question_stats
  (question_key, front_text, back_text, streak, total_correct,
   total_incorrect, total_shown, created_at, updated_at)
VALUES
  ('legacy-key', 'Кот', 'cat | kitty', 3, 5, 1, 6, 1700000700, 1700000700);

INSERT INTO active_sessions (id, data) VALUES (1, '{"testId":1}');
''';

/// Создаёт базу схемы 8 с данными, похожими на боевые.
File _createLegacyDatabase() {
  final directory = Directory.systemTemp.createTempSync('karto4ki_migration');
  final file = File('${directory.path}/legacy.sqlite');
  raw.sqlite3.open(file.path)
    ..execute(_legacySchema)
    ..execute(_legacyData)
    ..execute('PRAGMA user_version = 8')
    ..dispose();

  return file;
}

void main() {
  group('Миграция 8 → 9', () {
    late AppDatabase database;

    setUp(() async {
      database = AppDatabase.forTesting(
        NativeDatabase(_createLegacyDatabase()),
      );
      // Первый запрос запускает onUpgrade.
      await database.testsDatabase.getAllTests();
    });

    tearDown(() => database.close());

    test('тесты получают uuid и сохраняют порядок создания', () async {
      final tests = await database.testsDatabase.getAllTests()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

      expect(tests.length, 2);
      expect(tests.map((it) => it.id).toSet().length, 2);
      for (final test in tests) {
        // uuid v7: 36 символов, номер версии в 15-й позиции.
        expect(test.id.length, 36);
        expect(test.id[14], '7');
      }
      // Порядок id совпадает с хронологическим.
      expect(tests.first.id.compareTo(tests.last.id), lessThan(0));
    });

    test('все строки помечены неотправленными', () async {
      final tests = await database.testsDatabase.getAllTestsRaw();
      final groups = await database.groupsDatabase.getAllGroups();

      for (final test in tests) {
        expect(SyncState.fromDb(test.syncState), SyncState.pending);
      }
      for (final group in groups) {
        expect(SyncState.fromDb(group.syncState), SyncState.pending);
      }
    });

    test('статистика тоже ждёт отправки: сервер её иначе не узнает', () async {
      // Счётчики, накопленные до журнала ответов, событий за собой не имеют —
      // на сервер их отдаст только push агрегата.
      final stats = await database.questionStatsDatabase.getAllStats();
      expect(stats, isNotEmpty);
      for (final row in stats) {
        expect(SyncState.fromDb(row.syncState), SyncState.pending);
      }
      expect(
        await database.questionStatsDatabase.countPendingStats(),
        stats.length,
      );
    });

    test('карточки сохраняют привязку к тесту', () async {
      final tests = await database.testsDatabase.getAllTests();
      final cell = tests.firstWhere((it) => it.title == 'Клетка');
      final cards = await database.cardsDatabase.getCardsByTestId(cell.id);

      expect(cards.length, 2);
    });

    test('ответы переезжают в JSON, ключ вопроса пересчитан', () async {
      final cards = await database.cardsDatabase.getAllCards();
      final cat = cards.firstWhere((it) => it.front == 'Кот');

      expect(jsonDecode(cat.answers), ['cat', 'kitty']);
      expect(
        cat.questionKey,
        QuestionKeyNormalizer.normalize('Кот', ['cat', 'kitty']),
      );
    });

    test('связи тест ↔ группа переписаны на новые id', () async {
      final groups = await database.groupsDatabase.getAllGroups();
      final biology = groups.firstWhere((it) => it.title == 'Биология');
      final testIds =
          await database.groupsDatabase.getTestIdsByGroupId(biology.id);
      final tests = await database.testsDatabase.getAllTests();

      expect(testIds.length, 2);
      expect(testIds.toSet(), tests.map((it) => it.id).toSet());
    });

    test('ключи статистики пересчитаны под серверную формулу', () async {
      final stats = await database.questionStatsDatabase.getAllStats();

      expect(
        stats.single.questionKey,
        QuestionKeyNormalizer.normalize('Кот', ['cat', 'kitty']),
      );
      // Счётчики не потеряны.
      expect(stats.single.totalShown, 6);
      expect(stats.single.streak, 3);
    });

    test('статистика снова находится по ключу карточки', () async {
      final cards = await database.cardsDatabase.getAllCards();
      final cat = cards.firstWhere((it) => it.front == 'Кот');
      final stat = await database.questionStatsDatabase
          .getByQuestionKey(cat.questionKey);

      expect(stat, isNotNull);
    });

    test('активная сессия со старыми id удалена', () async {
      final rows =
          await database.customSelect('SELECT * FROM active_sessions').get();

      expect(rows, isEmpty);
    });

    test('служебные таблицы sync созданы', () async {
      await database.syncDatabase.setMeta('probe', 'value');

      expect(await database.syncDatabase.getMeta('probe'), 'value');
      expect(await database.syncDatabase.getUnsentAnswers(limit: 10), isEmpty);
    });
  });
}
