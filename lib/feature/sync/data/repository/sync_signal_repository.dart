import 'package:quizzerg/feature/sync/domain/repository/i_sync_signal_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Реализация [ISyncSignalRepository] на [BehaviorSubject].
///
/// Живёт в app scope: издателей много (все мутирующие блоки), подписчик
/// один — `SyncBloc`.
///
/// Subject, а не обычный broadcast-контроллер, ради реплея последнего
/// сигнала: `SyncBloc` подписывается в обработчике `started`, и правка,
/// сделанная до этого момента (например, CSV-импорт сразу после запуска),
/// на голом контроллере просто потерялась бы. Дубль сигнала безопасен —
/// прогон идемпотентен и всё равно идёт с дебаунсом.
///
/// Subject не засеян: на свежем запуске без правок сигнала нет, и лишнего
/// прогона тоже.
class SyncSignalRepository implements ISyncSignalRepository {
  final BehaviorSubject<void> _mutations = BehaviorSubject<void>();

  @override
  Stream<void> get localMutations => _mutations.stream;

  @override
  void notifyLocalMutation() {
    if (_mutations.isClosed) return;

    _mutations.add(null);
  }

  Future<void> close() => _mutations.close();
}
