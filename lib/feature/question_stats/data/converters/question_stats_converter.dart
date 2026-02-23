import 'package:quizzerg/feature/question_stats/domain/entity/question_stats_entity.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

abstract final class QuestionStatsConverter {
  static QuestionStatsEntity fromDto(QuestionStatsDatabaseDto dto) {
    return QuestionStatsEntity(
      id: dto.id,
      questionKey: dto.questionKey,
      frontText: dto.frontText,
      backText: dto.backText,
      streak: dto.streak,
      totalCorrect: dto.totalCorrect,
      totalIncorrect: dto.totalIncorrect,
      totalShown: dto.totalShown,
      lastAnsweredAt: dto.lastAnsweredAt,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
}
