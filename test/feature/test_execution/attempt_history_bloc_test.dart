import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/attempt_history_bloc.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_history_usage.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/test_execution/domain/repository/i_test_attempt_repository.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';

const _usage = AttemptHistoryUsage(bytes: 1200000);

/// Репозиторий, очистку которого тест завершает сам через [clearing].
class _FakeRepository implements ITestAttemptRepository {
  Result<AttemptHistoryUsage, Object> usage = const Result.ok(_usage);

  Completer<Result<AttemptHistoryUsage, Object>> clearing = Completer();

  int clearCalls = 0;

  @override
  RequestOperation<AttemptHistoryUsage> getHistoryUsage() async => usage;

  @override
  RequestOperation<AttemptHistoryUsage> clearHistory() {
    clearCalls++;

    return clearing.future;
  }

  @override
  RequestOperation<AttemptSummary> recordAttempt(
    TestSession session, {
    required bool mixup,
    required bool swapSides,
  }) => throw UnimplementedError();
}

void main() {
  late _FakeRepository repository;
  late AttemptHistoryBloc bloc;

  setUp(() {
    repository = _FakeRepository();
    bloc = AttemptHistoryBloc(repository: repository);
  });

  tearDown(() => bloc.close());

  Future<AttemptHistoryState$Loaded> started() async {
    bloc.add(const AttemptHistoryEvent.started());

    return await bloc.stream.firstWhere(
          (state) => state is AttemptHistoryState$Loaded,
        )
        as AttemptHistoryState$Loaded;
  }

  test('started: загрузка → размер', () async {
    expect(bloc.state, const AttemptHistoryState.loading());

    final state = await started();

    expect(state.usage, _usage);
    expect(state.isClearing, isFalse);
    expect(state.clearResult, isNull);
  });

  test('started: размер не посчитался — очистка всё равно доступна', () async {
    repository.usage = Result.failed(Exception('db'), StackTrace.empty);

    final state = await started();

    expect(state.usage, isNull);
    expect(state.isClearing, isFalse);
  });

  test('очистка: прогресс → пусто и результат для снека', () async {
    await started();
    final states = <AttemptHistoryState>[];
    final subscription = bloc.stream.listen(states.add);

    bloc.add(const AttemptHistoryEvent.clearRequested());
    await pumpEventQueue();
    repository.clearing.complete(const Result.ok(AttemptHistoryUsage.empty));
    await pumpEventQueue();
    await subscription.cancel();

    expect(states, hasLength(2));
    final clearing = states.first as AttemptHistoryState$Loaded;
    expect(clearing.isClearing, isTrue);
    expect(clearing.usage, _usage);

    final cleared = states.last as AttemptHistoryState$Loaded;
    expect(cleared.isClearing, isFalse);
    expect(cleared.usage, AttemptHistoryUsage.empty);
    expect(cleared.clearResult?.value, AttemptHistoryClearResult.cleared);
  });

  test('повторная очистка во время очистки игнорируется', () async {
    await started();

    bloc
      ..add(const AttemptHistoryEvent.clearRequested())
      ..add(const AttemptHistoryEvent.clearRequested());
    await pumpEventQueue();
    repository.clearing.complete(const Result.ok(AttemptHistoryUsage.empty));
    await pumpEventQueue();

    expect(repository.clearCalls, 1);
  });

  test('очистка упала: ошибка для снека и пересчитанный размер', () async {
    await started();
    const remaining = AttemptHistoryUsage(bytes: 4096);
    repository.usage = const Result.ok(remaining);

    bloc.add(const AttemptHistoryEvent.clearRequested());
    await pumpEventQueue();
    repository.clearing.complete(
      Result.failed(Exception('disk full'), StackTrace.empty),
    );
    await pumpEventQueue();

    final state = bloc.state as AttemptHistoryState$Loaded;
    expect(state.isClearing, isFalse);
    expect(state.usage, remaining);
    expect(state.clearResult?.value, AttemptHistoryClearResult.failed);
  });

  test('до загрузки размера очистка не запускается', () async {
    bloc.add(const AttemptHistoryEvent.clearRequested());
    await pumpEventQueue();

    expect(repository.clearCalls, 0);
    expect(bloc.state, const AttemptHistoryState.loading());
  });
}
