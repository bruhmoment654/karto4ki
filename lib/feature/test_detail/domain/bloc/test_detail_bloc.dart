import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:karto4ki/core/feature/core/failure.dart';
import 'package:karto4ki/core/feature/core/failures/not_found_failure.dart';
import 'package:karto4ki/core/feature/core/failures/unknown_failure.dart';
import 'package:karto4ki/feature/main/domain/entity/card_entity.dart';
import 'package:karto4ki/feature/test_detail/domain/repository/i_test_detail_repository.dart';
import 'package:karto4ki/feature/tests_list/domain/entity/test_entity.dart';

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

    try {
      final test = await _repository.getTestById(event.testId);
      if (test == null) {
        emit(const TestDetailState.error(
          failure: NotFoundFailure(entityName: 'Test'),
        ));
        return;
      }

      final cards = await _repository.getCardsByTestId(event.testId);
      emit(TestDetailState.loaded(test: test, cards: cards));
    } on Failure catch (f) {
      emit(TestDetailState.error(failure: f));
    } on Object catch (e, st) {
      emit(TestDetailState.error(failure: UnknownFailure.fromException(e, st)));
    }
  }

  Future<void> _onCardAdded(
    _TestDetailEvent$CardAdded event,
    Emitter<TestDetailState> emit,
  ) async {
    final testId = _currentTestId;
    if (testId == null) return;

    try {
      await _repository.addCard(
        testId: testId,
        front: event.front,
        back: event.back,
      );

      await _reloadData(emit);
    } on Failure catch (f) {
      emit(TestDetailState.error(failure: f));
    } on Object catch (e, st) {
      emit(TestDetailState.error(failure: UnknownFailure.fromException(e, st)));
    }
  }

  Future<void> _onCardDeleted(
    _TestDetailEvent$CardDeleted event,
    Emitter<TestDetailState> emit,
  ) async {
    try {
      await _repository.deleteCard(event.cardId);
      await _reloadData(emit);
    } on Failure catch (f) {
      emit(TestDetailState.error(failure: f));
    } on Object catch (e, st) {
      emit(TestDetailState.error(failure: UnknownFailure.fromException(e, st)));
    }
  }

  Future<void> _onCardUpdated(
    _TestDetailEvent$CardUpdated event,
    Emitter<TestDetailState> emit,
  ) async {
    try {
      await _repository.updateCard(event.card);
      await _reloadData(emit);
    } on Failure catch (f) {
      emit(TestDetailState.error(failure: f));
    } on Object catch (e, st) {
      emit(TestDetailState.error(failure: UnknownFailure.fromException(e, st)));
    }
  }

  Future<void> _onTestUpdated(
    _TestDetailEvent$TestUpdated event,
    Emitter<TestDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! TestDetailState$Loaded) return;

    try {
      final updatedTest = TestEntity(
        id: currentState.test.id,
        title: event.title,
        description: event.description,
        type: currentState.test.type,
        createdAt: currentState.test.createdAt,
        updatedAt: DateTime.now(),
      );

      await _repository.updateTest(updatedTest);
      await _reloadData(emit);
    } on Failure catch (f) {
      emit(TestDetailState.error(failure: f));
    } on Object catch (e, st) {
      emit(TestDetailState.error(failure: UnknownFailure.fromException(e, st)));
    }
  }

  Future<void> _onCardsImported(
    _TestDetailEvent$CardsImported event,
    Emitter<TestDetailState> emit,
  ) async {
    final testId = _currentTestId;
    if (testId == null) return;

    try {
      await _repository.addCards(
        testId: testId,
        cards: event.cards,
      );

      await _reloadData(emit);
    } on Failure catch (f) {
      emit(TestDetailState.error(failure: f));
    } on Object catch (e, st) {
      emit(TestDetailState.error(failure: UnknownFailure.fromException(e, st)));
    }
  }

  Future<void> _reloadData(Emitter<TestDetailState> emit) async {
    final testId = _currentTestId;
    if (testId == null) return;

    final test = await _repository.getTestById(testId);
    if (test == null) {
      emit(const TestDetailState.error(
        failure: NotFoundFailure(entityName: 'Test'),
      ));
      return;
    }

    final cards = await _repository.getCardsByTestId(testId);
    emit(TestDetailState.loaded(test: test, cards: cards));
  }
}
