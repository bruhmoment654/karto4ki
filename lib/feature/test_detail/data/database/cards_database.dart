import 'package:drift/drift.dart';

import 'package:quizzerg/persistence/database/app_database.dart';

part 'cards_database.g.dart';

/// Data Access Object for Cards table.
@DriftAccessor(
  include: {'package:quizzerg/feature/test_detail/data/database/cards.drift'},
)
class CardsDatabase extends DatabaseAccessor<AppDatabase>
    with _$CardsDatabaseMixin {
  CardsDatabase(super.attachedDatabase);

  /// Get all alive cards.
  Future<List<CardDatabaseDto>> getAllCards() =>
      (select(cards)..where((c) => c.deletedAt.isNull())).get();

  /// Get card by id.
  Future<CardDatabaseDto?> getCardById(String id) =>
      (select(cards)..where((c) => c.id.equals(id))).getSingleOrNull();

  /// Get alive cards by test id.
  Future<List<CardDatabaseDto>> getCardsByTestId(String testId) =>
      (select(cards)
            ..where((c) => c.testId.equals(testId) & c.deletedAt.isNull()))
          .get();

  /// Watch all alive cards.
  Stream<List<CardDatabaseDto>> watchAllCards() =>
      (select(cards)..where((c) => c.deletedAt.isNull())).watch();

  /// Watch alive cards by test id.
  Stream<List<CardDatabaseDto>> watchCardsByTestId(String testId) =>
      (select(cards)
            ..where((c) => c.testId.equals(testId) & c.deletedAt.isNull()))
          .watch();

  /// Insert a new card.
  Future<void> insertCard(CardsCompanion card) => into(cards).insert(card);

  /// Insert multiple cards.
  Future<void> insertCards(List<CardsCompanion> cardsList) async {
    await batch((batch) {
      batch.insertAll(cards, cardsList);
    });
  }

  /// Update an existing card.
  Future<bool> updateCard(CardDatabaseDto card) => update(cards).replace(card);

  /// Soft delete: пометить карточку удалённой и ожидающей отправки.
  Future<int> softDeleteCardById(String id) =>
      (update(cards)..where((c) => c.id.equals(id))).write(
        CardsCompanion(
          deletedAt: Value(DateTime.now()),
          syncStatus: const Value('pending'),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Физически удалить карточку (после подтверждения бэкендом).
  Future<int> hardDeleteCardById(String id) =>
      (delete(cards)..where((c) => c.id.equals(id))).go();

  /// Физически удалить карточки теста.
  Future<int> hardDeleteCardsByTestId(String testId) =>
      (delete(cards)..where((c) => c.testId.equals(testId))).go();

  /// Get alive card count by test id.
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

  /// Карточки, ожидающие отправки на бэкенд.
  Future<List<CardDatabaseDto>> getPendingCards() => (select(cards)
        ..where((c) => c.syncStatus.isIn(['pending', 'pending_restore'])))
      .get();

  /// Установить статус синхронизации.
  Future<int> setSyncStatus(String id, String status) =>
      (update(cards)..where((c) => c.id.equals(id)))
          .write(CardsCompanion(syncStatus: Value(status)));

  /// Пометить все local-записи как pending (первый вход в аккаунт).
  Future<int> markAllLocalPending() =>
      (update(cards)..where((c) => c.syncStatus.equals('local')))
          .write(const CardsCompanion(syncStatus: Value('pending')));

  /// Upsert из pull-синка.
  Future<void> upsertFromServer(CardsCompanion card) =>
      into(cards).insertOnConflictUpdate(card);
}
