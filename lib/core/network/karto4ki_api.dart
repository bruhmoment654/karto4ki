import 'package:dio/dio.dart';
import 'package:quizzerg/core/network/dto/stats_dto.dart';
import 'package:quizzerg/core/network/dto/sync_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'karto4ki_api.g.dart';

/// API бэкенда karto4ki (`/v1`).
///
/// Используются только sync-эндпоинты и батч статистики: CRUD-операции
/// на бэк уходят целиком через `/sync/push`.
@RestApi()
abstract class Karto4kiApi {
  factory Karto4kiApi(Dio dio, {String? baseUrl}) = _Karto4kiApi;

  /// Изменения после курсора.
  @GET('/sync/changes')
  Future<SyncChangesDto> syncChanges({
    @Query('since') String? since,
    @Query('limit') int? limit,
  });

  /// Применить локальные изменения.
  @POST('/sync/push')
  Future<SyncPushResultDto> syncPush(@Body() SyncPushDto body);

  /// Отправить события ответов.
  @POST('/stats/answers/batch')
  Future<BatchAnswerResultDto> pushAnswerEvents(
    @Body() BatchAnswerEventsDto body,
  );
}
