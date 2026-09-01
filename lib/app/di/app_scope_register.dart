import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as pkg_logger;
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/core/logger/strategies/debug_log_strategy.dart';
import 'package:quizzerg/core/services/csv_import_service.dart';
import 'package:quizzerg/feature/developer/data/repository/debug_repository.dart';
import 'package:quizzerg/feature/group_detail/data/repository/group_detail_repository.dart';
import 'package:quizzerg/feature/group_detail/domain/repository/i_group_detail_repository.dart';
import 'package:quizzerg/feature/groups_list/data/repository/groups_api_repository.dart';
import 'package:quizzerg/feature/groups_list/data/repository/groups_list_repository.dart';
import 'package:quizzerg/feature/groups_list/data/sync/group_sync_adapter.dart';
import 'package:quizzerg/feature/groups_list/domain/repository/i_groups_list_repository.dart';
import 'package:quizzerg/feature/import/data/repository/import_api_repository.dart';
import 'package:quizzerg/feature/main/data/repository/main_repository.dart';
import 'package:quizzerg/feature/main/domain/repository/i_main_repository.dart';
import 'package:quizzerg/feature/mixup/domain/bloc/mixup_bloc.dart';
import 'package:quizzerg/feature/profile/data/repository/profile_api_repository.dart';
import 'package:quizzerg/feature/question_stats/data/repository/question_stats_repository.dart';
import 'package:quizzerg/feature/question_stats/data/repository/stats_api_repository.dart';
import 'package:quizzerg/feature/question_stats/data/service/stats_export_service.dart';
import 'package:quizzerg/feature/question_stats/data/sync/stats_sync_adapter.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/question_stats/domain/service/i_stats_export_service.dart';
import 'package:quizzerg/feature/sync/data/repository/sync_api_repository.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_engine.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_entity_adapter.dart';
import 'package:quizzerg/feature/test_detail/data/repository/card_repository.dart';
import 'package:quizzerg/feature/test_detail/data/repository/cards_api_repository.dart';
import 'package:quizzerg/feature/test_detail/data/repository/test_detail_repository.dart';
import 'package:quizzerg/feature/test_detail/data/sync/card_sync_adapter.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_card_repository.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_test_detail_repository.dart';
import 'package:quizzerg/feature/test_execution/data/repository/active_session_drift_repository.dart';
import 'package:quizzerg/feature/test_execution/domain/repository/i_active_session_repository.dart';
import 'package:quizzerg/feature/test_merge/data/repository/test_merge_repository.dart';
import 'package:quizzerg/feature/test_merge/domain/repository/i_test_merge_repository.dart';
import 'package:quizzerg/feature/tests_list/data/repository/tests_api_repository.dart';
import 'package:quizzerg/feature/tests_list/data/repository/tests_list_repository.dart';
import 'package:quizzerg/feature/tests_list/data/sync/test_sync_adapter.dart';
import 'package:quizzerg/feature/tests_list/domain/repository/i_tests_list_repository.dart';
import 'package:quizzerg/feature/tokens/data/repository/tokens_api_repository.dart';
import 'package:quizzerg/network/api/api_client.dart';
import 'package:quizzerg/network/api/api_config.dart';
import 'package:quizzerg/network/api/api_environment.dart';
import 'package:quizzerg/network/api/auth_token_provider.dart';
import 'package:quizzerg/network/api/dio_factory.dart';
import 'package:quizzerg/network/api/dio_proxy.dart';
import 'package:quizzerg/network/health/health_api_repository.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:quizzerg/persistence/debug/debug_config_storage.dart';
import 'package:quizzerg/persistence/debug/i_debug_config_storage.dart';
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
    final errorLogger = _createErrorLogger();
    final settingsStorage = SettingsStorage(prefs);
    final debugConfigStorage = DebugConfigStorage(prefs);
    final local = _createLocalDependencies(
      database: database,
      prefs: prefs,
      settingsStorage: settingsStorage,
      errorLogger: errorLogger,
    );

    final network = _createNetwork(
      errorLogger: errorLogger,
      debugConfigStorage: debugConfigStorage,
    );
    final syncApiRepository = SyncApiRepository(
      client: network.client,
      config: network.config,
    );
    final syncEngine = SyncEngine(
      api: syncApiRepository,
      syncDatabase: database.syncDatabase,
      adapters: _createSyncAdapters(database),
      errorLogger: errorLogger,
    );

    return AppScope(
      database: database,
      settingsStorage: settingsStorage,
      csvImportService: const CsvImportService(),
      mainRepository: local.mainRepository,
      mixupBloc: local.mixupBloc,
      cardRepository: local.cardRepository,
      testsListRepository: local.testsListRepository,
      testDetailRepository: local.testDetailRepository,
      testMergeRepository: local.testMergeRepository,
      questionStatsRepository: local.questionStatsRepository,
      groupsListRepository: local.groupsListRepository,
      groupDetailRepository: local.groupDetailRepository,
      statsExportService: local.statsExportService,
      activeSessionRepository: local.activeSessionRepository,
      apiConfig: network.config,
      authTokenProvider: network.tokenProvider,
      syncApiRepository: syncApiRepository,
      syncEngine: syncEngine,
      syncBloc: SyncBloc(engine: syncEngine, connectivity: Connectivity()),
      groupsApiRepository: GroupsApiRepository(client: network.client),
      testsApiRepository: TestsApiRepository(client: network.client),
      cardsApiRepository: CardsApiRepository(client: network.client),
      statsApiRepository: StatsApiRepository(client: network.client),
      profileApiRepository: ProfileApiRepository(client: network.client),
      tokensApiRepository: TokensApiRepository(client: network.client),
      importApiRepository: ImportApiRepository(
        client: network.client,
        config: network.config,
      ),
      healthApiRepository: HealthApiRepository(client: network.client),
      debugConfigStorage: debugConfigStorage,
      debugRepository: DebugRepository(
        debugConfigStorage: debugConfigStorage,
        apiConfig: network.config,
        dio: network.client.dio,
        errorLogger: errorLogger,
      ),
    );
  }

  /// Зависимости, работающие поверх локальной БД и настроек.
  _LocalDependencies _createLocalDependencies({
    required AppDatabase database,
    required SharedPreferences prefs,
    required SettingsStorage settingsStorage,
    required ErrorLogger errorLogger,
  }) =>
      _LocalDependencies(
        mainRepository: MainRepository(prefs),
        mixupBloc: MixupBloc(settingsStorage: settingsStorage),
        cardRepository: CardRepository(
          cardsDatabase: database.cardsDatabase,
          errorLogger: errorLogger,
        ),
        testsListRepository: TestsListRepository(
          testsDatabase: database.testsDatabase,
          errorLogger: errorLogger,
        ),
        testDetailRepository: TestDetailRepository(
          testsDatabase: database.testsDatabase,
          cardsDatabase: database.cardsDatabase,
          errorLogger: errorLogger,
        ),
        testMergeRepository: TestMergeRepository(
          testsDatabase: database.testsDatabase,
          cardsDatabase: database.cardsDatabase,
          errorLogger: errorLogger,
        ),
        questionStatsRepository: QuestionStatsRepository(
          questionStatsDatabase: database.questionStatsDatabase,
          syncDatabase: database.syncDatabase,
          errorLogger: errorLogger,
        ),
        groupsListRepository: GroupsListRepository(
          groupsDatabase: database.groupsDatabase,
          testsDatabase: database.testsDatabase,
          errorLogger: errorLogger,
        ),
        groupDetailRepository: GroupDetailRepository(
          groupsDatabase: database.groupsDatabase,
          testsDatabase: database.testsDatabase,
          cardsDatabase: database.cardsDatabase,
          errorLogger: errorLogger,
        ),
        statsExportService: StatsExportService(
          questionStatsDatabase: database.questionStatsDatabase,
          cardsDatabase: database.cardsDatabase,
          testsDatabase: database.testsDatabase,
          groupsDatabase: database.groupsDatabase,
          settingsStorage: settingsStorage,
        ),
        activeSessionRepository: ActiveSessionDriftRepository(
          database: database.activeSessionsDatabase,
          errorLogger: errorLogger,
        ),
      );

  ErrorLogger _createErrorLogger() => SurfErrorLogger(
        surf_logger.Logger.withStrategies(
          {DebugLogStrategy(pkg_logger.Logger())},
        ),
      );

  /// Транспорт. Источник токена пока анонимный — его подменит
  /// фича авторизации, когда появится.
  _Network _createNetwork({
    required ErrorLogger errorLogger,
    required IDebugConfigStorage debugConfigStorage,
  }) {
    const config = ApiConfig(
      environment: kDebugMode ? ApiEnvironment.dev : ApiEnvironment.prod,
      enableLogging: kDebugMode,
    );
    const tokenProvider = AnonymousAuthTokenProvider();

    final dio = DioFactory.create(
      config: config,
      tokenProvider: tokenProvider,
      errorLogger: errorLogger,
    );
    // Прокси, сохранённый на дебаг-экране, должен работать сразу после старта.
    DioProxy.apply(dio, debugConfigStorage.getProxyUrl());

    return _Network(
      config: config,
      tokenProvider: tokenProvider,
      client: ApiClient(dio),
    );
  }

  List<SyncEntityAdapter> _createSyncAdapters(AppDatabase database) => [
        GroupSyncAdapter(groupsDatabase: database.groupsDatabase),
        TestSyncAdapter(
          testsDatabase: database.testsDatabase,
          cardsDatabase: database.cardsDatabase,
          groupsDatabase: database.groupsDatabase,
        ),
        CardSyncAdapter(cardsDatabase: database.cardsDatabase),
        StatsSyncAdapter(
          questionStatsDatabase: database.questionStatsDatabase,
        ),
      ];
}

/// Собранный транспортный слой.
class _Network {
  final ApiConfig config;
  final IAuthTokenProvider tokenProvider;
  final ApiClient client;

  const _Network({
    required this.config,
    required this.tokenProvider,
    required this.client,
  });
}

/// Зависимости, не зависящие от сети.
class _LocalDependencies {
  final IMainRepository mainRepository;
  final MixupBloc mixupBloc;
  final ICardRepository cardRepository;
  final ITestsListRepository testsListRepository;
  final ITestDetailRepository testDetailRepository;
  final ITestMergeRepository testMergeRepository;
  final IQuestionStatsRepository questionStatsRepository;
  final IGroupsListRepository groupsListRepository;
  final IGroupDetailRepository groupDetailRepository;
  final IStatsExportService statsExportService;
  final IActiveSessionRepository activeSessionRepository;

  const _LocalDependencies({
    required this.mainRepository,
    required this.mixupBloc,
    required this.cardRepository,
    required this.testsListRepository,
    required this.testDetailRepository,
    required this.testMergeRepository,
    required this.questionStatsRepository,
    required this.groupsListRepository,
    required this.groupDetailRepository,
    required this.statsExportService,
    required this.activeSessionRepository,
  });
}
