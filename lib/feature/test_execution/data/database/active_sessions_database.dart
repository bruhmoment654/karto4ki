import 'package:drift/drift.dart';

import 'package:quizzerg/persistence/database/app_database.dart';

part 'active_sessions_database.g.dart';

/// DAO для активной (последней) сессии теста.
///
/// Хранится единственная запись с `id = 1` (singleton).
@DriftAccessor(
  include: {
    'package:quizzerg/feature/test_execution/data/database/active_sessions.drift',
  },
)
class ActiveSessionsDatabase extends DatabaseAccessor<AppDatabase>
    with _$ActiveSessionsDatabaseMixin {
  static const int _singletonId = 1;

  ActiveSessionsDatabase(super.attachedDatabase);

  Future<ActiveSessionDatabaseDto?> get() =>
      (select(activeSessions)..where((t) => t.id.equals(_singletonId)))
          .getSingleOrNull();

  Future<void> upsert(String json) async {
    await into(activeSessions).insertOnConflictUpdate(
      ActiveSessionsCompanion.insert(
        id: const Value(_singletonId),
        data: json,
      ),
    );
  }

  Future<int> clear() =>
      (delete(activeSessions)..where((t) => t.id.equals(_singletonId))).go();

  Stream<ActiveSessionDatabaseDto?> watch() =>
      (select(activeSessions)..where((t) => t.id.equals(_singletonId)))
          .watchSingleOrNull();
}
