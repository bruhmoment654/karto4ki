import 'package:drift/drift.dart';

import 'package:karto4ki/persistence/database/app_database.dart';

part 'cards_database.g.dart';

/// Data Access Object for Cards table.
@DriftAccessor(
  include: {'package:karto4ki/feature/card_detail/data/database/cards.drift'},
)
class CardsDatabase extends DatabaseAccessor<AppDatabase>
    with _$CardsDatabaseMixin {
  CardsDatabase(super.attachedDatabase);

  /// Get all cards.
  Future<List<CardDatabaseDto>> getAllCards() => select(cards).get();

  /// Get card by id.
  Future<CardDatabaseDto?> getCardById(int id) =>
      (select(cards)..where((c) => c.id.equals(id))).getSingleOrNull();

  /// Get cards by test id.
  Future<List<CardDatabaseDto>> getCardsByTestId(int testId) =>
      (select(cards)..where((c) => c.testId.equals(testId))).get();

  /// Watch all cards.
  Stream<List<CardDatabaseDto>> watchAllCards() => select(cards).watch();

  /// Watch cards by test id.
  Stream<List<CardDatabaseDto>> watchCardsByTestId(int testId) =>
      (select(cards)..where((c) => c.testId.equals(testId))).watch();

  /// Insert a new card.
  Future<int> insertCard(CardsCompanion card) => into(cards).insert(card);

  /// Insert multiple cards.
  Future<void> insertCards(List<CardsCompanion> cardsList) async {
    await batch((batch) {
      batch.insertAll(cards, cardsList);
    });
  }

  /// Update an existing card.
  Future<bool> updateCard(CardDatabaseDto card) => update(cards).replace(card);

  /// Delete a card by id.
  Future<int> deleteCardById(int id) =>
      (delete(cards)..where((c) => c.id.equals(id))).go();

  /// Delete all cards by test id.
  Future<int> deleteCardsByTestId(int testId) =>
      (delete(cards)..where((c) => c.testId.equals(testId))).go();

  /// Delete all cards.
  Future<int> deleteAllCards() => delete(cards).go();
}
