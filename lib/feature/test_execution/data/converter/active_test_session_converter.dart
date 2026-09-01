import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_execution/data/dto/active_test_session_dto.dart';
import 'package:quizzerg/feature/test_execution/data/dto/card_result_dto.dart';
import 'package:quizzerg/feature/test_execution/data/dto/card_snapshot_dto.dart';
import 'package:quizzerg/feature/test_execution/data/dto/launch_params_dto.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_session_launch_params.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/card_result.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';

/// Конвертер DTO ↔ Entity для активной сессии теста.
///
/// Работает только с DTO и доменными моделями, не знает ничего про drift
/// и про конкретное хранилище. Используется и drift-имплементацией репозитория,
/// и (в будущем) SP-имплементацией.
abstract final class ActiveTestSessionConverter {
  static ActiveTestSession fromDto(ActiveTestSessionDto dto) {
    final cards = dto.cards.map(_cardFromDto).toList();
    final results = dto.results.map(_resultFromDto).toList();
    final session = TestSession(
      testId: dto.testId,
      cards: cards,
      currentIndex: dto.currentIndex,
      results: results,
      startedAt: dto.startedAt,
    );
    return ActiveTestSession(
      session: session,
      params: _paramsFromDto(dto.launchParams),
      testTitle: dto.testTitle,
      updatedAt: dto.updatedAt,
    );
  }

  static ActiveTestSessionDto toDto(ActiveTestSession entity) {
    return ActiveTestSessionDto(
      testId: entity.session.testId,
      testTitle: entity.testTitle,
      currentIndex: entity.session.currentIndex,
      startedAt: entity.session.startedAt,
      updatedAt: entity.updatedAt,
      cards: entity.session.cards.map(_cardToDto).toList(),
      results: entity.session.results.map(_resultToDto).toList(),
      launchParams: _paramsToDto(entity.params),
    );
  }

  static CardEntity _cardFromDto(CardSnapshotDto dto) => CardEntity(
        id: dto.id,
        testId: dto.testId,
        front: dto.front,
        answers: dto.answers,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
        isMixedIn: dto.isMixedIn,
      );

  static CardSnapshotDto _cardToDto(CardEntity entity) => CardSnapshotDto(
        id: entity.id,
        testId: entity.testId,
        front: entity.front,
        answers: entity.answers,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        isMixedIn: entity.isMixedIn,
      );

  static CardResult _resultFromDto(CardResultDto dto) => CardResult(
        cardId: dto.cardId,
        isCorrect: dto.isCorrect,
        answeredAt: dto.answeredAt,
      );

  static CardResultDto _resultToDto(CardResult entity) => CardResultDto(
        cardId: entity.cardId,
        isCorrect: entity.isCorrect,
        answeredAt: entity.answeredAt,
      );

  static ActiveSessionLaunchParams _paramsFromDto(LaunchParamsDto dto) =>
      ActiveSessionLaunchParams(
        swapSides: dto.swapSides,
        answerIndex: dto.answerIndex,
        mixup: dto.mixup,
        mixupMin: dto.mixupMin,
        mixupMax: dto.mixupMax,
        algorithm: dto.algorithm,
      );

  static LaunchParamsDto _paramsToDto(ActiveSessionLaunchParams entity) =>
      LaunchParamsDto(
        swapSides: entity.swapSides,
        answerIndex: entity.answerIndex,
        mixup: entity.mixup,
        mixupMin: entity.mixupMin,
        mixupMax: entity.mixupMax,
        algorithm: entity.algorithm,
      );
}
