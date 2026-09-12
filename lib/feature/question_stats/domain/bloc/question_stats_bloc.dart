import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizzerg/core/bloc/event_transformers.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/core/feature/core/failures/unknown_failure.dart';
import 'package:quizzerg/core/utils/answer_parser.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_sort.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'question_stats_bloc.freezed.dart';
part 'question_stats_event.dart';
part 'question_stats_state.dart';

/// Задержка поиска: пользователь дописывает слово, а не ищет по каждой букве.
const _searchDebounce = Duration(milliseconds: 200);

/// Задержка перечитывания после правки БД: pull синхронизации пишет строки
/// пачками, перезагружать список на каждую нет смысла.
const _changesDebounce = Duration(milliseconds: 300);

/// BLoC экрана статистики вопросов: загрузка, поиск и сортировка.
final class QuestionStatsBloc
    extends Bloc<QuestionStatsEvent, QuestionStatsState> {
  final IQuestionStatsRepository _repository;

  /// Полный список из репозитория. Фильтрация и сортировка считаются от него.
  List<QuestionStatsEntity> _rawStats = const [];

  StreamSubscription<void>? _changesSubscription;

  QuestionStatsBloc({required IQuestionStatsRepository repository})
      : _repository = repository,
        super(const QuestionStatsState.loading()) {
    on<_QuestionStatsEvent$Started>(_onStarted);
    on<_QuestionStatsEvent$SortChanged>(_onSortChanged);
    on<_QuestionStatsEvent$SortOrderToggled>(_onSortOrderToggled);
    on<_QuestionStatsEvent$SearchChanged>(
      _onSearchChanged,
      transformer: debounce(_searchDebounce),
    );
    on<_QuestionStatsEvent$SearchCleared>(_onSearchCleared);

    // Статистику пишет не только этот экран: она приезжает pull'ом
    // синхронизации после входа в аккаунт. Без подписки список остался бы
    // тем, что прочитали при создании таба.
    _changesSubscription = _repository.statsChanges
        .skip(1)
        .debounceTime(_changesDebounce)
        .listen((_) => add(const QuestionStatsEvent.started()));
  }

  @override
  Future<void> close() async {
    await _changesSubscription?.cancel();

    return super.close();
  }

  Future<void> _onStarted(
    _QuestionStatsEvent$Started event,
    Emitter<QuestionStatsState> emit,
  ) async {
    // Перезагрузка по изменению БД не должна сбрасывать экран в спиннер и
    // терять поиск с сортировкой — они переносятся в новое состояние.
    final previous = state;
    final base = previous is QuestionStatsState$Loaded ? previous : null;
    if (base == null) emit(const QuestionStatsState.loading());

    final result = await _repository.getAllStats();
    switch (result) {
      case ResultOk(:final data):
        _rawStats = data;
        emit(_buildLoaded(base: base));
      case ResultFailed(:final error, :final stackTrace):
        emit(QuestionStatsState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  void _onSortChanged(
    _QuestionStatsEvent$SortChanged event,
    Emitter<QuestionStatsState> emit,
  ) {
    if (state case final QuestionStatsState$Loaded loaded) {
      if (loaded.sort == event.sort) return;
      // Смена критерия сбрасывает направление — так же, как было до BLoC.
      emit(_buildLoaded(
        base: loaded,
        sort: event.sort,
        order: SortOrder.ascending,
      ));
    }
  }

  void _onSortOrderToggled(
    _QuestionStatsEvent$SortOrderToggled event,
    Emitter<QuestionStatsState> emit,
  ) {
    if (state case final QuestionStatsState$Loaded loaded) {
      emit(_buildLoaded(
        base: loaded,
        order: loaded.order == SortOrder.ascending
            ? SortOrder.descending
            : SortOrder.ascending,
      ));
    }
  }

  void _onSearchChanged(
    _QuestionStatsEvent$SearchChanged event,
    Emitter<QuestionStatsState> emit,
  ) {
    if (state case final QuestionStatsState$Loaded loaded) {
      emit(_buildLoaded(base: loaded, searchQuery: event.query));
    }
  }

  void _onSearchCleared(
    _QuestionStatsEvent$SearchCleared event,
    Emitter<QuestionStatsState> emit,
  ) {
    if (state case final QuestionStatsState$Loaded loaded) {
      emit(_buildLoaded(base: loaded, searchQuery: ''));
    }
  }

  QuestionStatsState$Loaded _buildLoaded({
    QuestionStatsState$Loaded? base,
    QuestionStatsSort? sort,
    SortOrder? order,
    String? searchQuery,
  }) {
    final effectiveSort = sort ?? base?.sort ?? QuestionStatsSort.byDate;
    final effectiveOrder = order ?? base?.order ?? SortOrder.descending;
    final effectiveQuery = searchQuery ?? base?.searchQuery ?? '';

    return QuestionStatsState$Loaded(
      stats: _sorted(_filtered(effectiveQuery), effectiveSort, effectiveOrder),
      hasAnyStats: _rawStats.isNotEmpty,
      sort: effectiveSort,
      order: effectiveOrder,
      searchQuery: effectiveQuery,
    );
  }

  /// Универсальный поиск: совпадение ищется в написании/вопросе и КАЖДОМ
  /// варианте перевода (ответы разбираются [AnswerParser]).
  List<QuestionStatsEntity> _filtered(String searchQuery) {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return _rawStats;
    return _rawStats.where((stat) => _matches(stat, query)).toList();
  }

  bool _matches(QuestionStatsEntity stat, String query) {
    final haystack = <String>[
      stat.frontText,
      ...AnswerParser.parse(stat.backText),
    ];
    return haystack.any((it) => it.toLowerCase().contains(query));
  }

  List<QuestionStatsEntity> _sorted(
    List<QuestionStatsEntity> stats,
    QuestionStatsSort sort,
    SortOrder order,
  ) {
    return List<QuestionStatsEntity>.of(stats)
      ..sort((a, b) {
        final cmp = switch (sort) {
          QuestionStatsSort.byDate => a.updatedAt.compareTo(b.updatedAt),
          QuestionStatsSort.byStreak => a.streak.compareTo(b.streak),
          QuestionStatsSort.byAccuracy => _accuracy(a).compareTo(_accuracy(b)),
        };
        return order == SortOrder.ascending ? cmp : -cmp;
      });
  }

  double _accuracy(QuestionStatsEntity stat) {
    final total = stat.totalCorrect + stat.totalIncorrect;
    if (total == 0) return 0;
    return stat.totalCorrect / total;
  }
}
