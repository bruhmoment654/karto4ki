import 'package:drift/drift.dart';

import 'package:quizzerg/feature/sync/domain/entity/sync_state.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

part 'cards_database.g.dart';

/// Data Access Object for Cards table.
///
/// Чтения отфильтрованы по `deleted_at IS NULL`: удалённая строка живёт
/// как tombstone до подтверждённого push и в UI попадать не должна.
@DriftAccessor(
  include: {'package:quizzerg/feature/test_detail/data/database/cards.drift'},
)
class CardsDatabase extends DatabaseAccessor<AppDatabase>
    with _$CardsDatabaseMixin {
  CardsDatabase(super.attachedDatabase);

  /// Get all cards.
  ///
  /// Карточки удалённых тестов исключаются: на сервере они «заморожены»
  /// вместе с тестом и оживают только при его restore.
  Future<List<CardDatabaseDto>> getAllCards() async {
    final rows =
        await (select(cards)..where((tbl) => tbl.deletedAt.isNull())).join([
      innerJoin(
        attachedDatabase.tests,
        attachedDatabase.tests.id.equalsExp(cards.testId) &
            attachedDatabase.tests.deletedAt.isNull(),
      ),
    ]).get();
    return rows.map((row) => row.readTable(cards)).toList();
  }

  /// Get card by id.
  Future<CardDatabaseDto?> getCardById(String id) =>
      (_alive()..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  /// Get cards by test id.
  Future<List<CardDatabaseDto>> getCardsByTestId(String testId) =>
      (_alive()..where((tbl) => tbl.testId.equals(testId))).get();

  /// Watch all cards.
  Stream<List<CardDatabaseDto>> watchAllCards() => _alive().watch();

  /// Watch cards by test id.
  Stream<List<CardDatabaseDto>> watchCardsByTestId(String testId) =>
      (_alive()..where((tbl) => tbl.testId.equals(testId))).watch();

  /// Insert a new card.
  Future<void> insertCard(CardsCompanion card) => into(cards).insert(card);

  /// Insert multiple cards.
  Future<void> insertCards(List<CardsCompanion> cardsList) async {
    await batch((batch) {
      batch.insertAll(cards, cardsList);
    });
  }

  /// Обновить карточку и пометить строку неотправленной.
  Future<void> updateCard(CardsCompanion card) async {
    final id = card.id.value;
    await (update(cards)..where((tbl) => tbl.id.equals(id))).write(
      card.copyWith(
        updatedAt: Value(DateTime.now().toUtc()),
        syncState: Value(SyncState.pending.dbValue),
      ),
    );
  }

  /// Пометить карточку удалённой (tombstone).
  Future<void> softDeleteCardById(String id) async {
    final now = DateTime.now().toUtc();
    await (update(cards)..where((tbl) => tbl.id.equals(id))).write(
      CardsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        syncState: Value(SyncState.pending.dbValue),
      ),
    );
  }

  /// Пометить удалёнными все карточки теста.
  Future<void> softDeleteCardsByTestId(String testId) async {
    final now = DateTime.now().toUtc();
    await (update(cards)
          ..where((tbl) => tbl.testId.equals(testId) & tbl.deletedAt.isNull()))
        .write(
      CardsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        syncState: Value(SyncState.pending.dbValue),
      ),
    );
  }

  /// Физически удалить строку. Только для подтверждённых сервером tombstone.
  Future<int> purgeCardById(String id) =>
      (delete(cards)..where((tbl) => tbl.id.equals(id))).go();

  /// Строка по id без фильтра по tombstone.
  Future<CardDatabaseDto?> getCardByIdRaw(String id) =>
      (select(cards)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  /// Карточки с неотправленными изменениями.
  Future<List<CardDatabaseDto>> getPendingCards({required int limit}) =>
      (select(cards)
            ..where((tbl) => tbl.syncState.equals(SyncState.pending.dbValue))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.updatedAt)])
            ..limit(limit))
          .get();

  /// Записать строку целиком (upsert из серверного снимка).
  Future<void> upsertCard(CardsCompanion card) =>
      into(cards).insertOnConflictUpdate(card);

  /// Обновить служебные поля синхронизации.
  ///
  /// [notNewerThan] защищает от гонки «правка во время push»: если строку
  /// успели изменить после отправки, помечать её синхронизированной нельзя.
  Future<void> writeSyncFields(
    String id,
    CardsCompanion fields, {
    DateTime? notNewerThan,
  }) =>
      (update(cards)
            ..where(
              (tbl) => notNewerThan == null
                  ? tbl.id.equals(id)
                  : tbl.id.equals(id) &
                      tbl.updatedAt.isSmallerOrEqualValue(notNewerThan),
            ))
          .write(fields);

  /// Get card count by test id.
  Future<int> getCardCountByTestId(String testId) async {
    final count = cards.id.count();
    final query = selectOnly(cards)
      ..addColumns([count])
      ..where(cards.testId.equals(testId) & cards.deletedAt.isNull());
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  /// Delete all cards.
  Future<int> deleteAllCards() => delete(cards).go();

  SimpleSelectStatement<Cards, CardDatabaseDto> _alive() =>
      select(cards)..where((tbl) => tbl.deletedAt.isNull());
}
