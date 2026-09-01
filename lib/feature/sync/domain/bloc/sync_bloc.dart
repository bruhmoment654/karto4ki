import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/feature/sync/domain/entity/sync_run_result.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_engine.dart';
import 'package:quizzerg/network/error/api_exception.dart';

part 'sync_event.dart';
part 'sync_state.dart';
part 'sync_bloc.freezed.dart';

/// BLoC синхронизации.
///
/// Запускается после авторизации на старте, при появлении сети, при
/// возврате в foreground и с дебаунсом после локальной мутации.
/// Фонового periodic-таймера нет — realtime на сервере тоже нет.
final class SyncBloc extends Bloc<SyncEvent, SyncState> {
  /// Дебаунс после локальной правки.
  static const mutationDebounce = Duration(seconds: 3);

  final SyncEngine _engine;
  final Connectivity _connectivity;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _debounceTimer;
  bool _isRunning = false;

  SyncBloc({
    required SyncEngine engine,
    required Connectivity connectivity,
  })  : _engine = engine,
        _connectivity = connectivity,
        super(const SyncState(status: SyncStatus.idle())) {
    on<SyncEvent>(
      (event, emit) => switch (event) {
        _SyncEvent$Started() => _onStarted(event, emit),
        _SyncEvent$Requested() => _onRequested(event, emit),
        _SyncEvent$LocalMutation() => _onLocalMutation(event, emit),
        _SyncEvent$ConnectivityChanged() => _onConnectivityChanged(event, emit),
        _SyncEvent$ConflictsShown() => _onConflictsShown(event, emit),
      },
    );
  }

  @override
  Future<void> close() async {
    _debounceTimer?.cancel();
    await _connectivitySubscription?.cancel();

    return super.close();
  }

  Future<void> _onStarted(
    _SyncEvent$Started event,
    Emitter<SyncState> emit,
  ) async {
    await _connectivitySubscription?.cancel();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (results) => add(SyncEvent.connectivityChanged(results: results)),
    );

    final lastSyncedAt = await _engine.lastSyncedAt();
    emit(state.copyWith(status: SyncStatus.idle(lastSyncedAt: lastSyncedAt)));

    await _run(emit);
  }

  Future<void> _onRequested(
    _SyncEvent$Requested event,
    Emitter<SyncState> emit,
  ) =>
      _run(emit);

  Future<void> _onLocalMutation(
    _SyncEvent$LocalMutation event,
    Emitter<SyncState> emit,
  ) async {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      mutationDebounce,
      () => add(const SyncEvent.requested()),
    );
  }

  Future<void> _onConnectivityChanged(
    _SyncEvent$ConnectivityChanged event,
    Emitter<SyncState> emit,
  ) async {
    final hasNetwork =
        event.results.any((result) => result != ConnectivityResult.none);
    if (!hasNetwork) {
      emit(
        state.copyWith(
          status: SyncStatus.offline(lastSyncedAt: state.status.lastSyncedAt),
        ),
      );

      return;
    }

    await _run(emit);
  }

  void _onConflictsShown(
    _SyncEvent$ConflictsShown event,
    Emitter<SyncState> emit,
  ) {
    emit(state.copyWith(conflicts: const []));
  }

  Future<void> _run(Emitter<SyncState> emit) async {
    if (_isRunning) return;

    _isRunning = true;
    final lastSyncedAt = state.status.lastSyncedAt;
    emit(
        state.copyWith(status: SyncStatus.syncing(lastSyncedAt: lastSyncedAt)));

    try {
      final result = await _engine.sync();
      emit(_stateFor(result, lastSyncedAt));
    } finally {
      _isRunning = false;
    }
  }

  SyncState _stateFor(SyncRunResult result, DateTime? previousSyncedAt) {
    final conflicts = [...state.conflicts, ...result.conflicts];

    if (result.isSuccess) {
      return SyncState(
        status: SyncStatus.idle(lastSyncedAt: DateTime.now()),
        conflicts: conflicts,
        lastRun: result,
      );
    }

    final error = result.error;

    return SyncState(
      status: error is NetworkUnavailable
          // Офлайн — нормальное рабочее состояние, а не ошибка.
          ? SyncStatus.offline(lastSyncedAt: previousSyncedAt)
          : SyncStatus.failed(
              error: error ?? const UnknownApiException(),
              lastSyncedAt: previousSyncedAt,
            ),
      conflicts: conflicts,
      lastRun: result,
    );
  }
}
