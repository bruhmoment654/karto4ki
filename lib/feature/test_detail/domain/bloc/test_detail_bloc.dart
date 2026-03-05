import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/core/feature/core/failures/not_found_failure.dart';
import 'package:quizzerg/core/feature/core/failures/unknown_failure.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_test_detail_repository.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

part 'test_detail_event.dart';
part 'test_detail_state.dart';
part 'test_detail_bloc.freezed.dart';

/// BLoC for test detail screen.
///
/// Manages loading test with cards, adding, updating and deleting cards.
final class TestDetailBloc extends Bloc<TestDetailEvent, TestDetailState> {
  final ITestDetailRepository _repository;
  int? _currentTestId;

  TestDetailBloc({required ITestDetailRepository repository})
      : _repository = repository,
        super(const TestDetailState.loading()) {
    on<TestDetailEvent>(
      (event, emit) => switch (event) {
        _TestDetailEvent$Started() => _onStarted(event, emit),
        _TestDetailEvent$CardAdded() => _onCardAdded(event, emit),
        _TestDetailEvent$CardDeleted() => _onCardDeleted(event, emit),
        _TestDetailEvent$CardUpdated() => _onCardUpdated(event, emit),
        _TestDetailEvent$TestUpdated() => _onTestUpdated(event, emit),
        _TestDetailEvent$CardsImported() => _onCardsImported(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _TestDetailEvent$Started event,
    Emitter<TestDetailState> emit,
  ) async {
    emit(const TestDetailState.loading());
    _currentTestId = event.testId;

    final testResult = await _repository.getTestById(event.testId);
    switch (testResult) {
      case ResultOk(:final data):
        if (data == null) {
          emit(const TestDetailState.error(
            failure: NotFoundFailure(entityName: 'Test'),
          ));
          return;
        }

        final cardsResult = await _repository.getCardsByTestId(event.testId);
        switch (cardsResult) {
          case ResultOk(:final data):
            emit(TestDetailState.loaded(
              test: testResult.dataOrNull!,
              cards: data,
            ));
          case ResultFailed(:final error, :final stackTrace):
            emit(TestDetailState.error(
              failure: UnknownFailure.fromException(error, stackTrace),
            ));
        }
      case ResultFailed(:final error, :final stackTrace):
        emit(TestDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onCardAdded(
    _TestDetailEvent$CardAdded event,
    Emitter<TestDetailState> emit,
  ) async {
    final testId = _currentTestId;
    if (testId == null) return;

    final result = await _repository.addCard(
      testId: testId,
      front: event.front,
      back: event.back,
    );
    switch (result) {
      case ResultOk():
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(TestDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onCardDeleted(
    _TestDetailEvent$CardDeleted event,
    Emitter<TestDetailState> emit,
  ) async {
    final result = await _repository.deleteCard(event.cardId);
    switch (result) {
      case ResultOk():
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(TestDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onCardUpdated(
    _TestDetailEvent$CardUpdated event,
    Emitter<TestDetailState> emit,
  ) async {
    final result = await _repository.updateCard(event.card);
    switch (result) {
      case ResultOk():
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(TestDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onTestUpdated(
    _TestDetailEvent$TestUpdated event,
    Emitter<TestDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! TestDetailState$Loaded) return;

    final updatedTest = TestEntity(
      id: currentState.test.id,
      title: event.title,
      description: event.description,
      type: currentState.test.type,
      createdAt: currentState.test.createdAt,
      updatedAt: DateTime.now(),
    );

    final result = await _repository.updateTest(updatedTest);
    switch (result) {
      case ResultOk():
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(TestDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onCardsImported(
    _TestDetailEvent$CardsImported event,
    Emitter<TestDetailState> emit,
  ) async {
    final testId = _currentTestId;
    if (testId == null) return;

    final result = await _repository.addCards(
      testId: testId,
      cards: event.cards,
    );
    switch (result) {
      case ResultOk():
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(TestDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _reloadData(Emitter<TestDetailState> emit) async {
    final testId = _currentTestId;
    if (testId == null) return;

    final testResult = await _repository.getTestById(testId);
    switch (testResult) {
      case ResultOk(:final data):
        if (data == null) {
          emit(const TestDetailState.error(
            failure: NotFoundFailure(entityName: 'Test'),
          ));
          return;
        }

        final cardsResult = await _repository.getCardsByTestId(testId);
        switch (cardsResult) {
          case ResultOk(:final data):
            emit(TestDetailState.loaded(
              test: testResult.dataOrNull!,
              cards: data,
            ));
          case ResultFailed(:final error, :final stackTrace):
            emit(TestDetailState.error(
              failure: UnknownFailure.fromException(error, stackTrace),
            ));
        }
      case ResultFailed(:final error, :final stackTrace):
        emit(TestDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }
}
