import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/core/feature/core/failures/unknown_failure.dart';
import 'package:quizzerg/feature/groups_list/domain/repository/i_groups_list_repository.dart';
import 'package:quizzerg/feature/profile/domain/entity/profile_summary_entity.dart';
import 'package:quizzerg/feature/profile/domain/profile_stats_calculator.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/tests_list/domain/repository/i_tests_list_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

/// Задержка перечитывания после правки БД: pull синхронизации пишет строки
/// пачками, пересчитывать сводку на каждую нет смысла.
const _changesDebounce = Duration(milliseconds: 300);

/// BLoC экрана профиля: собирает сводку по статистике, группам и тестам.
final class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IQuestionStatsRepository _questionStatsRepository;
  final IGroupsListRepository _groupsListRepository;
  final ITestsListRepository _testsListRepository;

  StreamSubscription<void>? _changesSubscription;

  ProfileBloc({
    required IQuestionStatsRepository questionStatsRepository,
    required IGroupsListRepository groupsListRepository,
    required ITestsListRepository testsListRepository,
  })  : _questionStatsRepository = questionStatsRepository,
        _groupsListRepository = groupsListRepository,
        _testsListRepository = testsListRepository,
        super(const ProfileState.loading()) {
    on<ProfileEvent>(
      (event, emit) => switch (event) {
        _ProfileEvent$Started() => _onStarted(event, emit),
      },
    );

    // Сводку пересобираем при любой правке источников: после входа в аккаунт
    // их наполняет pull синхронизации, а экран профиля живёт всю сессию.
    _changesSubscription = Rx.merge([
      questionStatsRepository.statsChanges,
      groupsListRepository.groupChanges,
      testsListRepository.testChanges,
    ]).skip(1).debounceTime(_changesDebounce).listen(
          (_) => add(const ProfileEvent.started()),
        );
  }

  @override
  Future<void> close() async {
    await _changesSubscription?.cancel();

    return super.close();
  }

  Future<void> _onStarted(
    _ProfileEvent$Started event,
    Emitter<ProfileState> emit,
  ) async {
    // Пересчёт по изменению БД не должен моргать спиннером поверх готовой
    // сводки — состояние меняем только когда данные уже собраны.
    if (state is! ProfileState$Loaded) emit(const ProfileState.loading());

    final statsResult = await _questionStatsRepository.getAllStats();
    final datesResult = await _questionStatsRepository.getActiveDates();
    final groupsResult = await _groupsListRepository.getGroups();
    final testsResult = await _testsListRepository.getTests();

    switch ((statsResult, datesResult, groupsResult, testsResult)) {
      case (
          ResultOk(data: final stats),
          ResultOk(data: final dates),
          ResultOk(data: final groups),
          ResultOk(data: final tests),
        ):
        emit(ProfileState.loaded(
          summary: ProfileStatsCalculator.calculate(
            stats: stats,
            activeDates: dates,
            today: DateTime.now(),
            groupsCount: groups.length,
            testsCount: tests.length,
          ),
        ));
      case _:
        emit(ProfileState.error(
          failure: _firstFailure([
            statsResult,
            datesResult,
            groupsResult,
            testsResult,
          ]),
        ));
    }
  }

  Failure _firstFailure(List<Result<Object?, Object>> results) {
    for (final result in results) {
      if (result case ResultFailed(:final error, :final stackTrace)) {
        return UnknownFailure.fromException(error, stackTrace);
      }
    }
    return const UnknownFailure(message: 'Unknown error');
  }
}
