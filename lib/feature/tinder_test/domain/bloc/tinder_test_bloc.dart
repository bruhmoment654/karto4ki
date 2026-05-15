import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_card_repository.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_session_launch_params.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/feature/test_execution/domain/repository/i_active_session_repository.dart';
import 'package:quizzerg/feature/tests_list/domain/repository/i_tests_list_repository.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/i_question_mixup_service.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';

part 'tinder_test_event.dart';
part 'tinder_test_state.dart';
part 'tinder_test_bloc.freezed.dart';

/// BLoC for tinder-style test execution.
///
/// Manages the test session, card swiping, and result tracking.
final class TinderTestBloc extends Bloc<TinderTestEvent, TinderTestState> {
  final ICardRepository _cardRepository;
  final IQuestionStatsRepository _questionStatsRepository;
  final IQuestionMixupService? _mixupService;
  final IActiveSessionRepository _activeSessionRepository;
  final ITestsListRepository _testsListRepository;
  final MixupAlgorithm _algorithm;
  bool _swapSides = false;
  int _answerIndex = 0;
  bool _mixup = false;
  int _mixupMin = 1;
  int _mixupMax = 5;
  String _testTitle = '';

  TinderTestBloc({
    required ICardRepository cardRepository,
    required IQuestionStatsRepository questionStatsRepository,
    required IActiveSessionRepository activeSessionRepository,
    required ITestsListRepository testsListRepository,
    required MixupAlgorithm algorithm,
    IQuestionMixupService? mixupService,
  })  : _cardRepository = cardRepository,
        _questionStatsRepository = questionStatsRepository,
        _mixupService = mixupService,
        _activeSessionRepository = activeSessionRepository,
        _testsListRepository = testsListRepository,
        _algorithm = algorithm,
        super(const TinderTestState.initial()) {
    on<TinderTestEvent>(
      (event, emit) => switch (event) {
        _TinderTestEvent$Started() => _onStarted(event, emit),
        _TinderTestEvent$SwipedLeft() => _onSwipedLeft(event, emit),
        _TinderTestEvent$SwipedRight() => _onSwipedRight(event, emit),
        _TinderTestEvent$Completed() => _onCompleted(event, emit),
        _TinderTestEvent$Restarted() => _onRestarted(event, emit),
        _TinderTestEvent$Discard() => _onDiscard(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _TinderTestEvent$Started event,
    Emitter<TinderTestState> emit,
  ) async {
    emit(const TinderTestState.loading());

    if (event.resume) {
      final restored = await _tryRestoreSession(event.testId, emit);
      if (restored) return;
    }

    _swapSides = event.swapSides;
    _answerIndex = event.answerIndex;
    _mixup = event.mixup;
    _mixupMin = event.mixupMin;
    _mixupMax = event.mixupMax;

    final titleResult = await _testsListRepository.getTestById(event.testId);
    _testTitle = titleResult.dataOrNull?.title ?? '';

    final result = await _cardRepository.getCardsByTestId(event.testId);
    switch (result) {
      case ResultOk(:final data):
        if (data.isEmpty) {
          emit(const TinderTestState.empty());
          return;
        }

        var cards = data;

        if (_mixup && _mixupService != null) {
          final mixupCards = await _mixupService.getMixupCards(
            testId: event.testId,
            mainCards: cards,
            mixupMin: _mixupMin,
            mixupMax: _mixupMax,
          );
          cards = [...cards, ...mixupCards];
        }

        if (_swapSides) {
          cards = cards.map((card) {
            final idx = _answerIndex.clamp(0, card.answers.length - 1);
            final newFront = card.answers[idx];
            final remainingAnswers = [
              card.front,
              for (var i = 0; i < card.answers.length; i++)
                if (i != idx) card.answers[i],
            ];
            return card.copyWith(front: newFront, answers: remainingAnswers);
          }).toList();
        }

        final session = _createSession(event.testId, cards);
        emit(TinderTestState.inProgress(
          session: session,
          currentCard: session.currentCard!,
        ));
        unawaited(_persistSession(session));
      case ResultFailed():
        emit(
          const TinderTestState.error(message: 'Не удалось загрузить тест'),
        );
    }
  }

  /// Пытается восстановить сессию из репозитория.
  ///
  /// Возвращает `true`, если сессия найдена и состояние эмитировано;
  /// `false` — если сессии нет или она от другого теста (тогда вызывающий
  /// код продолжит обычный старт).
  Future<bool> _tryRestoreSession(
    int testId,
    Emitter<TinderTestState> emit,
  ) async {
    final result = await _activeSessionRepository.getActiveSession();
    if (result is! ResultOk) return false;

    final active = (result as ResultOk<ActiveTestSession?, Object>).data;
    if (active == null) return false;
    if (active.session.testId != testId.toString()) return false;

    _swapSides = active.params.swapSides;
    _answerIndex = active.params.answerIndex;
    _mixup = active.params.mixup;
    _mixupMin = active.params.mixupMin;
    _mixupMax = active.params.mixupMax;
    _testTitle = active.testTitle;

    if (active.session.isCompleted) {
      emit(TinderTestState.completed(session: active.session));
      return true;
    }

    final currentCard = active.session.currentCard;
    if (currentCard == null) {
      emit(const TinderTestState.empty());
      return true;
    }

    emit(TinderTestState.inProgress(
      session: active.session,
      currentCard: currentCard,
    ));
    return true;
  }

  TestSession _createSession(int testId, List<CardEntity> cards) {
    final shuffledCards = List<CardEntity>.from(cards)..shuffle();
    return TestSession(
      testId: testId.toString(),
      cards: shuffledCards,
      currentIndex: 0,
      results: const [],
      startedAt: DateTime.now(),
    );
  }

  Future<void> _onSwipedLeft(
    _TinderTestEvent$SwipedLeft event,
    Emitter<TinderTestState> emit,
  ) async {
    _handleSwipe(event.cardId, isCorrect: false, emit: emit);
  }

  Future<void> _onSwipedRight(
    _TinderTestEvent$SwipedRight event,
    Emitter<TinderTestState> emit,
  ) async {
    _handleSwipe(event.cardId, isCorrect: true, emit: emit);
  }

  void _handleSwipe(
    String cardId, {
    required bool isCorrect,
    required Emitter<TinderTestState> emit,
  }) {
    final currentState = state;
    if (currentState is! TinderTestState$InProgress) return;

    final result = CardResult(
      cardId: cardId,
      isCorrect: isCorrect,
      answeredAt: DateTime.now(),
    );

    final newResults = [...currentState.session.results, result];
    final newIndex = currentState.session.currentIndex + 1;

    final updatedSession = currentState.session.copyWith(
      currentIndex: newIndex,
      results: newResults,
    );

    if (updatedSession.isCompleted) {
      final completedSession = updatedSession.copyWith(
        completedAt: DateTime.now(),
      );
      emit(TinderTestState.completed(session: completedSession));
      unawaited(_saveStats(completedSession));
      unawaited(_clearSession());
    } else {
      emit(TinderTestState.inProgress(
        session: updatedSession,
        currentCard: updatedSession.currentCard!,
      ));
      unawaited(_persistSession(updatedSession));
    }
  }

  Future<void> _onCompleted(
    _TinderTestEvent$Completed event,
    Emitter<TinderTestState> emit,
  ) async {
    final currentState = state;
    if (currentState is! TinderTestState$InProgress) return;

    final completedSession = currentState.session.copyWith(
      completedAt: DateTime.now(),
    );
    emit(TinderTestState.completed(session: completedSession));
    unawaited(_saveStats(completedSession));
    unawaited(_clearSession());
  }

  Future<void> _saveStats(TestSession session) async {
    // Сохранение статистики не критично для основного потока теста.
    await _questionStatsRepository.saveSessionResults(
      results: session.results,
      cards: session.cards,
    );
  }

  Future<void> _onRestarted(
    _TinderTestEvent$Restarted event,
    Emitter<TinderTestState> emit,
  ) async {
    final currentState = state;
    TestSession? session;

    if (currentState is TinderTestState$Completed) {
      session = currentState.session;
    } else if (currentState is TinderTestState$InProgress) {
      session = currentState.session;
    }

    if (session == null) return;

    final testId = int.parse(session.testId);
    add(TinderTestEvent.started(
      testId: testId,
      swapSides: _swapSides,
      answerIndex: _answerIndex,
      mixup: _mixup,
      mixupMin: _mixupMin,
      mixupMax: _mixupMax,
    ));
  }

  Future<void> _onDiscard(
    _TinderTestEvent$Discard event,
    Emitter<TinderTestState> emit,
  ) async {
    final currentState = state;
    if (currentState is! TinderTestState$InProgress) return;
    if (!currentState.session.canUndo) return;

    final previousSession = currentState.session.previous;
    emit(TinderTestState.inProgress(
      session: previousSession,
      currentCard: previousSession.currentCard!,
      isUndo: true,
    ));
    unawaited(_persistSession(previousSession));
  }

  Future<void> _persistSession(TestSession session) async {
    final active = ActiveTestSession(
      session: session,
      params: ActiveSessionLaunchParams(
        swapSides: _swapSides,
        answerIndex: _answerIndex,
        mixup: _mixup,
        mixupMin: _mixupMin,
        mixupMax: _mixupMax,
        algorithm: _algorithm,
      ),
      testTitle: _testTitle,
      updatedAt: DateTime.now(),
    );
    await _activeSessionRepository.saveActiveSession(active);
  }

  Future<void> _clearSession() async {
    await _activeSessionRepository.clearActiveSession();
  }
}
