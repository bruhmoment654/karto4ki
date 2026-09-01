import 'dart:convert';

import 'package:drift/drift.dart';

import 'package:quizzerg/feature/groups_list/data/database/groups_database.dart';
import 'package:quizzerg/feature/groups_list/data/dto/group_dto.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_entity_type.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_clock.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_entity_adapter.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Адаптер синхронизации групп.
class GroupSyncAdapter implements SyncEntityAdapter {
  final GroupsDatabase _groupsDatabase;

  const GroupSyncAdapter({required GroupsDatabase groupsDatabase})
      : _groupsDatabase = groupsDatabase;

  @override
  SyncEntityType get entity => SyncEntityType.group;

  @override
  Future<List<SyncDirtyChange>> collectDirty({required int limit}) async {
    final rows = await _groupsDatabase.getPendingGroups(limit: limit);
    final changes = <SyncDirtyChange>[];

    for (final row in rows) {
      changes.add(await _toChange(row));
    }

    return changes;
  }

  @override
  Future<bool> isPending(String id) async {
    final row = await _groupsDatabase.getGroupByIdRaw(id);

    return row != null && SyncState.fromDb(row.syncState) == SyncState.pending;
  }

  @override
  Future<void> applyUpsert(String id, Map<String, dynamic> payload) async {
    final dto = GroupDto.fromJson(payload);
    await _groupsDatabase.upsertGroup(
      TestGroupsCompanion.insert(
        id: dto.id,
        title: dto.title,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
        basePayload: Value(jsonEncode(payload)),
        serverUpdatedAt: Value(SyncClock.format(dto.updatedAt)),
        syncState: Value(SyncState.synced.dbValue),
      ),
    );
  }

  @override
  Future<void> applyDelete(String id) => _groupsDatabase.purgeGroupById(id);

  @override
  Future<void> confirmUpsert(String id, Map<String, dynamic>? payload) async {
    if (payload == null) {
      await _groupsDatabase.writeSyncFields(
        id,
        TestGroupsCompanion(syncState: Value(SyncState.synced.dbValue)),
      );

      return;
    }

    final dto = GroupDto.fromJson(payload);
    await _groupsDatabase.writeSyncFields(
      id,
      TestGroupsCompanion(
        updatedAt: Value(dto.updatedAt),
        basePayload: Value(jsonEncode(payload)),
        serverUpdatedAt: Value(SyncClock.format(dto.updatedAt)),
        syncState: Value(SyncState.synced.dbValue),
      ),
      notNewerThan: dto.updatedAt,
    );
  }

  @override
  Future<void> confirmDelete(String id) => _groupsDatabase.purgeGroupById(id);

  @override
  Future<void> dropLocal(String id) => _groupsDatabase.purgeGroupById(id);

  @override
  Future<void> reuploadAsNew(
      String id, Map<String, dynamic> localPayload) async {
    // Для групп политика — принять серверную версию, перезалив не нужен.
  }

  Future<SyncDirtyChange> _toChange(TestGroupDatabaseDto row) async {
    final occurredAt = row.updatedAt.toUtc();

    if (row.deletedAt != null) {
      return SyncDirtyChange(
        entity: entity,
        op: SyncOp.delete,
        id: row.id,
        occurredAt: occurredAt,
      );
    }

    final testCount = await _groupsDatabase.getTestCountByGroupId(row.id);
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
        // Сервер поле игнорирует, но требует его наличия.
        'testCount': testCount,
        'createdAt': SyncClock.format(row.createdAt),
        'updatedAt': SyncClock.format(updatedAt),
      },
    );
  }
}
