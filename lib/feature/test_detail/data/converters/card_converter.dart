import 'package:drift/drift.dart';

import 'package:quizzerg/core/utils/answer_parser.dart';
import 'package:quizzerg/core/utils/answers_codec.dart';
import 'package:quizzerg/core/utils/uuid_generator.dart';
import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/util/question_key_normalizer.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Converter for [CardEntity] and [CardDatabaseDto].
abstract final class CardConverter {
  /// Converts [CardDatabaseDto] to [CardEntity].
  static CardEntity fromDto(CardDatabaseDto dto) {
    return CardEntity(
      id: dto.id,
      testId: dto.testId,
      front: dto.front,
      answers: AnswersCodec.decode(dto.answers),
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  /// Компаньон для обновления существующей карточки.
  ///
  /// Поля `updated_at` и `sync_state` проставляет DAO.
  static CardsCompanion toUpdateCompanion(CardEntity entity) {
    return CardsCompanion(
      id: Value(entity.id),
      testId: Value(entity.testId),
      front: Value(entity.front),
      answers: Value(AnswersCodec.encode(entity.answers)),
      questionKey: Value(
        QuestionKeyNormalizer.normalize(entity.front, entity.answers),
      ),
    );
  }

  /// Компаньон для вставки новой карточки.
  ///
  /// [back] принимается в сыром виде (`"а | б"`, `"а // б"`, ...) — так его
  /// отдают импорт и ручной ввод.
  static CardsCompanion toNewCompanion({
    required String testId,
    required String front,
    required String back,
    String? id,
  }) {
    return toNewCompanionFromAnswers(
      testId: testId,
      front: front,
      answers: AnswerParser.parse(back),
      id: id,
    );
  }

  /// Компаньон для вставки новой карточки с разобранными вариантами ответа.
  static CardsCompanion toNewCompanionFromAnswers({
    required String testId,
    required String front,
    required List<String> answers,
    String? id,
  }) {
    final now = DateTime.now().toUtc();
    return CardsCompanion.insert(
      id: id ?? UuidGenerator.v7(),
      testId: testId,
      front: front,
      answers: AnswersCodec.encode(answers),
      questionKey: QuestionKeyNormalizer.normalize(front, answers),
      createdAt: now,
      updatedAt: now,
    );
  }
}
