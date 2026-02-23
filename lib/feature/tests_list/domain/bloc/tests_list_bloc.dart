import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/core/feature/core/exension/string_title_x.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/core/feature/core/failures/unknown_failure.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/repository/i_tests_list_repository.dart';

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

    final result = await _repository.getTests();
    switch (result) {
      case ResultOk(:final data):
        emit(TestsListState.loaded(tests: data));
      case ResultFailed(:final error, :final stackTrace):
        emit(TestsListState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onTestAdded(
    _TestsListEvent$TestAdded event,
    Emitter<TestsListState> emit,
  ) async {
    final addResult = await _repository.addTest(
      title: event.title.toCapitalized,
      description: event.description?.toCapitalized,
    );
    switch (addResult) {
      case ResultOk():
        final testsResult = await _repository.getTests();
        switch (testsResult) {
          case ResultOk(:final data):
            emit(TestsListState.loaded(tests: data));
          case ResultFailed(:final error, :final stackTrace):
            emit(TestsListState.error(
              failure: UnknownFailure.fromException(error, stackTrace),
            ));
        }
      case ResultFailed(:final error, :final stackTrace):
        emit(TestsListState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onTestDeleted(
    _TestsListEvent$TestDeleted event,
    Emitter<TestsListState> emit,
  ) async {
    final deleteResult = await _repository.deleteTest(event.testId);
    switch (deleteResult) {
      case ResultOk():
        final testsResult = await _repository.getTests();
        switch (testsResult) {
          case ResultOk(:final data):
            emit(TestsListState.loaded(tests: data));
          case ResultFailed(:final error, :final stackTrace):
            emit(TestsListState.error(
              failure: UnknownFailure.fromException(error, stackTrace),
            ));
        }
      case ResultFailed(:final error, :final stackTrace):
        emit(TestsListState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }
}
