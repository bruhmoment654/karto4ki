import 'package:quizzerg/feature/sync/data/dto/sync_push_dto.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';

/// Что сделать с отвергнутым сервером изменением.
enum ConflictAction {
  /// Принять серверную версию и пометить строку синхронизированной.
  acceptServer,

  /// Принять серверную версию, а локальный текст залить новой сущностью.
  acceptServerAndReupload,

  /// Записи на сервере нет и не будет — убрать локальную.
  dropLocal,

  /// Ничего не делать, строка останется неотправленной до следующего раза.
  keepPending,
}

/// Решение по конфликту.
class ConflictDecision {
  final ConflictAction action;

  /// Показывать ли конфликт пользователю и писать ли в лог.
  ///
  /// Эхо собственного push (ответ потерялся в сети, а запись прошла)
  /// конфликтом не является — иначе на флапающей сети пользователь
  /// утонет в ложных сообщениях.
  final bool shouldReport;

  const ConflictDecision({required this.action, required this.shouldReport});
}

/// Разрешение конфликтов: Last-Write-Wins по `updatedAt`, без версий и merge.
///
/// Приложение рассчитано на одного человека с одним устройством, поэтому
/// экранов выбора версий и diff-вью нет.
abstract final class ConflictPolicy {
  /// Поля, которые считает сервер, — в сравнении не участвуют.
  static const _serverComputedFields = {
    'questionKey',
    'questionCount',
    'testCount',
  };

  /// Решение по конфликту [conflict] для отправленного [pushedPayload].
  static ConflictDecision resolve({
    required SyncConflictDto conflict,
    Map<String, dynamic>? pushedPayload,
  }) {
    return switch (conflict.reason) {
      SyncConflictReason.serverNewer => _resolveServerNewer(
          conflict: conflict,
          pushedPayload: pushedPayload,
        ),
      SyncConflictReason.deleted ||
      SyncConflictReason.notFound =>
        const ConflictDecision(
          action: ConflictAction.dropLocal,
          shouldReport: true,
        ),
      // Неизвестная причина: не разрушаем локальные данные, попробуем позже.
      SyncConflictReason.unknown => const ConflictDecision(
          action: ConflictAction.keepPending,
          shouldReport: true,
        ),
    };
  }

  static ConflictDecision _resolveServerNewer({
    required SyncConflictDto conflict,
    required Map<String, dynamic>? pushedPayload,
  }) {
    final server = conflict.server;

    // Правило 1: серверная копия совпала с тем, что мы пушили, — значит
    // push реально прошёл, а ответ потерялся в сети. Это не конфликт.
    if (server != null &&
        pushedPayload != null &&
        payloadsMatch(pushed: pushedPayload, server: server)) {
      return const ConflictDecision(
        action: ConflictAction.acceptServer,
        shouldReport: false,
      );
    }

    // Карточку не теряем: локальный текст поедет новой карточкой,
    // дубли на сервере чистятся дедупом по (front, answers).
    if (conflict.entity == SyncEntityType.card) {
      return const ConflictDecision(
        action: ConflictAction.acceptServerAndReupload,
        shouldReport: false,
      );
    }

    return const ConflictDecision(
      action: ConflictAction.acceptServer,
      shouldReport: true,
    );
  }

  /// Совпадает ли серверный снимок с отправленным.
  ///
  /// Служебные и вычисляемые сервером поля игнорируются, даты сравниваются
  /// как моменты времени, а не как строки.
  static bool payloadsMatch({
    required Map<String, dynamic> pushed,
    required Map<String, dynamic> server,
  }) {
    final keys = pushed.keys
        .where((key) => !_serverComputedFields.contains(key))
        .where((key) => key != 'updatedAt');

    for (final key in keys) {
      // Набор групп — множество, порядок сервер не гарантирует.
      if (key == 'groupIds') {
        if (!_setsMatch(pushed[key], server[key])) return false;
        continue;
      }
      if (!_valuesMatch(pushed[key], server[key])) return false;
    }

    return true;
  }

  static bool _setsMatch(Object? left, Object? right) {
    if (left is! List || right is! List) return left == right;

    final leftSet = left.map((it) => it.toString()).toSet();
    final rightSet = right.map((it) => it.toString()).toSet();

    return leftSet.length == rightSet.length && leftSet.containsAll(rightSet);
  }

  static bool _valuesMatch(Object? left, Object? right) {
    if (left is String && right is String) {
      final leftDate = DateTime.tryParse(left);
      final rightDate = DateTime.tryParse(right);
      if (leftDate != null && rightDate != null) {
        return leftDate.isAtSameMomentAs(rightDate);
      }

      return left == right;
    }

    if (left is List && right is List) {
      if (left.length != right.length) return false;

      for (var index = 0; index < left.length; index++) {
        if (!_valuesMatch(left[index], right[index])) return false;
      }

      return true;
    }

    return left == right;
  }
}
