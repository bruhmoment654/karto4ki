import 'package:karto4ki/app/di/app_scope.dart';
import 'package:karto4ki/core/services/csv_import_service.dart';
import 'package:karto4ki/feature/card_detail/data/repository/card_repository.dart';
import 'package:karto4ki/feature/main/data/repository/main_repository.dart';
import 'package:karto4ki/feature/test_detail/data/repository/test_detail_repository.dart';
import 'package:karto4ki/feature/tests_list/data/repository/tests_list_repository.dart';
import 'package:karto4ki/persistence/card_test/card_test_storage.dart';
import 'package:karto4ki/persistence/database/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Application dependency registrar.
///
/// Creates and configures all dependencies for [AppScope].
class AppScopeRegister {
  Future<IAppScope> createScope() async {
    final prefs = await SharedPreferences.getInstance();
    final database = AppDatabase();

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

    return AppScope(
      database: database,
      mainRepository: mainRepository,
      cardRepository: cardRepository,
      testsListRepository: testsListRepository,
      testDetailRepository: testDetailRepository,
      csvImportService: csvImportService,
    );
  }
}
