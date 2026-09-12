import 'dart:math';

import 'package:quizzerg/feature/sync/domain/entity/sync_progress.dart';

/// Прогресс первичной загрузки, посчитанный только по серверному `remaining`.
///
/// `remaining` — число событий журнала с `id > nextCursor`, то есть строго
/// за пределами уже отданного. Соблазн взять `applied / (applied + remaining)`
/// надо давить: `applied` — компактированные сущности, `remaining` — сырые
/// события, и после компакции одно в другое не переводится.
///
/// `remaining` по ходу загрузки реально растёт: наши же ответы на карточки,
/// второй источник записи (CSV-импорт, второе устройство), плюс `READ
/// COMMITTED` на сервере — идеального снапшота не бывает. Новые события
/// расширяют знаменатель, а не откатывают полосу в нуль.
class SyncPullProgress {
  int? _total;
  int? _previousRemaining;
  double _shown = 0;

  /// Учесть `remaining` из очередной страницы.
  ///
  /// `null`, пока сервер не отдаёт `remaining` (сборка до C11) — тогда
  /// полоса неопределённая, а подпись без цифр.
  SyncProgress? update(int? remaining) {
    if (remaining == null) return null;

    final previous = _previousRemaining;
    var total = _total ?? remaining;
    if (previous != null && remaining > previous) {
      total += remaining - previous;
    }

    _total = total;
    _previousRemaining = remaining;

    final done = total - remaining;
    // Знаменатель честный, поэтому доля может проседать (0.20 → 0.18 при
    // росте remaining на 10%). Глазу показываем неубывающую полосу.
    _shown = max(_shown, total == 0 ? 1 : done / total);

    return SyncProgress(value: _shown, done: done, total: total);
  }
}
