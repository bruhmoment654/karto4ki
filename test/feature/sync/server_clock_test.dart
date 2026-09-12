import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/sync/domain/service/server_clock.dart';

void main() {
  group('ServerClock', () {
    test('на свежей установке сдвига нет', () {
      final clock = ServerClock();

      expect(clock.hasServerTime, isFalse);
      expect(clock.skew, Duration.zero);
    });

    test('сдвиг считается по serverTime', () {
      final clock = ServerClock();
      // Часы устройства уведены на три часа вперёд: серверное «сейчас»
      // на три часа меньше локального.
      final serverNow = DateTime.now().toUtc().subtract(const Duration(hours: 3));

      clock.syncWith(serverNow);

      expect(clock.hasServerTime, isTrue);
      expect(clock.skew.inMinutes, closeTo(-180, 1));
    });

    test('сразу после синхронизации относительная разница ~0', () {
      final clock = ServerClock();
      // Устройство спешит на три часа. Если бы дельту считали как
      // DateTime.now() - lastSyncedAt, вышло бы «3 часа назад».
      final lastSyncedAt =
          DateTime.now().toUtc().subtract(const Duration(hours: 3));
      clock.syncWith(lastSyncedAt);

      final elapsed = clock.now().difference(lastSyncedAt);

      expect(elapsed.inSeconds, lessThan(2));
    });

    test('restore поднимает сдвиг после холодного старта', () {
      final clock = ServerClock()..restore(const Duration(minutes: -42));

      expect(clock.hasServerTime, isTrue);
      expect(
        clock.now().difference(DateTime.now().toUtc()).inMinutes,
        closeTo(-42, 1),
      );
    });
  });
}
