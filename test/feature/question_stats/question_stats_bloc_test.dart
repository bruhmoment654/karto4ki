import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/bloc/question_stats_bloc.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_sort.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';
import 'package:rxdart/rxdart.dart';

/// Репозиторий статистики под управлением теста.
///
/// `BehaviorSubject`, а не голый контроллер: drift-стрим отдаёт текущее
/// состояние сразу при подписке, и блок рассчитывает именно на это.
class _FakeRepository implements IQuestionStatsRepository {
  final BehaviorSubject<void> changes = BehaviorSubject<void>.seeded(null);

  List<QuestionStatsEntity> stats = const [];

  /// Сколько раз экран перечитывал статистику.
  int readCount = 0;

  @override
  Stream<void> get statsChanges => changes.stream;

  Future<void> dispose() => changes.close();

  @override
  RequestOperation<List<QuestionStatsEntity>> getAllStats() async {
    readCount++;

    return Result.ok(stats);
  }

  @override
  RequestOperation<List<DateTime>> getActiveDates() async =>
      const Result.ok([]);

  @override
  RequestOperation<List<QuestionStatsEntity>> getLeastRemembered(int limit) =>
      getAllStats();

  @override
  RequestOperation<List<QuestionStatsEntity>> getStatsByKeys(
    List<String> keys,
  ) => getAllStats();

  @override
  RequestOperation<void> saveSessionResults({
    required List<CardResult> results,
    required List<CardEntity> cards,
  }) async => const Result.ok(null);
}

QuestionStatsEntity _stat(String front) => QuestionStatsEntity(
  id: front.hashCode,
  questionKey: front,
  frontText: front,
  backText: 'перевод',
  streak: 0,
  totalCorrect: 0,
  totalIncorrect: 0,
  totalShown: 0,
  createdAt: DateTime.utc(2026, 5, 17),
  updatedAt: DateTime.utc(2026, 5, 17),
);

void main() {
  late _FakeRepository repository;

  setUp(() => repository = _FakeRepository());

  tearDown(() => repository.dispose());

  /// Подписка живёт с дебаунсом — ждём чуть дольше него.
  Future<void> waitForReload() =>
      Future<void>.delayed(const Duration(milliseconds: 400));

  test('статистика из БД перечитывается без участия экрана', () async {
    repository.stats = [_stat('cat')];
    final bloc = QuestionStatsBloc(repository: repository)
      ..add(const QuestionStatsEvent.started());
    await waitForReload();

    // Так статистику наполняет pull синхронизации после входа в аккаунт.
    repository.stats = [_stat('cat'), _stat('dog')];
    repository.changes.add(null);
    await waitForReload();

    final state = bloc.state;
    expect(state, isA<QuestionStatsState$Loaded>());
    expect((state as QuestionStatsState$Loaded).stats.length, 2);

    await bloc.close();
  });

  test('перезагрузка сохраняет поиск и сортировку', () async {
    repository.stats = [_stat('cat'), _stat('dog')];
    final bloc = QuestionStatsBloc(repository: repository)
      ..add(const QuestionStatsEvent.started());
    await waitForReload();

    bloc
      ..add(
        const QuestionStatsEvent.sortChanged(sort: QuestionStatsSort.byStreak),
      )
      ..add(const QuestionStatsEvent.searchChanged(query: 'cat'));
    await waitForReload();

    repository.stats = [_stat('cat'), _stat('dog'), _stat('cathedral')];
    repository.changes.add(null);
    await waitForReload();

    final state = bloc.state as QuestionStatsState$Loaded;
    expect(state.sort, QuestionStatsSort.byStreak);
    expect(state.searchQuery, 'cat');
    expect(state.stats.map((it) => it.frontText), ['cat', 'cathedral']);
    // Спиннера между обновлениями быть не должно — экран не моргает.
    expect(state.hasAnyStats, isTrue);

    await bloc.close();
  });

  test('подписка отменяется вместе с блоком', () async {
    final bloc = QuestionStatsBloc(repository: repository)
      ..add(const QuestionStatsEvent.started());
    await waitForReload();
    final readsBeforeClose = repository.readCount;

    await bloc.close();
    repository.changes.add(null);
    await waitForReload();

    expect(repository.readCount, readsBeforeClose);
  });
}
