import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_push_dto.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/feature/sync/domain/service/conflict_policy.dart';

SyncConflictDto _conflict({
  SyncEntityType entity = SyncEntityType.test,
  SyncConflictReason reason = SyncConflictReason.serverNewer,
  Map<String, dynamic>? server,
}) =>
    SyncConflictDto(
      entity: entity,
      id: 'id-1',
      reason: reason,
      server: server,
    );

void main() {
  group('ConflictPolicy.payloadsMatch', () {
    test('updatedAt не участвует в сравнении', () {
      expect(
        ConflictPolicy.payloadsMatch(
          pushed: {
            'id': 'a',
            'title': 'T',
            'updatedAt': '2026-01-01T00:00:00.000Z'
          },
          server: {
            'id': 'a',
            'title': 'T',
            'updatedAt': '2026-02-02T00:00:00.000Z'
          },
        ),
        isTrue,
      );
    });

    test('вычисляемые сервером поля игнорируются', () {
      expect(
        ConflictPolicy.payloadsMatch(
          pushed: {'id': 'a', 'front': 'q', 'questionCount': 0},
          server: {'id': 'a', 'front': 'q', 'questionCount': 42},
        ),
        isTrue,
      );
    });

    test('даты сравниваются как моменты, а не как строки', () {
      expect(
        ConflictPolicy.payloadsMatch(
          pushed: {'createdAt': '2026-01-01T10:00:00.000Z'},
          server: {'createdAt': '2026-01-01T13:00:00.000+03:00'},
        ),
        isTrue,
      );
    });

    test('groupIds сравниваются как множество', () {
      expect(
        ConflictPolicy.payloadsMatch(
          pushed: {
            'groupIds': ['a', 'b']
          },
          server: {
            'groupIds': ['b', 'a']
          },
        ),
        isTrue,
      );
    });

    test('порядок вариантов ответа значим', () {
      expect(
        ConflictPolicy.payloadsMatch(
          pushed: {
            'answers': ['a', 'b']
          },
          server: {
            'answers': ['b', 'a']
          },
        ),
        isFalse,
      );
    });

    test('различие содержимого ловится', () {
      expect(
        ConflictPolicy.payloadsMatch(
          pushed: {'title': 'Локальный'},
          server: {'title': 'Серверный'},
        ),
        isFalse,
      );
    });
  });

  group('ConflictPolicy.resolve', () {
    test('эхо собственного push принимается молча', () {
      final decision = ConflictPolicy.resolve(
        conflict: _conflict(
          server: {
            'id': 'id-1',
            'title': 'T',
            'updatedAt': '2026-02-02T00:00:00.000Z'
          },
        ),
        pushedPayload: {
          'id': 'id-1',
          'title': 'T',
          'updatedAt': '2026-01-01T00:00:00.000Z'
        },
      );

      expect(decision.action, ConflictAction.acceptServer);
      expect(decision.shouldReport, isFalse);
    });

    test('расхождение по тесту — принять сервер и сообщить', () {
      final decision = ConflictPolicy.resolve(
        conflict: _conflict(server: {'id': 'id-1', 'title': 'Серверный'}),
        pushedPayload: {'id': 'id-1', 'title': 'Локальный'},
      );

      expect(decision.action, ConflictAction.acceptServer);
      expect(decision.shouldReport, isTrue);
    });

    test('расхождение по карточке — локальный текст заливается заново', () {
      final decision = ConflictPolicy.resolve(
        conflict: _conflict(
          entity: SyncEntityType.card,
          server: {'id': 'id-1', 'front': 'Серверный'},
        ),
        pushedPayload: {'id': 'id-1', 'front': 'Локальный'},
      );

      expect(decision.action, ConflictAction.acceptServerAndReupload);
    });

    test('deleted — локальную запись убираем', () {
      final decision = ConflictPolicy.resolve(
        conflict: _conflict(reason: SyncConflictReason.deleted),
      );

      expect(decision.action, ConflictAction.dropLocal);
    });

    test('not_found — локальную запись убираем', () {
      final decision = ConflictPolicy.resolve(
        conflict: _conflict(reason: SyncConflictReason.notFound),
      );

      expect(decision.action, ConflictAction.dropLocal);
    });

    test('неизвестная причина ничего не разрушает', () {
      final decision = ConflictPolicy.resolve(
        conflict: _conflict(reason: SyncConflictReason.unknown),
      );

      expect(decision.action, ConflictAction.keepPending);
    });
  });
}
