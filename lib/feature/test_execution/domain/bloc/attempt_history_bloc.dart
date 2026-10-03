import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/core/bloc/side_effect_value.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_history_usage.dart';
import 'package:quizzerg/feature/test_execution/domain/repository/i_test_attempt_repository.dart';

part 'attempt_history_event.dart';
part 'attempt_history_state.dart';
part 'attempt_history_bloc.freezed.dart';

/// BLoC размера и очистки истории прохождений на экране настроек.
///
/// Размер считается при открытии экрана и после очистки: пока открыты
/// настройки, новые прохождения не пишутся.
final class AttemptHistoryBloc
    extends Bloc<AttemptHistoryEvent, AttemptHistoryState> {
  final ITestAttemptRepository _repository;

  AttemptHistoryBloc({required ITestAttemptRepository repository})
    : _repository = repository,
      super(const AttemptHistoryState.loading()) {
    on<AttemptHistoryEvent>(
      (event, emit) => switch (event) {
        _AttemptHistoryEvent$Started() => _onStarted(event, emit),
        _AttemptHistoryEvent$ClearRequested() => _onClearRequested(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _AttemptHistoryEvent$Started event,
    Emitter<AttemptHistoryState> emit,
  ) async {
    final result = await _repository.getHistoryUsage();
    emit(AttemptHistoryState.loaded(usage: result.dataOrNull));
  }

  /// Флаг очистки выставляется до первого `await`, поэтому повторное
  /// событие видит его и игнорируется.
  Future<void> _onClearRequested(
    _AttemptHistoryEvent$ClearRequested event,
    Emitter<AttemptHistoryState> emit,
  ) async {
    final current = state;
    if (current is! AttemptHistoryState$Loaded || current.isClearing) return;

    emit(current.copyWith(isClearing: true));

    final result = await _repository.clearHistory();
    switch (result) {
      case ResultOk(:final data):
        emit(
          AttemptHistoryState.loaded(
            usage: data,
            clearResult: SideEffectValue(AttemptHistoryClearResult.cleared),
          ),
        );
      case ResultFailed():
        final usage = await _repository.getHistoryUsage();
        emit(
          AttemptHistoryState.loaded(
            usage: usage.dataOrNull,
            clearResult: SideEffectValue(AttemptHistoryClearResult.failed),
          ),
        );
    }
  }
}
