import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/feature/sync/data/database/sync_database.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_auth_status.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_meta_keys.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_progress.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_run_result.dart';
import 'package:quizzerg/feature/sync/domain/repository/i_sync_signal_repository.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_engine.dart';
import 'package:quizzerg/network/error/api_exception.dart';

part 'sync_event.dart';
part 'sync_state.dart';
part 'sync_bloc.freezed.dart';

/// BLoC синхронизации.
///
/// Запускается после авторизации, при появлении сети и с дебаунсом после
/// локальной мутации. Фонового periodic-таймера нет — realtime на сервере
/// тоже нет.
final class SyncBloc extends Bloc<SyncEvent, SyncState> {
  /// Дебаунс после локальной правки по умолчанию.
  static const defaultMutationDebounce = Duration(seconds: 3);

  final SyncEngine _engine;
  final SyncDatabase _syncDatabase;
  final ISyncSignalRepository _syncSignal;
  final Stream<List<ConnectivityResult>> _connectivityChanges;
  final Stream<SyncAuthStatus> _authStatus;

  /// Пауза между локальной правкой и прогоном. Правки идут пачками
  /// (переименовал, добавил карточку, ещё одну) — незачем пушить каждую.
  final Duration _mutationDebounce;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<SyncAuthStatus>? _authSubscription;
  StreamSubscription<void>? _mutationSubscription;
  Timer? _debounceTimer;
  SyncAuthStatus _auth = SyncAuthStatus.none;
  bool _isRunning = false;

  SyncBloc({
    required SyncEngine engine,
    required SyncDatabase syncDatabase,
    required ISyncSignalRepository syncSignal,
    required Stream<List<ConnectivityResult>> connectivityChanges,
    required Stream<SyncAuthStatus> authStatus,
    Duration mutationDebounce = defaultMutationDebounce,
  })  : _engine = engine,
        _syncDatabase = syncDatabase,
        _syncSignal = syncSignal,
        _connectivityChanges = connectivityChanges,
        _authStatus = authStatus,
        _mutationDebounce = mutationDebounce,
        super(const SyncState(status: SyncStatus.disabled())) {
    on<SyncEvent>(
      (event, emit) => switch (event) {
        _SyncEvent$Started() => _onStarted(emit),
        _SyncEvent$Requested() => _run(emit),
        _SyncEvent$LocalMutation() => _onLocalMutation(event, emit),
        _SyncEvent$ConnectivityChanged() => _onConnectivityChanged(event, emit),
        _SyncEvent$AuthChanged() => _onAuthChanged(event, emit),
        _SyncEvent$ConflictsShown() => _onConflictsShown(event, emit),
      },
    );
  }

  @override
  Future<void> close() async {
    _debounceTimer?.cancel();
    await _connectivitySubscription?.cancel();
    await _authSubscription?.cancel();
    await _mutationSubscription?.cancel();

    return super.close();
  }

  Future<void> _onStarted(Emitter<SyncState> emit) async {
    // Подписки — до первого await: состояние авторизации или правка могут
    // прилететь раньше, чем поднимется сдвиг часов.
    await _authSubscription?.cancel();
    _authSubscription = _authStatus.listen(
      (status) => add(SyncEvent.authChanged(status)),
    );

    await _mutationSubscription?.cancel();
    _mutationSubscription = _syncSignal.localMutations.listen(
      (_) => add(const SyncEvent.localMutation()),
    );

    await _engine.restoreClock();
  }

  Future<void> _onAuthChanged(
    _SyncEvent$AuthChanged event,
    Emitter<SyncState> emit,
  ) async {
    final previous = _auth;
    _auth = event.status;

    switch (event.status) {
      case SyncAuthStatus.none:
        await _onSignedOut(previous, emit);
      case SyncAuthStatus.expired:
        _debounceTimer?.cancel();
        emit(
          state.copyWith(
            status: SyncStatus.expired(
              lastSyncedAt: await _engine.lastSyncedAt(),
            ),
          ),
        );
      case SyncAuthStatus.active:
        if (previous == SyncAuthStatus.active) return;
        await _subscribeConnectivity();
        await _run(emit);
    }
  }

