import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/core/feature/core/failures/unknown_failure.dart';
import 'package:quizzerg/feature/test_merge/domain/repository/i_test_merge_repository.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

part 'test_merge_event.dart';
part 'test_merge_state.dart';
part 'test_merge_bloc.freezed.dart';

/// BLoC для экрана объединения тестов.
final class TestMergeBloc extends Bloc<TestMergeEvent, TestMergeState> {
  final ITestMergeRepository _repository;

  TestMergeBloc({required ITestMergeRepository repository})
      : _repository = repository,
        super(const TestMergeState.loading()) {
    on<TestMergeEvent>(
      (event, emit) => switch (event) {
        _TestMergeEvent$Started() => _onStarted(event, emit),
        _TestMergeEvent$TestToggled() => _onTestToggled(event, emit),
        _TestMergeEvent$MergeConfirmed() => _onMergeConfirmed(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _TestMergeEvent$Started event,
    Emitter<TestMergeState> emit,
  ) async {
    emit(const TestMergeState.loading());

    final result = await _repository.getTests();
    switch (result) {
      case ResultOk(:final data):
        final initialId = event.initialTestId.toString();
        emit(
          TestMergeState.loaded(
            tests: data,
            selectedTestIds: {initialId},
            initialTestId: initialId,
          ),
        );
      case ResultFailed(:final error, :final stackTrace):
        emit(TestMergeState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  void _onTestToggled(
    _TestMergeEvent$TestToggled event,
    Emitter<TestMergeState> emit,
  ) {
    final currentState = state;
    if (currentState is! TestMergeState$Loaded) return;

    if (event.testId == currentState.initialTestId) return;

    final updatedIds = Set<String>.from(currentState.selectedTestIds);
    if (updatedIds.contains(event.testId)) {
      updatedIds.remove(event.testId);
    } else {
      updatedIds.add(event.testId);
    }

    emit(currentState.copyWith(selectedTestIds: updatedIds));
  }

  Future<void> _onMergeConfirmed(
    _TestMergeEvent$MergeConfirmed event,
    Emitter<TestMergeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! TestMergeState$Loaded) return;

    emit(const TestMergeState.merging());

    final testIds = currentState.selectedTestIds.map(int.parse).toList();
    final result = await _repository.mergeTests(
      title: event.title,
      testIds: testIds,
    );
    switch (result) {
      case ResultOk(:final data):
        emit(TestMergeState.success(newTestId: data));
      case ResultFailed(:final error, :final stackTrace):
        emit(TestMergeState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }
}
