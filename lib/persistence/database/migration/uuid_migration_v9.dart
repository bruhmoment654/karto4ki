import 'package:drift/drift.dart';

import 'package:quizzerg/core/utils/answer_parser.dart';
import 'package:quizzerg/core/utils/answers_codec.dart';
import 'package:quizzerg/core/utils/uuid_generator.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Строка старой таблицы с int-идентификатором.
typedef LegacyRow = ({int id, int createdAt, Map<String, Object?> data});

/// Миграция схемы 8 → 9.
///
/// Переводит `tests` / `cards` / `test_groups` / `test_group_entries`
/// с `INTEGER AUTOINCREMENT` на uuid v7, добавляет поля синхронизации
/// и tombstone, создаёт служебные таблицы sync.
///
/// Все строки получают `sync_state = 'pending'` — при первой синхронизации
/// локальная библиотека целиком уедет на сервер.
class UuidMigrationV9 {
  final AppDatabase db;
  final Migrator migrator;

  const UuidMigrationV9({required this.db, required this.migrator});

  Future<void> run() async {
    final legacy = await _readLegacyData();

    await _dropLegacyTables();
    await migrator.createAll();

    await _writeGroups(legacy);
    await _writeTests(legacy);
    await _writeCards(legacy);
    await _writeEntries(legacy);

    await _rekeyQuestionStats();

    // active_sessions хранит JSON со старыми int-id внутри — восстановить
    // сессию после смены схемы нельзя, «продолжить последнюю» обнуляется.
    await db.customStatement('DELETE FROM active_sessions');
  }

  Future<_LegacyData> _readLegacyData() async {
    final groups = await _selectLegacy(
      'SELECT id, title, created_at, updated_at FROM test_groups',
    );
    final tests = await _selectLegacy(
      'SELECT id, title, description, type, created_at, updated_at FROM tests',
    );
    final cards = await _selectLegacy(
      'SELECT id, test_id, question, answer, created_at, updated_at FROM cards',
    );
    final entries = await db
        .customSelect('SELECT group_id, test_id FROM test_group_entries')
        .get();

    return _LegacyData(
      groups: groups,
      tests: tests,
      cards: cards,
      entries: entries
          .map(
            (row) => (
              groupId: row.read<int>('group_id'),
              testId: row.read<int>('test_id'),
            ),
          )
          .toList(),
      groupIds: _buildIdMap(groups),
      testIds: _buildIdMap(tests),
      cardIds: _buildIdMap(cards),
    );
  }

  Future<List<LegacyRow>> _selectLegacy(String sql) async {
    final rows = await db.customSelect('$sql ORDER BY created_at, id').get();
    return rows
        .map(
          (row) => (
            id: row.read<int>('id'),
            createdAt: row.read<int>('created_at'),
            data: row.data,
          ),
        )
        .toList();
  }

  /// Присваивает каждой строке uuid v7 с таймстемпом из `created_at`.
  ///
  /// Строки внутри одной секунды разносятся счётчиком по миллисекундам,
  /// чтобы порядок id остался детерминированным.
  Map<int, String> _buildIdMap(List<LegacyRow> rows) {
    final perSecond = <int, int>{};
    final result = <int, String>{};

    for (final row in rows) {
      final index = perSecond.update(
        row.createdAt,
        (value) => value + 1,
        ifAbsent: () => 0,
      );
      final millis =
          row.createdAt * Duration.millisecondsPerSecond + index % 1000;
      result[row.id] = UuidGenerator.v7At(
        DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true),
      );
    }

