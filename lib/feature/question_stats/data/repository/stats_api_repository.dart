import 'package:dio/dio.dart';

import 'package:quizzerg/feature/question_stats/data/dto/answer_event_dto.dart';
import 'package:quizzerg/feature/question_stats/data/dto/question_stats_dto.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_stats_api_repository.dart';
import 'package:quizzerg/network/api/api_client.dart';
import 'package:quizzerg/network/dto/page_response_dto.dart';

/// Реализация [IStatsApiRepository] поверх REST.
class StatsApiRepository implements IStatsApiRepository {
  final ApiClient _client;

  const StatsApiRepository({required ApiClient client}) : _client = client;

  @override
  Future<PageResponseDto<QuestionStatsDto>> getStats({
    String? cursor,
    int? limit,
    String? sortBy,
    String? order,
  }) =>
      _client.request(
        send: (dio) => dio.get<Object?>(
          '/stats',
          queryParameters: {
            if (cursor != null) 'cursor': cursor,
            if (limit != null) 'limit': limit,
            if (sortBy != null) 'sortBy': sortBy,
            if (order != null) 'order': order,
          },
        ),
        parse: (data) => ApiClient.asPage(data, QuestionStatsDto.fromJson),
      );

  @override
  Future<QuestionStatsDto> getStatsByCard(String cardId) => _client.request(
        send: (dio) => dio.get<Object?>('/stats/cards/$cardId'),
        parse: (data) => QuestionStatsDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<void> recordAnswer(AnswerEventDto event) => _client.requestVoid(
        (dio) => dio.post<Object?>('/stats/answer', data: event.toJson()),
      );

  @override
  Future<BatchAnswerResultDto> recordAnswers(List<AnswerEventDto> events) =>
      _client.request(
        send: (dio) => dio.post<Object?>(
          '/stats/answers/batch',
          data: BatchAnswerEventDto(events: events).toJson(),
        ),
        parse: (data) => BatchAnswerResultDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<String> exportCsv({required String format}) => _client.request(
        send: (dio) => dio.get<Object?>(
          '/stats/export',
          queryParameters: {'format': format},
          options: Options(responseType: ResponseType.plain),
        ),
        parse: (data) => data?.toString() ?? '',
      );
}
