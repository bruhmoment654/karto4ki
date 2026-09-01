import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/network/error/api_exception.dart';

/// Конфликт, о котором стоит сказать пользователю.
class SyncConflictReport {
  final SyncEntityType entity;
  final String id;
  final SyncConflictReason reason;

  const SyncConflictReport({
    required this.entity,
    required this.id,
    required this.reason,
  });
}

/// Итог одного прогона синхронизации.
class SyncRunResult {
  /// Сколько серверных изменений применено.
  final int pulled;

  /// Сколько локальных изменений принял сервер.
  final int pushed;

  /// Сколько ответов на карточки отправлено.
  final int answersSent;

  /// Конфликты, которые политика сочла достойными показа.
  final List<SyncConflictReport> conflicts;

  /// Ошибка, прервавшая прогон.
  final ApiException? error;

  /// Была ли это первичная загрузка (курсора ещё не было).
  final bool isBootstrap;

  bool get isSuccess => error == null;

  const SyncRunResult({
    this.pulled = 0,
    this.pushed = 0,
    this.answersSent = 0,
    this.conflicts = const [],
    this.error,
    this.isBootstrap = false,
  });
}