    return result;
  }

  Future<void> _dropLegacyTables() async {
    // Порядок обратный зависимостям: сначала связи, потом владельцы.
    for (final table in const [
      'test_group_entries',
      'cards',
      'tests',
      'test_groups',
    ]) {
      await db.customStatement('DROP TABLE IF EXISTS $table');
    }
  }

  Future<void> _writeGroups(_LegacyData legacy) async {
    await db.batch((batch) {
      for (final row in legacy.groups) {
        batch.insert(
          db.testGroups,
          TestGroupsCompanion.insert(
            id: legacy.groupIds[row.id]!,
            title: row.data['title']! as String,
            createdAt: _dateTime(row.data['created_at']),
            updatedAt: _dateTime(row.data['updated_at']),
            syncState: Value(SyncState.pending.dbValue),
          ),
        );
      }
    });
  }

  Future<void> _writeTests(_LegacyData legacy) async {
    await db.batch((batch) {
      for (final row in legacy.tests) {
        batch.insert(
          db.tests,
          TestsCompanion.insert(
            id: legacy.testIds[row.id]!,
            title: row.data['title']! as String,
            description: Value(row.data['description'] as String?),
            type: row.data['type']! as String,
            createdAt: _dateTime(row.data['created_at']),
            updatedAt: _dateTime(row.data['updated_at']),
            syncState: Value(SyncState.pending.dbValue),
          ),
        );
      }
    });
  }

  Future<void> _writeCards(_LegacyData legacy) async {
    await db.batch((batch) {
      for (final row in legacy.cards) {
        final legacyTestId = row.data['test_id'];
        final testId =
            legacyTestId is int ? legacy.testIds[legacyTestId] : null;
        // Карточка осиротевшего теста переносу не подлежит.
        if (testId == null) continue;

        final front = row.data['question']! as String;
        final answers = AnswerParser.parse(row.data['answer']! as String);

        batch.insert(
          db.cards,
          CardsCompanion.insert(
            id: legacy.cardIds[row.id]!,
            testId: testId,
            front: front,
            answers: AnswersCodec.encode(answers),
            questionKey: QuestionKeyNormalizer.normalize(front, answers),
            createdAt: _dateTime(row.data['created_at']),
            updatedAt: _dateTime(row.data['updated_at']),
            syncState: Value(SyncState.pending.dbValue),
          ),
        );
      }
    });
  }

  Future<void> _writeEntries(_LegacyData legacy) async {
    await db.batch((batch) {
      for (final entry in legacy.entries) {
        final groupId = legacy.groupIds[entry.groupId];
        final testId = legacy.testIds[entry.testId];
        if (groupId == null || testId == null) continue;

        batch.insert(
          db.testGroupEntries,
          TestGroupEntriesCompanion.insert(
            id: UuidGenerator.v7(),
            groupId: groupId,
            testId: testId,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
  }

  /// Пересчитывает `question_stats.question_key` под новую (серверную) формулу.
  ///
  /// Без этого вся накопленная статистика осиротеет: карточки будут считать
  /// ключ по новой формуле, а строки статистики останутся с ключами по старой.
  Future<void> _rekeyQuestionStats() async {
    final rows = await db
        .customSelect(
          'SELECT id, front_text, back_text FROM question_stats',
        )
        .get();

    final byNewKey = <String, List<int>>{};
    for (final row in rows) {
      final key = QuestionKeyNormalizer.normalizeRaw(
        row.read<String>('front_text'),
        row.read<String>('back_text'),
      );
      byNewKey.putIfAbsent(key, () => []).add(row.read<int>('id'));
    }

    for (final entry in byNewKey.entries) {
      await _applyNewKey(entry.key, entry.value);
    }
  }

  /// Ставит новый ключ первой строке группы, остальные сливает в неё.
  ///
  /// Коллизии по новой формуле теоретически невозможны (она нормализует
  /// слабее старой), но UNIQUE-индекс дороже перестраховки.
  Future<void> _applyNewKey(String key, List<int> ids) async {
    final target = ids.first;
    for (final duplicate in ids.skip(1)) {
      await db.customStatement(
        'UPDATE question_stats SET '
        'streak = MAX(streak, (SELECT streak FROM question_stats WHERE id = ?)), '
        'total_correct = total_correct + '
        '(SELECT total_correct FROM question_stats WHERE id = ?), '
        'total_incorrect = total_incorrect + '
        '(SELECT total_incorrect FROM question_stats WHERE id = ?), '
        'total_shown = total_shown + '
        '(SELECT total_shown FROM question_stats WHERE id = ?) '
        'WHERE id = ?',
        [duplicate, duplicate, duplicate, duplicate, target],
      );
      await db.customStatement(
        'DELETE FROM question_stats WHERE id = ?',
        [duplicate],
      );
    }
    await db.customStatement(
      'UPDATE question_stats SET question_key = ? WHERE id = ?',
      [key, target],
    );
  }

  static DateTime _dateTime(Object? raw) => switch (raw) {
        final int seconds =>
          DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: true),
        final String text => DateTime.tryParse(text) ?? DateTime.now().toUtc(),
        _ => DateTime.now().toUtc(),
      };
}

/// Снимок старых таблиц вместе с картами `int id` → `uuid`.
class _LegacyData {
  final List<LegacyRow> groups;
  final List<LegacyRow> tests;
  final List<LegacyRow> cards;
  final List<({int groupId, int testId})> entries;
  final Map<int, String> groupIds;
  final Map<int, String> testIds;
  final Map<int, String> cardIds;

  const _LegacyData({
    required this.groups,
    required this.tests,
    required this.cards,
    required this.entries,
    required this.groupIds,
    required this.testIds,
    required this.cardIds,
  });
}
