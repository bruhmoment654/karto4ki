import 'package:dio/dio.dart';

import 'package:quizzerg/feature/question_stats/data/dto/answer_event_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/change_event_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_changes_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_push_dto.dart';
import 'package:quizzerg/feature/sync/domain/repository/i_sync_api_repository.dart';
import 'package:quizzerg/network/api/api_client.dart';
import 'package:quizzerg/network/api/api_config.dart';

/// Реализация [ISyncApiRepository] поверх REST.
class SyncApiRepository implements ISyncApiRepository {
  /// Лимит изменений в одном push — ограничение сервера.
  static const pushLimit = 1000;

  /// Лимит событий в одном батче ответов — ограничение сервера.
  static const answersLimit = 1000;

  final ApiClient _client;
  final ApiConfig _config;

  const SyncApiRepository({
    required ApiClient client,
    required ApiConfig config,
  })  : _client = client,
        _config = config;

  @override
  Future<SyncChangesDto> changes({required int limit, String? since}) =>
      _client.request(
        send: (dio) => dio.get<Object?>(
          '/sync/changes',
          queryParameters: {
            if (since != null) 'since': since,
            'limit': limit,
          },
          // Bootstrap без курсора тянет всю библиотеку — таймаут длинный.
          options: Options(receiveTimeout: _config.longReceiveTimeout),
        ),
        parse: (data) => SyncChangesDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<SyncPushResultDto> push(List<ChangeEventDto> changes) =>
      _client.request(
        send: (dio) => dio.post<Object?>(
          '/sync/push',
          data: SyncPushDto(changes: changes).toJson(),
        ),
        parse: (data) => SyncPushResultDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<BatchAnswerResultDto> pushAnswers(List<AnswerEventDto> events) =>
      _client.request(
        send: (dio) => dio.post<Object?>(
          '/stats/answers/batch',
          data: BatchAnswerEventDto(events: events).toJson(),
        ),
        parse: (data) => BatchAnswerResultDto.fromJson(ApiClient.asMap(data)),
      );
}
