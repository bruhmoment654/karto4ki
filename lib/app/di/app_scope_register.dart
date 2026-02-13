import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/services/csv_import_service.dart';
import 'package:quizzerg/feature/card_detail/data/repository/card_repository.dart';
import 'package:quizzerg/feature/main/data/repository/main_repository.dart';
import 'package:quizzerg/feature/test_detail/data/repository/test_detail_repository.dart';
import 'package:quizzerg/feature/question_stats/data/repository/question_stats_repository.dart';
import 'package:quizzerg/feature/test_merge/data/repository/test_merge_repository.dart';
import 'package:quizzerg/feature/tests_list/data/repository/tests_list_repository.dart';
import 'package:quizzerg/persistence/card_test/card_test_storage.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:quizzerg/persistence/settings/settings_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Application dependency registrar.
///
/// Creates and configures all dependencies for [AppScope].
class AppScopeRegister {
  Future<IAppScope> createScope() async {
    final prefs = await SharedPreferences.getInstance();
    final database = AppDatabase();

    final settingsStorage = SettingsStorage(prefs);
    final cardTestStorage = CardTestStorage(prefs);
    final mainRepository = MainRepository(cardTestStorage);
    final cardRepository = CardRepository(
      cardsDatabase: database.cardsDatabase,
    );
    final testsListRepository = TestsListRepository(
      testsDatabase: database.testsDatabase,
    );
    final testDetailRepository = TestDetailRepository(
      testsDatabase: database.testsDatabase,
      cardsDatabase: database.cardsDatabase,
    );

    const csvImportService = CsvImportService();

    final testMergeRepository = TestMergeRepository(
      testsDatabase: database.testsDatabase,
      cardsDatabase: database.cardsDatabase,
    );

    final questionStatsRepository = QuestionStatsRepository(
      questionStatsDatabase: database.questionStatsDatabase,
    );

    return AppScope(
      database: database,
      mainRepository: mainRepository,
      cardRepository: cardRepository,
      testsListRepository: testsListRepository,
      testDetailRepository: testDetailRepository,
      csvImportService: csvImportService,
      testMergeRepository: testMergeRepository,
      settingsStorage: settingsStorage,
      questionStatsRepository: questionStatsRepository,
    );
  }
}