  /// Выход из аккаунта: курсор и метаданные чужие, следующий вход не должен
  /// их догонять. Локальные тесты и карточки остаются на устройстве.
  Future<void> _onSignedOut(
    SyncAuthStatus previous,
    Emitter<SyncState> emit,
  ) async {
    _debounceTimer?.cancel();
    await _connectivitySubscription?.cancel();
    _connectivitySubscription = null;

    if (previous != SyncAuthStatus.none) {
      await _engine.resetCursor();
      await _syncDatabase.clearMeta();
    }

    emit(state.copyWith(status: const SyncStatus.disabled(), conflicts: []));
  }

  Future<void> _subscribeConnectivity() async {
    if (_connectivitySubscription != null) return;

    _connectivitySubscription = _connectivityChanges.listen(
      (results) => add(SyncEvent.connectivityChanged(results: results)),
    );
  }

  Future<void> _onLocalMutation(
    _SyncEvent$LocalMutation event,
    Emitter<SyncState> emit,
  ) async {
    if (_auth != SyncAuthStatus.active) return;

    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      _mutationDebounce,
      () => add(const SyncEvent.requested()),
    );
  }

  Future<void> _onConnectivityChanged(
    _SyncEvent$ConnectivityChanged event,
    Emitter<SyncState> emit,
  ) async {
    if (_auth != SyncAuthStatus.active) return;

    final hasNetwork =
        event.results.any((result) => result != ConnectivityResult.none);
    if (!hasNetwork) {
      emit(
        state.copyWith(
          status: SyncStatus.offline(
            pending: await _engine.pendingCount(),
            lastSyncedAt: state.status.lastSyncedAt,
          ),
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
    if (_isRunning || _auth != SyncAuthStatus.active) return;

    _isRunning = true;
    final previousSyncedAt =
        state.status.lastSyncedAt ?? await _engine.lastSyncedAt();
    emit(
      state.copyWith(status: SyncStatus.syncing(lastSyncedAt: previousSyncedAt)),
    );

    try {
      final result = await _engine.sync(
        onProgress: (progress) => emit(
          state.copyWith(
            status: SyncStatus.syncing(
              lastSyncedAt: previousSyncedAt,
              progress: progress,
            ),
          ),
        ),
      );
      emit(await _stateFor(result, previousSyncedAt));
    } finally {
      _isRunning = false;
    }
  }

  Future<SyncState> _stateFor(
    SyncRunResult result,
    DateTime? previousSyncedAt,
  ) async {
    final conflicts = [...state.conflicts, ...result.conflicts];
    final pending = await _engine.pendingCount();

    if (result.isSuccess) {
      return SyncState(
        status: pending == 0
            ? SyncStatus.synced(lastSyncedAt: await _engine.lastSyncedAt())
            : SyncStatus.notSynced(
                pending: pending,
                lastSyncedAt: await _engine.lastSyncedAt(),
              ),
        conflicts: conflicts,
        lastRun: result,
        lastSyncedSource: await _engine.lastSyncedSource(),
      );
    }

    return SyncState(
      status: _failureStatus(result.error, pending, previousSyncedAt),
      conflicts: conflicts,
      lastRun: result,
      lastSyncedSource: state.lastSyncedSource,
    );
  }

  SyncStatus _failureStatus(
    ApiException? error,
    int pending,
    DateTime? lastSyncedAt,
  ) =>
      switch (error) {
        // Офлайн — нормальное рабочее состояние, а не ошибка.
        NetworkUnavailable() => SyncStatus.offline(
            pending: pending,
            lastSyncedAt: lastSyncedAt,
          ),
        AuthInvalidToken() ||
        AuthMissingToken() =>
          SyncStatus.expired(lastSyncedAt: lastSyncedAt),
        _ => SyncStatus.failed(
            error: error ?? const UnknownApiException(),
            pending: pending,
            lastSyncedAt: lastSyncedAt,
          ),
      };
}
