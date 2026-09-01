import 'dart:convert';

import 'package:drift/drift.dart';

import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_clock.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_entity_adapter.dart';
import 'package:quizzerg/feature/test_detail/data/database/cards_database.dart';
import 'package:quizzerg/feature/tests_list/data/database/tests_database.dart';
import 'package:quizzerg/feature/tests_list/data/dto/test_dto.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Адаптер синхронизации тестов.
///
/// Набор групп теста едет в payload полем `groupIds`, поэтому адаптеру
/// нужен доступ к таблице связей.
class TestSyncAdapter implements SyncEntityAdapter {
  final TestsDatabase _testsDatabase;
  final CardsDatabase _cardsDatabase;
  final GroupsDatabase _groupsDatabase;

  const TestSyncAdapter({
    required TestsDatabase testsDatabase,
    required CardsDatabase cardsDatabase,
    required GroupsDatabase groupsDatabase,
  })  : _testsDatabase = testsDatabase,
        _cardsDatabase = cardsDatabase,
        _groupsDatabase = groupsDatabase;

  @override
  SyncEntityType get entity => SyncEntityType.test;

  @override
  Future<List<SyncDirtyChange>> collectDirty({required int limit}) async {
    final rows = await _testsDatabase.getPendingTests(limit: limit);
    final changes = <SyncDirtyChange>[];

    for (final row in rows) {
      changes.add(await _toChange(row));
    }

    return changes;
  }

  @override
  Future<bool> isPending(String id) async {
    final row = await _testsDatabase.getTestByIdRaw(id);

    return row != null && SyncState.fromDb(row.syncState) == SyncState.pending;
  }

  @override
  Future<void> applyUpsert(String id, Map<String, dynamic> payload) async {
    final dto = TestDto.fromJson(payload);

    await _testsDatabase.upsertTest(
      TestsCompanion.insert(
        id: dto.id,
        title: dto.title,
        type: dto.type,
        description: Value(dto.description),
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
        basePayload: Value(jsonEncode(payload)),
        serverUpdatedAt: Value(SyncClock.format(dto.updatedAt)),
        syncState: Value(SyncState.synced.dbValue),
      ),
    );
    await _groupsDatabase.updateTestGroups(dto.id, dto.groupIds);
  }

  @override
  Future<void> applyDelete(String id) => _testsDatabase.purgeTestById(id);

  @override
  Future<void> confirmUpsert(String id, Map<String, dynamic>? payload) async {
    if (payload == null) {
      await _testsDatabase.writeSyncFields(
        id,
        TestsCompanion(syncState: Value(SyncState.synced.dbValue)),
      );

      return;
    }

    final dto = TestDto.fromJson(payload);
    await _testsDatabase.writeSyncFields(
      id,
      TestsCompanion(
        updatedAt: Value(dto.updatedAt),
        basePayload: Value(jsonEncode(payload)),
        serverUpdatedAt: Value(SyncClock.format(dto.updatedAt)),
        syncState: Value(SyncState.synced.dbValue),
      ),
      notNewerThan: dto.updatedAt,
    );
  }

  @override
  Future<void> confirmDelete(String id) => _testsDatabase.purgeTestById(id);

  @override
  Future<void> dropLocal(String id) => _testsDatabase.purgeTestById(id);

  @override
  Future<void> reuploadAsNew(
      String id, Map<String, dynamic> localPayload) async {
    // Для тестов политика — принять серверную версию, перезалив не нужен.
  }

  Future<SyncDirtyChange> _toChange(TestDatabaseDto row) async {
    final occurredAt = row.updatedAt.toUtc();

    if (row.deletedAt != null) {
      return SyncDirtyChange(
        entity: entity,
        op: SyncOp.delete,
        id: row.id,
        occurredAt: occurredAt,
      );
    }

    final groupIds = await _groupsDatabase.getGroupIdsByTestId(row.id);
    final questionCount = await _cardsDatabase.getCardCountByTestId(row.id);
    final updatedAt = SyncClock.bumpedUpdatedAt(
      SyncClock.parseServerUpdatedAt(row.serverUpdatedAt),
    );

    return SyncDirtyChange(
      entity: entity,
      op: SyncOp.upsert,
      id: row.id,
      occurredAt: occurredAt,
      payload: {
        'id': row.id,
        'title': row.title,
        'type': row.type,
        if (row.description != null) 'description': row.description,
        // Сервер поле игнорирует, но требует его наличия.
        'questionCount': questionCount,
        'groupIds': groupIds,
        'createdAt': SyncClock.format(row.createdAt),
        'updatedAt': SyncClock.format(updatedAt),
      },
    );
  }
}
