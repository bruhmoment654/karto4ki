import 'package:quizzerg/feature/question_stats/data/database/question_stats_database.dart';
import 'package:quizzerg/feature/question_stats/data/dto/question_stats_dto.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_entity_adapter.dart';

/// Адаптер статистики. Только на чтение: счётчики формирует сервер
/// из `POST /stats/answers/batch`, локально их пушить нечем.
class StatsSyncAdapter implements SyncEntityAdapter {
  final QuestionStatsDatabase _questionStatsDatabase;

  const StatsSyncAdapter({
    required QuestionStatsDatabase questionStatsDatabase,
  }) : _questionStatsDatabase = questionStatsDatabase;

  @override
  SyncEntityType get entity => SyncEntityType.stats;

  @override
  Future<List<SyncDirtyChange>> collectDirty({required int limit}) async =>
      const [];

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

  @override
  Future<void> confirmUpsert(String id, Map<String, dynamic>? payload) async {}

  @override
  Future<void> confirmDelete(String id) async {}

  @override
  Future<void> dropLocal(String id) async {}

  @override
  Future<void> reuploadAsNew(
    String id,
    Map<String, dynamic> localPayload,
  ) async {}
}
