import 'package:quizzerg/feature/question_stats/data/dto/answer_event_dto.dart';
import 'package:quizzerg/feature/question_stats/data/dto/question_stats_dto.dart';
import 'package:quizzerg/network/dto/page_response_dto.dart';

/// Эндпоинты `/stats`.
///
/// В UI-флоу используется только батч ответов (через движок sync):
/// статистика для чтения приезжает в `/sync/changes`, экспорт делается
/// локально.
abstract interface class IStatsApiRepository {
  Future<PageResponseDto<QuestionStatsDto>> getStats({
    String? cursor,
    int? limit,
    String? sortBy,
    String? order,
  });

  Future<QuestionStatsDto> getStatsByCard(String cardId);

  Future<void> recordAnswer(AnswerEventDto event);

  Future<BatchAnswerResultDto> recordAnswers(List<AnswerEventDto> events);

  /// CSV-экспорт. `format` ∈ `question_stats` | `cards`.
  Future<String> exportCsv({required String format});
}
