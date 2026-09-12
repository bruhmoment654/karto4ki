import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as pkg_logger;
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/core/logger/strategies/debug_log_strategy.dart';
import 'package:quizzerg/core/services/csv_import_service.dart';
import 'package:quizzerg/feature/auth/auth_config.dart';
import 'package:quizzerg/feature/auth/data/auth_token_provider.dart';
import 'package:quizzerg/feature/auth/data/repository/auth_api_repository.dart';
import 'package:quizzerg/feature/auth/data/repository/auth_status_repository.dart';
import 'package:quizzerg/feature/auth/data/service/google_sign_in_service.dart';
import 'package:quizzerg/feature/auth/data/service/i_google_sign_in_service.dart';
import 'package:quizzerg/feature/auth/data/storage/auth_token_storage.dart';
import 'package:quizzerg/feature/auth/data/storage/auth_user_storage.dart';
import 'package:quizzerg/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_status.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_status_repository.dart';
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
import 'package:quizzerg/feature/settings/domain/bloc/settings_bloc.dart';
import 'package:quizzerg/feature/sync/data/repository/sync_api_repository.dart';
import 'package:quizzerg/feature/sync/data/repository/sync_signal_repository.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_auth_status.dart';
import 'package:quizzerg/feature/sync/domain/service/server_clock.dart';
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

    final auth = _createAuth(
      prefs: prefs,
      debugConfigStorage: debugConfigStorage,
      errorLogger: errorLogger,
    );
    final network = auth.network;
    final sync = _createSync(
      database: database,
      network: network,
      authStatus: auth.statusRepository,
      errorLogger: errorLogger,
    );

    return AppScope(
      database: database,
      settingsStorage: settingsStorage,
      csvImportService: const CsvImportService(),
      mainRepository: local.mainRepository,
      mixupBloc: local.mixupBloc,
      settingsBloc: local.settingsBloc,
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
      authTokenProvider: auth.tokenProvider,
      authBloc: auth.bloc,
      authApiRepository: auth.apiRepository,
      authTokenStorage: auth.tokenStorage,
      authStatusRepository: auth.statusRepository,
      googleSignInService: auth.googleSignInService,
      syncApiRepository: sync.api,
      syncEngine: sync.engine,
      syncBloc: sync.bloc,
      syncSignalRepository: sync.signal,
      serverClock: sync.clock,
      groupsApiRepository: GroupsApiRepository(client: network.client),
      testsApiRepository: TestsApiRepository(client: network.client),
      cardsApiRepository: CardsApiRepository(client: network.client),
      statsApiRepository: StatsApiRepository(client: network.client),
      profileApiRepository: auth.profileApiRepository,
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

  /// Транспорт и авторизация.
  ///
  /// Порядок важен: провайдеру токена нужен клиент для `/auth/refresh`,
  /// а клиенту — провайдер. Цикл разрывается setter-инъекцией.
  _Auth _createAuth({
    required SharedPreferences prefs,
    required DebugConfigStorage debugConfigStorage,
    required ErrorLogger errorLogger,
  }) {
    const tokenStorage = AuthTokenStorage();
    // Владелец сессии. На его поток подписаны и AuthBloc, и SyncBloc —
    // так блоки не зависят друг от друга.
    final statusRepository = AuthStatusRepository(storage: tokenStorage);
    final tokenProvider = AuthTokenProvider(
      authStatus: statusRepository,
      errorLogger: errorLogger,
    );
    final network = _createNetwork(
      errorLogger: errorLogger,
      debugConfigStorage: debugConfigStorage,
      tokenProvider: tokenProvider,
    );
    final apiRepository = AuthApiRepository(client: network.client);
    tokenProvider.attach(apiRepository);

    final profileApiRepository = ProfileApiRepository(client: network.client);
    // iOS-реализации ещё нет: без этой ветки оттуда полетел бы
    // MissingPluginException вместо внятного сообщения.
    final googleSignInService = Platform.isAndroid
        ? GoogleSignInService(serverClientId: AuthConfig.googleServerClientId)
        : const StubGoogleSignInService();

    return _Auth(
      network: network,
      tokenStorage: tokenStorage,
      statusRepository: statusRepository,
      tokenProvider: tokenProvider,
      apiRepository: apiRepository,
      profileApiRepository: profileApiRepository,
      googleSignInService: googleSignInService,
      bloc: _createAuthBloc(
        prefs: prefs,
        api: apiRepository,
        profileApi: profileApiRepository,
        authStatus: statusRepository,
        googleSignIn: googleSignInService,
        errorLogger: errorLogger,
      ),
    );
  }

  /// Стек синхронизации: часы сервера, API, движок и его BLoC.
  _Sync _createSync({
    required AppDatabase database,
    required _Network network,
    required IAuthStatusRepository authStatus,
    required ErrorLogger errorLogger,
  }) {
    final clock = ServerClock();
    final signal = SyncSignalRepository();
    final api = SyncApiRepository(
      client: network.client,
      config: network.config,
    );
    final engine = SyncEngine(
      api: api,
      syncDatabase: database.syncDatabase,
      adapters: _createSyncAdapters(database),
      serverClock: clock,
      errorLogger: errorLogger,
    );

    return _Sync(
      clock: clock,
      signal: signal,
      api: api,
      engine: engine,
      bloc: SyncBloc(
        engine: engine,
        syncDatabase: database.syncDatabase,
        syncSignal: signal,
        connectivityChanges: Connectivity().onConnectivityChanged,
        authStatus: _syncAuthStatus(authStatus),
      )..add(const SyncEvent.started()),
    );
  }

  /// Единственный владелец сессии на всё приложение.
  AuthBloc _createAuthBloc({
    required SharedPreferences prefs,
    required AuthApiRepository api,
    required ProfileApiRepository profileApi,
    required IAuthStatusRepository authStatus,
    required IGoogleSignInService googleSignIn,
    required ErrorLogger errorLogger,
  }) =>
      AuthBloc(
        api: api,
        profileApi: profileApi,
        authStatus: authStatus,
        userStorage: AuthUserStorage(prefs),
        googleSignIn: googleSignIn,
        errorLogger: errorLogger,
      )..add(const AuthEvent.started());

  /// Зависимости, работающие поверх локальной БД и настроек.
  _LocalDependencies _createLocalDependencies({
    required AppDatabase database,
    required SharedPreferences prefs,
    required SettingsStorage settingsStorage,
    required ErrorLogger errorLogger,
  }) {
    final statsExportService = StatsExportService(
      questionStatsDatabase: database.questionStatsDatabase,
      cardsDatabase: database.cardsDatabase,
      testsDatabase: database.testsDatabase,
      groupsDatabase: database.groupsDatabase,
      settingsStorage: settingsStorage,
    );

    return _LocalDependencies(
        mainRepository: MainRepository(prefs),
        mixupBloc: MixupBloc(settingsStorage: settingsStorage),
        settingsBloc: SettingsBloc(
          settingsStorage: settingsStorage,
          statsExportService: statsExportService,
        )..add(const SettingsEvent.started()),
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
        statsExportService: statsExportService,
        activeSessionRepository: ActiveSessionDriftRepository(
          database: database.activeSessionsDatabase,
          errorLogger: errorLogger,
        ),
      );
  }

  ErrorLogger _createErrorLogger() => SurfErrorLogger(
        surf_logger.Logger.withStrategies(
          {DebugLogStrategy(pkg_logger.Logger())},
        ),
      );

  /// Статус сессии в терминах синхронизации.
  ///
  /// `unknown` пропускаем: пока хранилище не прочитано, запускать и гасить
  /// нечего. Реплей текущего значения даёт сам репозиторий, поэтому
  /// поздняя подписка `SyncBloc` ничего не теряет.
  static Stream<SyncAuthStatus> _syncAuthStatus(
    IAuthStatusRepository repository,
  ) =>
      repository.statusChanges
          .map(_syncAuthStatusOf)
          .where((status) => status != null)
          .cast<SyncAuthStatus>()
          .distinct();

  static SyncAuthStatus? _syncAuthStatusOf(AuthStatus status) =>
      switch (status) {
        AuthStatus.authorized => SyncAuthStatus.active,
        AuthStatus.expired => SyncAuthStatus.expired,
        AuthStatus.unauthorized => SyncAuthStatus.none,
        AuthStatus.unknown => null,
      };

  /// Транспорт.
  _Network _createNetwork({
    required ErrorLogger errorLogger,
    required IDebugConfigStorage debugConfigStorage,
    required IAuthTokenProvider tokenProvider,
  }) {
    const config = ApiConfig(
      environment: kDebugMode ? AppUrl.dev : AppUrl.prod,
      enableLogging: kDebugMode,
    );

    final dio = DioFactory.create(
      config: config,
      tokenProvider: tokenProvider,
      errorLogger: errorLogger,
    );
    // Прокси, сохранённый на дебаг-экране, должен работать сразу после старта.
    DioProxy.apply(dio, debugConfigStorage.getProxyUrl());

    return _Network(config: config, client: ApiClient(dio));
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

/// Собранные транспорт и авторизация.
class _Auth {
  final _Network network;
  final AuthTokenStorage tokenStorage;
  final AuthStatusRepository statusRepository;
  final AuthTokenProvider tokenProvider;
  final AuthApiRepository apiRepository;
  final ProfileApiRepository profileApiRepository;
  final IGoogleSignInService googleSignInService;
  final AuthBloc bloc;

  const _Auth({
    required this.network,
    required this.tokenStorage,
    required this.statusRepository,
    required this.tokenProvider,
    required this.apiRepository,
    required this.profileApiRepository,
    required this.googleSignInService,
    required this.bloc,
  });
}

/// Собранный стек синхронизации.
class _Sync {
  final ServerClock clock;
  final SyncSignalRepository signal;
  final SyncApiRepository api;
  final SyncEngine engine;
  final SyncBloc bloc;

  const _Sync({
    required this.clock,
    required this.signal,
    required this.api,
    required this.engine,
    required this.bloc,
  });
}

/// Собранный транспортный слой.
class _Network {
  final ApiConfig config;
  final ApiClient client;

  const _Network({required this.config, required this.client});
}

/// Зависимости, не зависящие от сети.
class _LocalDependencies {
  final IMainRepository mainRepository;
  final MixupBloc mixupBloc;
  final SettingsBloc settingsBloc;
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
    required this.settingsBloc,
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
