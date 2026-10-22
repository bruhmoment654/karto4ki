import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/feature/question_stats/data/dto/question_stats_dto.dart';
import 'package:quizzerg/feature/question_stats/domain/util/stats_remote_id.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_clock.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_entity_adapter.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Адаптер статистики.
///
/// Счётчики ходят в обе стороны, но не как обычная сущность: сервер их
/// не перезаписывает, а сливает с тем, что уже знает сам из журнала
/// ответов. Иначе история, накопленная до появления журнала (и всё, что
/// приехало из бэкапа старой версии), не попала бы на сервер никогда —
/// событий за неё не существует, есть только агрегат.
class StatsSyncAdapter implements SyncEntityAdapter {
  final QuestionStatsDatabase _questionStatsDatabase;

  /// `id` → `questionKey` для строк, отданных последним [collectDirty].
  ///
  /// Нужен для подтверждения: id выводится из ключа в одну сторону, а сервер
  /// может ответить без снимка — движок в этом случае зовёт [confirmUpsert]
  /// с `null`, и без карты строка осталась бы неотправленной навсегда.
  final Map<String, String> _pushedKeys = {};

  StatsSyncAdapter({
    required QuestionStatsDatabase questionStatsDatabase,
  }) : _questionStatsDatabase = questionStatsDatabase;

  @override
  SyncEntityType get entity => SyncEntityType.stats;

  @override
  Future<List<SyncDirtyChange>> collectDirty({required int limit}) async {
    final rows = await _questionStatsDatabase.getPendingStats(limit: limit);

    _pushedKeys
      ..clear()
      ..addEntries(
        rows.map(
          (row) => MapEntry(StatsRemoteId.of(row.questionKey), row.questionKey),
        ),
      );

    return rows.map(_toChange).toList();
  }

  @override
  Future<int> countDirty() => _questionStatsDatabase.countPendingStats();

  /// Всегда `false`: серверный снимок сливается, а не перезаписывает, поэтому
  /// защищать неотправленную строку от входящего payload не нужно — слияние
  /// местные счётчики только поднимает.
  @override
  Future<bool> isPending(String id) async => false;

  @override
  Future<void> applyUpsert(String id, Map<String, dynamic> payload) async {
    final dto = QuestionStatsDto.fromJson(payload);

    await _questionStatsDatabase.applyServerSnapshot(
      questionKey: dto.questionKey,
      frontText: dto.frontText,
      backText: dto.backText,
      streak: dto.streak,
      totalCorrect: dto.totalCorrect,
      totalIncorrect: dto.totalIncorrect,
      totalShown: dto.totalShown,
      lastAnsweredAt: dto.lastAnsweredAt,
      lastShownAt: dto.lastShownAt,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  @override
  Future<void> applyDelete(String id) async {
    // Удаление статистики сервер не шлёт; локально чистить нечего.
  }

  /// Сервер принял счётчики — строка синхронизирована.
  ///
  /// Снимок из `appliedItems` не применяем: он уже слит на сервере и
  /// приедет обычным pull. Применить его здесь значило бы во второй раз
  /// пройти слияние и на ровном месте вернуть строку в pending.
  @override
  Future<void> confirmUpsert(String id, Map<String, dynamic>? payload) async {
    final fromPayload = payload?['questionKey'];
    final key = fromPayload is String ? fromPayload : _pushedKeys[id];
    if (key == null) return;

    await _questionStatsDatabase.markSynced(key);
  }

  @override
  Future<void> confirmDelete(String id) async {}

  @override
  Future<void> dropLocal(String id) async {}

  @override
  Future<void> reuploadAsNew(
    String id,
    Map<String, dynamic> localPayload,
  ) async {}

  /// Повторная отправка счётчиков безопасна: сервер сливает их по максимуму.
  @override
  Future<void> replaceSyncState(SyncState from, SyncState to) =>
      _questionStatsDatabase.replaceSyncState(from, to);

  SyncDirtyChange _toChange(QuestionStatsDatabaseDto row) => SyncDirtyChange(
        entity: entity,
        op: SyncOp.upsert,
        id: StatsRemoteId.of(row.questionKey),
        occurredAt: row.updatedAt.toUtc(),
        payload: {
          'id': StatsRemoteId.of(row.questionKey),
          'questionKey': row.questionKey,
          'frontText': row.frontText,
          'backText': row.backText,
          'streak': row.streak,
          'totalCorrect': row.totalCorrect,
          'totalIncorrect': row.totalIncorrect,
          'totalShown': row.totalShown,
          'lastAnsweredAt': _formatOrNull(row.lastAnsweredAt),
          'lastShownAt': _formatOrNull(row.lastShownAt),
          'createdAt': SyncClock.format(row.createdAt),
          'updatedAt': SyncClock.format(row.updatedAt),
        },
      );

  String? _formatOrNull(DateTime? value) =>
      value == null ? null : SyncClock.format(value);
}
