import 'package:json_annotation/json_annotation.dart';

/// Тип сущности в протоколе синхронизации.
enum SyncEntityType {
  @JsonValue('group')
  group('group'),

  @JsonValue('test')
  test('test'),

  @JsonValue('card')
  card('card'),

  /// Счётчики по вопросу. Сервер собирает их из журнала ответов, а клиент
  /// досылает свой агрегат: за историю до появления журнала событий нет.
  @JsonValue('stats')
  stats('stats'),

  /// Сейчас всегда приходит с `payload: null` — игнорируем.
  @JsonValue('test_session')
  testSession('test_session'),

  /// Неизвестный сервер-side тип: не падаем, просто пропускаем.
  unknown('');

  /// Значение в JSON.
  final String wireValue;

  const SyncEntityType(this.wireValue);
}

/// Операция над сущностью.
enum SyncOp {
  @JsonValue('upsert')
  upsert('upsert'),

  @JsonValue('delete')
  delete('delete'),

  /// Снятие soft-delete. Только `test` / `group`.
  @JsonValue('restore')
  restore('restore'),

  unknown('');

  /// Значение в JSON.
  final String wireValue;

  const SyncOp(this.wireValue);
}

/// Причина отклонения изменения при push.
enum SyncConflictReason {
  /// На сервере запись свежее.
  @JsonValue('server_newer')
  serverNewer,

  /// Upsert по soft-deleted сущности. Оживлять нужно через `restore`.
  @JsonValue('deleted')
  deleted,

  /// `restore` по записи, которой на сервере нет.
  @JsonValue('not_found')
  notFound,

  unknown,
}
