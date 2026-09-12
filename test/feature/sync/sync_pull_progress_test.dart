import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_pull_progress.dart';

void main() {
  group('SyncPullProgress', () {
    test('без remaining прогресс неизвестен', () {
      final progress = SyncPullProgress();

      expect(progress.update(null), isNull);
    });

    test('первая страница задаёт знаменатель', () {
      final progress = SyncPullProgress();

      final first = progress.update(1000);

      expect(first?.total, 1000);
      expect(first?.done, 0);
      expect(first?.value, 0);
    });

    test('прогресс растёт по мере убывания remaining', () {
      final progress = SyncPullProgress()..update(1000);

      final step = progress.update(400);

      expect(step?.done, 600);
      expect(step?.total, 1000);
      expect(step?.value, closeTo(0.6, 0.001));
    });

    test('выросший remaining расширяет знаменатель, а не откатывает полосу',
        () {
      // Во время bootstrap появились новые события: наши ответы на карточки,
      // второе устройство, CSV-импорт.
      final progress = SyncPullProgress()
        ..update(1000)
        ..update(500);
      final before = progress.update(500)!.value;

      final grown = progress.update(600)!;

      expect(grown.total, 1100, reason: 'знаменатель честно вырос');
      // Доля просела бы (0.5 → 0.45), но показанное значение не убывает.
      expect(grown.value, greaterThanOrEqualTo(before));
    });

    test('нулевой remaining — это 100%', () {
      final progress = SyncPullProgress()..update(50);

      expect(progress.update(0)?.value, 1);
    });

    test('пустой журнал не делит на ноль', () {
      final progress = SyncPullProgress();

      expect(progress.update(0)?.value, 1);
    });
  });
}
