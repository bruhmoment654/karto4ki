import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/feature/test_execution/domain/repository/i_active_session_repository.dart';

part 'active_session_event.dart';
part 'active_session_state.dart';
part 'active_session_bloc.freezed.dart';

/// BLoC активной (последней) сессии теста.
///
/// Подписывается на стрим активной сессии из репозитория и
/// эмитит [ActiveSessionState$None] / [ActiveSessionState$Available].
final class ActiveSessionBloc
    extends Bloc<ActiveSessionEvent, ActiveSessionState> {
  final IActiveSessionRepository _repository;
  StreamSubscription<ActiveTestSession?>? _subscription;

  ActiveSessionBloc({
    required IActiveSessionRepository repository,
  })  : _repository = repository,
        super(const ActiveSessionState.none()) {
    on<ActiveSessionEvent>(
      (event, emit) => switch (event) {
        _ActiveSessionEvent$Started() => _onStarted(event, emit),
        _ActiveSessionEvent$Updated() => _onUpdated(event, emit),
        _ActiveSessionEvent$Cleared() => _onCleared(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _ActiveSessionEvent$Started event,
    Emitter<ActiveSessionState> emit,
  ) async {
    await _subscription?.cancel();
    _subscription = _repository.watchActiveSession().listen((session) {
      add(ActiveSessionEvent.updated(session: session));
    });
  }

  void _onUpdated(
    _ActiveSessionEvent$Updated event,
    Emitter<ActiveSessionState> emit,
  ) {
    final session = event.session;
    if (session == null) {
      emit(const ActiveSessionState.none());
    } else {
      emit(ActiveSessionState.available(session: session));
    }
  }

  Future<void> _onCleared(
    _ActiveSessionEvent$Cleared event,
    Emitter<ActiveSessionState> emit,
  ) async {
    await _repository.clearActiveSession();
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
