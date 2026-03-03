import 'package:logger/logger.dart' as pkg_logger;
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/core/logger/strategies/debug_log_strategy.dart';
import 'package:quizzerg/core/services/csv_import_service.dart';
import 'package:quizzerg/feature/group_detail/data/repository/group_detail_repository.dart';
import 'package:quizzerg/feature/groups_list/data/repository/groups_list_repository.dart';
import 'package:quizzerg/feature/main/data/repository/main_repository.dart';
import 'package:quizzerg/feature/mixup/domain/bloc/mixup_bloc.dart';
import 'package:quizzerg/feature/question_stats/data/repository/question_stats_repository.dart';
import 'package:quizzerg/feature/test_detail/data/repository/card_repository.dart';
import 'package:quizzerg/feature/test_detail/data/repository/test_detail_repository.dart';
import 'package:quizzerg/feature/test_merge/data/repository/test_merge_repository.dart';
import 'package:quizzerg/feature/tests_list/data/repository/tests_list_repository.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:quizzerg/persistence/settings/settings_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_logger/surf_logger.dart' as surf_logger;

/// Application dependency registrar.
///
/// Creates and configures all dependencies for [AppScope].
class AppScopeRegister {
  Future<IAppScope> createScope() async {
    final prefs = await SharedPreferences.getInstance();
    final database = AppDatabase();

    final logWriter = surf_logger.Logger.withStrategies(
      {DebugLogStrategy(pkg_logger.Logger())},
    );
    final errorLogger = SurfErrorLogger(logWriter);

    final settingsStorage = SettingsStorage(prefs);
    final mainRepository = MainRepository(prefs);
    final cardRepository = CardRepository(
      cardsDatabase: database.cardsDatabase,
      errorLogger: errorLogger,
    );
    final testsListRepository = TestsListRepository(
      testsDatabase: database.testsDatabase,
      errorLogger: errorLogger,
    );
    final testDetailRepository = TestDetailRepository(
      testsDatabase: database.testsDatabase,
      cardsDatabase: database.cardsDatabase,
      errorLogger: errorLogger,
    );

    const csvImportService = CsvImportService();

    final testMergeRepository = TestMergeRepository(
      testsDatabase: database.testsDatabase,
      cardsDatabase: database.cardsDatabase,
      errorLogger: errorLogger,
    );

    final questionStatsRepository = QuestionStatsRepository(
      questionStatsDatabase: database.questionStatsDatabase,
      errorLogger: errorLogger,
    );

    final groupsListRepository = GroupsListRepository(
      groupsDatabase: database.groupsDatabase,
      errorLogger: errorLogger,
    );

    final groupDetailRepository = GroupDetailRepository(
      groupsDatabase: database.groupsDatabase,
      testsDatabase: database.testsDatabase,
      errorLogger: errorLogger,
    );

    final mixupBloc = MixupBloc(settingsStorage: settingsStorage);

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
      groupsListRepository: groupsListRepository,
      groupDetailRepository: groupDetailRepository,
      mixupBloc: mixupBloc,
    );
  }
}
