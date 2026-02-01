import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:karto4ki/feature/card_detail/data/database/cards_database.dart';
import 'package:karto4ki/feature/tests/data/database/tests_database.dart';

part 'app_database.g.dart';

/// Main application database using Drift.
@DriftDatabase(
  include: {
    'package:karto4ki/feature/tests/data/database/tests.drift',
    'package:karto4ki/feature/card_detail/data/database/cards.drift',
  },
  daos: [TestsDatabase, CardsDatabase],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {},
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'karto4ki_db');
  }
}
