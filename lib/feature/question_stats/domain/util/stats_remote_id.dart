import 'package:uuid/uuid.dart';

/// Идентификатор строки статистики в протоколе синхронизации.
///
/// Локально статистика лежит под автоинкрементным `id`, а протокол требует
/// uuid. Заводить собственную колонку под удалённый id не нужно: uuid v5
/// выводится из `question_key`, поэтому он одинаков на всех устройствах и
/// не меняется между push. Сервер сопоставляет строку по `question_key`,
/// так что даже расхождение с его собственным id безопасно.
abstract final class StatsRemoteId {
  static const _uuid = Uuid();

  /// Пространство имён — константа проекта, не RFC-namespace: она лишь
  /// разводит одинаковые ключи разных сущностей.
  static const _namespace = 'd6b0f4d2-3c1f-4a5e-9f3b-8f0c7a1e5d24';

  /// Идентификатор для вопроса с ключом [questionKey].
  static String of(String questionKey) => _uuid.v5(_namespace, questionKey);
}
