import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/core/feature/core/exension/string_title_x.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/core/feature/core/failures/not_found_failure.dart';
import 'package:quizzerg/core/feature/core/failures/unknown_failure.dart';
import 'package:quizzerg/feature/group_detail/domain/repository/i_group_detail_repository.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/sync/domain/repository/i_sync_signal_repository.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:rxdart/rxdart.dart';

part 'group_detail_bloc.freezed.dart';
part 'group_detail_event.dart';
part 'group_detail_state.dart';

/// BLoC для экрана деталки группы.
final class GroupDetailBloc extends Bloc<GroupDetailEvent, GroupDetailState> {
  final IGroupDetailRepository _repository;
  final ISyncSignalRepository _syncSignal;
  String? _currentGroupId;
  StreamSubscription<void>? _changesSubscription;

  GroupDetailBloc({
    required IGroupDetailRepository repository,
    required ISyncSignalRepository syncSignal,
  })  : _repository = repository,
        _syncSignal = syncSignal,
        super(const GroupDetailState.loading()) {
    on<GroupDetailEvent>(
      (event, emit) => switch (event) {
        _GroupDetailEvent$Started() => _onStarted(event, emit),
        _GroupDetailEvent$TestAdded() => _onTestAdded(event, emit),
        _GroupDetailEvent$TestRemoved() => _onTestRemoved(event, emit),
        _GroupDetailEvent$TestRenamed() => _onTestRenamed(event, emit),
        _GroupDetailEvent$TitleUpdated() => _onTitleUpdated(event, emit),
        _GroupDetailEvent$TestGroupsUpdated() =>
          _onTestGroupsUpdated(event, emit),
      },
    );

    _changesSubscription = _repository.groupChanges
        .skip(1)
        .debounceTime(const Duration(milliseconds: 300))
        .listen((_) {
      final groupId = _currentGroupId;
      if (groupId != null) {
        add(GroupDetailEvent.started(groupId: groupId));
      }
    });
  }

  Future<void> _onStarted(
    _GroupDetailEvent$Started event,
    Emitter<GroupDetailState> emit,
  ) async {
    _currentGroupId = event.groupId;
    if (state is! GroupDetailState$Loaded) {
      emit(const GroupDetailState.loading());
    }

    await _reloadData(emit);
  }

  Future<void> _onTestAdded(
    _GroupDetailEvent$TestAdded event,
    Emitter<GroupDetailState> emit,
  ) async {
    final groupId = _currentGroupId;
    if (groupId == null) return;

    final result = await _repository.addTestToGroup(
      groupId: groupId,
      title: event.title.toCapitalized,
      description: event.description?.toCapitalized,
    );
    switch (result) {
      case ResultOk():
        _syncSignal.notifyLocalMutation();
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onTestRemoved(
    _GroupDetailEvent$TestRemoved event,
    Emitter<GroupDetailState> emit,
  ) async {
    final groupId = _currentGroupId;
    if (groupId == null) return;

    final result = await _repository.removeTestFromGroup(
      groupId: groupId,
      testId: event.testId,
    );
    switch (result) {
      case ResultOk():
        _syncSignal.notifyLocalMutation();
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onTestRenamed(
    _GroupDetailEvent$TestRenamed event,
    Emitter<GroupDetailState> emit,
  ) async {
    final result = await _repository.renameTest(
      testId: event.testId,
      title: event.title.toCapitalized,
    );
    switch (result) {
      case ResultOk():
        _syncSignal.notifyLocalMutation();
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onTitleUpdated(
    _GroupDetailEvent$TitleUpdated event,
    Emitter<GroupDetailState> emit,
  ) async {
    final groupId = _currentGroupId;
    if (groupId == null) return;

    final result = await _repository.updateGroupTitle(
      groupId: groupId,
      title: event.title.toCapitalized,
    );
    switch (result) {
      case ResultOk():
        _syncSignal.notifyLocalMutation();
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onTestGroupsUpdated(
    _GroupDetailEvent$TestGroupsUpdated event,
    Emitter<GroupDetailState> emit,
  ) async {
    final result = await _repository.updateTestGroups(
      testId: event.testId,
      groupIds: event.groupIds,
    );
    switch (result) {
      case ResultOk():
        _syncSignal.notifyLocalMutation();
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _reloadData(Emitter<GroupDetailState> emit) async {
    final groupId = _currentGroupId;
    if (groupId == null) return;

    final groupResult = await _repository.getGroupById(groupId);
    switch (groupResult) {
      case ResultOk(:final data):
        if (data == null) {
          emit(const GroupDetailState.error(
            failure: NotFoundFailure(entityName: 'Group'),
          ));
          return;
        }

        final testsResult = await _repository.getTestsByGroupId(groupId);
        switch (testsResult) {
          case ResultOk(data: final tests):
            await _emitLoaded(group: data, tests: tests, emit: emit);
          case ResultFailed(:final error, :final stackTrace):
            emit(GroupDetailState.error(
              failure: UnknownFailure.fromException(error, stackTrace),
            ));
        }
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  /// Догружает то, что нужно диалогам: все группы и привязки тестов.
  Future<void> _emitLoaded({
    required TestGroupEntity group,
    required List<TestEntity> tests,
    required Emitter<GroupDetailState> emit,
  }) async {
    final allGroupsResult = await _repository.getAllGroups();
    final bindingsResult = await _repository.getGroupIdsForTests(
      tests.map((test) => test.id).toList(),
    );

    switch ((allGroupsResult, bindingsResult)) {
      case (
          ResultOk(data: final allGroups),
          ResultOk(data: final groupIdsByTest),
        ):
        emit(GroupDetailState.loaded(
          group: group,
          tests: tests,
          allGroups: allGroups,
          groupIdsByTest: groupIdsByTest,
        ));
      case (ResultFailed(:final error, :final stackTrace), _):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
      case (_, ResultFailed(:final error, :final stackTrace)):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  @override
  Future<void> close() {
    _changesSubscription?.cancel();
    return super.close();
  }
}
