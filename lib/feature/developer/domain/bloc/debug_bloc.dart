import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizzerg/core/bloc/side_effect_value.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/feature/developer/domain/repository/i_debug_repository.dart';

part 'debug_bloc.freezed.dart';
part 'debug_event.dart';
part 'debug_state.dart';

/// BLoC дебаг-экрана: окружение и прокси.
final class DebugBloc extends Bloc<DebugEvent, DebugState> {
  final IDebugRepository _repository;

  DebugBloc({required IDebugRepository repository})
      : _repository = repository,
        super(DebugState(
          baseUrl: repository.baseUrl,
          proxyUrl: repository.getProxyUrl(),
        )) {
    on<DebugEvent>(
      (event, emit) => switch (event) {
        _DebugEvent$ProxyApplied() => _onProxyApplied(event, emit),
        _DebugEvent$ProxyCleared() => _onProxyCleared(event, emit),
      },
    );
  }

  Future<void> _onProxyApplied(
    _DebugEvent$ProxyApplied event,
    Emitter<DebugState> emit,
  ) async {
    await _save(event.proxyUrl, DebugProxyOutcome.applied, emit);
  }

  Future<void> _onProxyCleared(
    _DebugEvent$ProxyCleared event,
    Emitter<DebugState> emit,
  ) async {
    await _save(null, DebugProxyOutcome.cleared, emit);
  }

  Future<void> _save(
    String? proxyUrl,
    DebugProxyOutcome successOutcome,
    Emitter<DebugState> emit,
  ) async {
    final result = await _repository.saveProxyUrl(proxyUrl);

    switch (result) {
      case ResultOk():
        emit(state.copyWith(
          proxyUrl: _repository.getProxyUrl(),
          outcome: SideEffectValue(successOutcome),
          errorMessage: null,
        ));
      case ResultFailed(:final error):
        emit(state.copyWith(
          outcome: SideEffectValue(DebugProxyOutcome.failed),
          errorMessage: error.toString(),
        ));
    }
  }
}
