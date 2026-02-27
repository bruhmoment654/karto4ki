import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/card_detail/domain/repository/i_card_repository.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';
import 'package:quizzerg/feature/tinder_test/domain/mixup/question_mixup_service.dart';

part 'tinder_test_event.dart';
part 'tinder_test_state.dart';
part 'tinder_test_bloc.freezed.dart';

/// BLoC for tinder-style test execution.
///
/// Manages the test session, card swiping, and result tracking.
final class TinderTestBloc extends Bloc<TinderTestEvent, TinderTestState> {
  final ICardRepository _cardRepository;
  final IQuestionStatsRepository _questionStatsRepository;
  final QuestionMixupService? _mixupService;
  bool _swapSides = false;
  bool _mixup = false;

  TinderTestBloc({
    required ICardRepository cardRepository,
    required IQuestionStatsRepository questionStatsRepository,
    QuestionMixupService? mixupService,
  })  : _cardRepository = cardRepository,
        _questionStatsRepository = questionStatsRepository,
        _mixupService = mixupService,
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
    _swapSides = event.swapSides;
    _mixup = event.mixup;

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
          );
          cards = [...cards, ...mixupCards];
        }

        if (_swapSides) {
          cards = cards
              .map((c) => c.copyWith(front: c.back, back: c.front))
              .toList();
        }

        final session = _createSession(event.testId, cards);
        emit(TinderTestState.inProgress(
          session: session,
          currentCard: session.currentCard!,
        ));
      case ResultFailed():
        emit(
          const TinderTestState.error(message: 'Не удалось загрузить тест'),
        );
    }
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
    } else {
      emit(TinderTestState.inProgress(
        session: updatedSession,
        currentCard: updatedSession.currentCard!,
      ));
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
      mixup: _mixup,
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
  }
}
