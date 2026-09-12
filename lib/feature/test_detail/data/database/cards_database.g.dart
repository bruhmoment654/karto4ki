// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards_database.dart';

// ignore_for_file: type=lint
mixin _$CardsDatabaseMixin on DatabaseAccessor<AppDatabase> {
  Tests get tests => attachedDatabase.tests;
  Cards get cards => attachedDatabase.cards;
  CardsDatabaseManager get managers => CardsDatabaseManager(this);
}

class CardsDatabaseManager {
  final _$CardsDatabaseMixin _db;
  CardsDatabaseManager(this._db);
  $TestsTableManager get tests =>
      $TestsTableManager(_db.attachedDatabase, _db.tests);
  $CardsTableManager get cards =>
      $CardsTableManager(_db.attachedDatabase, _db.cards);
}
