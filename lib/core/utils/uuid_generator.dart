import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';

/// Генератор идентификаторов сущностей.
///
/// Все id сущностей — uuid v7: он упорядочен по времени, поэтому
/// сортировка по id совпадает с хронологической, а сервер принимает
/// клиентские id как есть (маппинг local↔remote не нужен).
abstract final class UuidGenerator {
  static const _uuid = Uuid();

  /// Новый идентификатор с текущим временем.
  static String v7() => _uuid.v7();

  /// Идентификатор с заданным моментом времени.
  ///
  /// Нужен при миграции: uuid, собранный из `created_at` старой строки,
  /// сохраняет исходный хронологический порядок записей.
  static String v7At(DateTime time) => _uuid.v7(
        config: V7Options(time.toUtc().millisecondsSinceEpoch, null),
      );
}
