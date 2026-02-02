import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:karto4ki/core/feature/core/failure.dart';
import 'package:karto4ki/core/feature/core/failures/unknown_failure.dart';
import 'package:karto4ki/feature/tests_list/domain/entity/test_entity.dart';
import 'package:karto4ki/feature/tests_list/domain/repository/i_tests_list_repository.dart';

part 'tests_list_event.dart';
part 'tests_list_state.dart';
part 'tests_list_bloc.freezed.dart';

/// BLoC for tests list screen.
///
/// Manages loading, adding and deleting tests.
final class TestsListBloc extends Bloc<TestsListEvent, TestsListState> {
  final ITestsListRepository _repository;

  TestsListBloc({required ITestsListRepository repository})
      : _repository = repository,
        super(const TestsListState.loading()) {
    on<TestsListEvent>(
      (event, emit) => switch (event) {
        _TestsListEvent$Started() => _onStarted(event, emit),
        _TestsListEvent$TestAdded() => _onTestAdded(event, emit),
        _TestsListEvent$TestDeleted() => _onTestDeleted(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _TestsListEvent$Started event,
    Emitter<TestsListState> emit,
  ) async {
    emit(const TestsListState.loading());

    try {
      final tests = await _repository.getTests();
      emit(TestsListState.loaded(tests: tests));
    } on Failure catch (f) {
      emit(TestsListState.error(failure: f));
    } on Object catch (e, st) {
      emit(TestsListState.error(failure: UnknownFailure.fromException(e, st)));
    }
  }

  Future<void> _onTestAdded(
    _TestsListEvent$TestAdded event,
    Emitter<TestsListState> emit,
  ) async {
    try {
      await _repository.addTest(
        title: event.title,
        description: event.description,
      );

      final tests = await _repository.getTests();
      emit(TestsListState.loaded(tests: tests));
    } on Failure catch (f) {
      emit(TestsListState.error(failure: f));
    } on Object catch (e, st) {
      emit(TestsListState.error(failure: UnknownFailure.fromException(e, st)));
    }
  }

  Future<void> _onTestDeleted(
    _TestsListEvent$TestDeleted event,
    Emitter<TestsListState> emit,
  ) async {
    try {
      await _repository.deleteTest(event.testId);

      final tests = await _repository.getTests();
      emit(TestsListState.loaded(tests: tests));
    } on Failure catch (f) {
      emit(TestsListState.error(failure: f));
    } on Object catch (e, st) {
      emit(TestsListState.error(failure: UnknownFailure.fromException(e, st)));
    }
  }
}
