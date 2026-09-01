import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';

/// Локальное изменение, готовое к отправке.
class SyncDirtyChange {
  final SyncEntityType entity;
  final SyncOp op;
  final String id;

  /// Полный снимок сущности. `null` для `delete`.
  final Map<String, dynamic>? payload;

  /// Время локальной правки.
  final DateTime occurredAt;

  const SyncDirtyChange({
    required this.entity,
    required this.op,
    required this.id,
    required this.occurredAt,
    this.payload,
  });
}

/// Мост между таблицей фичи и движком синхронизации.
///
/// Каждая фича предоставляет свой адаптер и регистрирует его в app scope —
/// так модуль sync не тянет за собой все DAO приложения.
abstract interface class SyncEntityAdapter {
  /// Сущность протокола, за которую отвечает адаптер.
  SyncEntityType get entity;

  /// Локальные изменения, ожидающие отправки.
  ///
  /// Операция выводится из состояния строки: `deleted_at != null` — delete,
  /// иначе upsert. Отдельная очередь операций не нужна.
  Future<List<SyncDirtyChange>> collectDirty({required int limit});

  /// Есть ли по этому id неотправленная локальная правка.
  ///
  /// Движок не применяет входящий payload на pending-строку: после push
  /// клиент получает свои же изменения обратно, и эхо затрёт правку,
  /// сделанную между push и pull.
  Future<bool> isPending(String id);

  /// Применить серверный снимок.
  Future<void> applyUpsert(String id, Map<String, dynamic> payload);

  /// Применить серверное удаление.
  Future<void> applyDelete(String id);

  /// Подтвердить отправленный upsert.
  ///
  /// [payload] — снимок из `appliedItems`; если сервер его не прислал,
  /// строка просто помечается синхронизированной.
  Future<void> confirmUpsert(String id, Map<String, dynamic>? payload);

  /// Подтвердить отправленное удаление — строка убирается физически.
  Future<void> confirmDelete(String id);

  /// Убрать локальную запись, которой на сервере нет и не будет.
  Future<void> dropLocal(String id);

  /// Перезалить локальную версию как новую сущность (см. политику конфликтов).
  ///
  /// Осмысленно только для карточек; остальные адаптеры ничего не делают.
  Future<void> reuploadAsNew(String id, Map<String, dynamic> localPayload);
}
