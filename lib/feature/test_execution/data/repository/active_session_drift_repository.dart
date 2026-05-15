import 'dart:convert';

import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/data/repository/base_repository.dart';
import 'package:quizzerg/feature/test_execution/data/converter/active_test_session_converter.dart';
import 'package:quizzerg/feature/test_execution/data/database/active_sessions_database.dart';
import 'package:quizzerg/feature/test_execution/data/dto/active_test_session_dto.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/feature/test_execution/domain/repository/i_active_session_repository.dart';

/// Drift-имплементация репозитория активной сессии теста.
///
/// Сериализует всю сессию в один JSON и хранит его в TEXT-колонке
/// singleton-строки таблицы `active_sessions`.
class ActiveSessionDriftRepository extends BaseRepository
    implements IActiveSessionRepository {
  final ActiveSessionsDatabase _database;

  const ActiveSessionDriftRepository({
    required ActiveSessionsDatabase database,
    required super.errorLogger,
  }) : _database = database;

  @override
  RequestOperation<ActiveTestSession?> getActiveSession() => makeCall(() async {
        final dto = await _database.get();
        return dto == null ? null : _decode(dto.data);
      });

  @override
  RequestOperation<void> saveActiveSession(ActiveTestSession session) =>
      makeCall(() async {
        final dto = ActiveTestSessionConverter.toDto(session);
        await _database.upsert(jsonEncode(dto.toJson()));
      });

  @override
  RequestOperation<void> clearActiveSession() => makeCall(() async {
        await _database.clear();
      });

  @override
  Stream<ActiveTestSession?> watchActiveSession() =>
      _database.watch().map((dto) => dto == null ? null : _decode(dto.data));

  ActiveTestSession _decode(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    final dto = ActiveTestSessionDto.fromJson(map);
    return ActiveTestSessionConverter.fromDto(dto);
  }
}
