import 'package:drift/drift.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:uuid/uuid.dart';

part 'answer_events_database.g.dart';

/// DAO для outbox событий ответов (отправка статистики на бэкенд).
@DriftAccessor(
  include: {
    'package:quizzerg/feature/question_stats/data/database/answer_events.drift',
  },
)
class AnswerEventsDatabase extends DatabaseAccessor<AppDatabase>
    with _$AnswerEventsDatabaseMixin {
  AnswerEventsDatabase(super.attachedDatabase);

  static const _uuid = Uuid();

  /// Записать событие ответа в outbox.
  Future<void> insertEvent({
    required String cardId,
    required String questionKey,
    required bool isCorrect,
    required DateTime answeredAt,
  }) =>
      into(answerEvents).insert(
        AnswerEventsCompanion.insert(
          id: _uuid.v4(),
          cardId: cardId,
          questionKey: questionKey,
          isCorrect: isCorrect,
          answeredAt: answeredAt,
        ),
      );

  /// Неотправленные события (старые первыми).
  Future<List<AnswerEventDatabaseDto>> getUnsentEvents({int limit = 500}) =>
      (select(answerEvents)
            ..where((e) => e.sent.equals(false))
            ..orderBy([(e) => OrderingTerm.asc(e.answeredAt)])
            ..limit(limit))
          .get();

  /// Пометить события отправленными.
  Future<void> markSent(List<String> ids) =>
      (update(answerEvents)..where((e) => e.id.isIn(ids)))
          .write(const AnswerEventsCompanion(sent: Value(true)));

  /// Удалить отправленные события (чистка outbox).
  Future<int> deleteSent() =>
      (delete(answerEvents)..where((e) => e.sent.equals(true))).go();

  /// Количество неотправленных событий.
  Future<int> getUnsentCount() async {
    final count = countAll();
    final query = selectOnly(answerEvents)
      ..addColumns([count])
      ..where(answerEvents.sent.equals(false));
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}
