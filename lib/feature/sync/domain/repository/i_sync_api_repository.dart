import 'package:quizzerg/feature/question_stats/data/dto/answer_event_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/change_event_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_changes_dto.dart';
import 'package:quizzerg/feature/sync/data/dto/sync_push_dto.dart';

/// Сетевая часть синхронизации.
///
/// Кидает типизированные `ApiException`: движок синхронизации сам решает,
/// что считать офлайном, а что — ошибкой.
abstract interface class ISyncApiRepository {
  /// `GET /sync/changes`. Без [since] — полный bootstrap.
  Future<SyncChangesDto> changes({required int limit, String? since});

  /// `POST /sync/push`. Не более 1000 изменений за вызов.
  Future<SyncPushResultDto> push(List<ChangeEventDto> changes);

  /// `POST /stats/answers/batch`. Не более 1000 событий за вызов.
  Future<BatchAnswerResultDto> pushAnswers(List<AnswerEventDto> events);
}
