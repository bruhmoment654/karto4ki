import 'package:quizzerg/core/services/csv_import_service.dart';
import 'package:quizzerg/feature/auth/data/service/i_google_sign_in_service.dart';
import 'package:quizzerg/feature/auth/data/storage/i_auth_token_storage.dart';
import 'package:quizzerg/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_api_repository.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_status_repository.dart';
import 'package:quizzerg/feature/developer/domain/repository/i_debug_repository.dart';
import 'package:quizzerg/feature/group_detail/domain/repository/i_group_detail_repository.dart';
import 'package:quizzerg/feature/groups_list/domain/repository/i_groups_api_repository.dart';
import 'package:quizzerg/feature/groups_list/domain/repository/i_groups_list_repository.dart';
import 'package:quizzerg/feature/import/domain/repository/i_import_api_repository.dart';
import 'package:quizzerg/feature/main/domain/repository/i_main_repository.dart';
import 'package:quizzerg/feature/mixup/domain/bloc/mixup_bloc.dart';
import 'package:quizzerg/feature/profile/domain/repository/i_profile_api_repository.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_stats_api_repository.dart';
import 'package:quizzerg/feature/question_stats/domain/service/i_stats_export_service.dart';
import 'package:quizzerg/feature/settings/domain/bloc/settings_bloc.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/domain/repository/i_sync_api_repository.dart';
import 'package:quizzerg/feature/sync/domain/repository/i_sync_signal_repository.dart';
import 'package:quizzerg/feature/sync/domain/service/server_clock.dart';
import 'package:quizzerg/feature/sync/domain/service/sync_engine.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_card_repository.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_cards_api_repository.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_test_detail_repository.dart';
import 'package:quizzerg/feature/test_execution/domain/repository/i_active_session_repository.dart';
import 'package:quizzerg/feature/test_merge/domain/repository/i_test_merge_repository.dart';
import 'package:quizzerg/feature/tests_list/domain/repository/i_tests_api_repository.dart';
import 'package:quizzerg/feature/tests_list/domain/repository/i_tests_list_repository.dart';
import 'package:quizzerg/feature/tokens/domain/repository/i_tokens_api_repository.dart';
import 'package:quizzerg/network/api/api_config.dart';
import 'package:quizzerg/network/api/auth_token_provider.dart';
import 'package:quizzerg/network/health/health_api_repository.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:quizzerg/persistence/debug/i_debug_config_storage.dart';
import 'package:quizzerg/persistence/settings/i_settings_storage.dart';

final class AppScope implements IAppScope {
  @override
  final AppDatabase database;

  @override
  final IMainRepository mainRepository;

  @override
  final ICardRepository cardRepository;

  @override
  final ITestsListRepository testsListRepository;

  @override
  final ITestDetailRepository testDetailRepository;

  @override
  final ICsvImportService csvImportService;

  @override
  final ITestMergeRepository testMergeRepository;

  @override
  final ISettingsStorage settingsStorage;

  @override
  final IQuestionStatsRepository questionStatsRepository;

  @override
  final IGroupsListRepository groupsListRepository;

  @override
  final IGroupDetailRepository groupDetailRepository;

  @override
  final MixupBloc mixupBloc;

  @override
  final SettingsBloc settingsBloc;

  @override
  final IStatsExportService statsExportService;

  @override
  final IActiveSessionRepository activeSessionRepository;

  @override
  final ApiConfig apiConfig;

  @override
  final IAuthTokenProvider authTokenProvider;

  @override
  final AuthBloc authBloc;

  @override
  final IAuthApiRepository authApiRepository;

  @override
  final IAuthTokenStorage authTokenStorage;

  @override
  final IAuthStatusRepository authStatusRepository;

  @override
  final IGoogleSignInService googleSignInService;

  @override
  final ISyncApiRepository syncApiRepository;

  @override
  final SyncEngine syncEngine;

  @override
  final SyncBloc syncBloc;

  @override
  final ISyncSignalRepository syncSignalRepository;

  @override
  final ServerClock serverClock;

  @override
  final IGroupsApiRepository groupsApiRepository;

  @override
  final ITestsApiRepository testsApiRepository;

  @override
  final ICardsApiRepository cardsApiRepository;

  @override
  final IStatsApiRepository statsApiRepository;

  @override
  final IProfileApiRepository profileApiRepository;

  @override
  final ITokensApiRepository tokensApiRepository;

  @override
  final IImportApiRepository importApiRepository;

  @override
  final IHealthApiRepository healthApiRepository;

  @override
  final IDebugConfigStorage debugConfigStorage;

  @override
  final IDebugRepository debugRepository;

  const AppScope({
    required this.database,
    required this.mainRepository,
    required this.cardRepository,
    required this.testsListRepository,
    required this.testDetailRepository,
    required this.csvImportService,
    required this.testMergeRepository,
    required this.settingsStorage,
    required this.questionStatsRepository,
    required this.groupsListRepository,
    required this.groupDetailRepository,
    required this.mixupBloc,
    required this.settingsBloc,
    required this.statsExportService,
    required this.activeSessionRepository,
    required this.apiConfig,
    required this.authTokenProvider,
    required this.authBloc,
    required this.authApiRepository,
    required this.authTokenStorage,
    required this.authStatusRepository,
    required this.googleSignInService,
    required this.syncApiRepository,
    required this.syncEngine,
    required this.syncBloc,
    required this.syncSignalRepository,
    required this.serverClock,
    required this.groupsApiRepository,
    required this.testsApiRepository,
    required this.cardsApiRepository,
    required this.statsApiRepository,
    required this.profileApiRepository,
    required this.tokensApiRepository,
    required this.importApiRepository,
    required this.healthApiRepository,
    required this.debugConfigStorage,
    required this.debugRepository,
  });
}

abstract interface class IAppScope {
  AppDatabase get database;

  IMainRepository get mainRepository;

  ICardRepository get cardRepository;

  ITestsListRepository get testsListRepository;

  ITestDetailRepository get testDetailRepository;

  ICsvImportService get csvImportService;

  ITestMergeRepository get testMergeRepository;

  ISettingsStorage get settingsStorage;

  IQuestionStatsRepository get questionStatsRepository;

  IGroupsListRepository get groupsListRepository;

  IGroupDetailRepository get groupDetailRepository;

  MixupBloc get mixupBloc;

  /// Настройки приложения: тема, анимации, размер шрифта, экспорт статистики.
  SettingsBloc get settingsBloc;

  IStatsExportService get statsExportService;

  IActiveSessionRepository get activeSessionRepository;

  /// Настройки транспортного слоя.
  ApiConfig get apiConfig;

  /// Источник токена. Реализуется фичей авторизации.
  IAuthTokenProvider get authTokenProvider;

  /// Единственный владелец сессии.
  AuthBloc get authBloc;

  IAuthApiRepository get authApiRepository;

  IAuthTokenStorage get authTokenStorage;

  /// Владелец сессии: статус и токены. На его поток подписаны `AuthBloc`
  /// и `SyncBloc`.
  IAuthStatusRepository get authStatusRepository;

  /// Получение Google ID-token. Реализация — на стороне владельца проекта.
  IGoogleSignInService get googleSignInService;

  ISyncApiRepository get syncApiRepository;

  SyncEngine get syncEngine;

  SyncBloc get syncBloc;

  /// Сигнал «локальные данные изменились». Мутирующие блоки пишут в него,
  /// `SyncBloc` слушает — блоки друг о друге не знают.
  ISyncSignalRepository get syncSignalRepository;

  /// Часы сервера — по ним считается «синхронизировано N назад».
  ServerClock get serverClock;

  IGroupsApiRepository get groupsApiRepository;

  ITestsApiRepository get testsApiRepository;

  ICardsApiRepository get cardsApiRepository;

  IStatsApiRepository get statsApiRepository;

  IProfileApiRepository get profileApiRepository;

  ITokensApiRepository get tokensApiRepository;

  IImportApiRepository get importApiRepository;

  IHealthApiRepository get healthApiRepository;

  /// Отладочные настройки сборки (прокси).
  IDebugConfigStorage get debugConfigStorage;

  /// Репозиторий дебаг-экрана.
  IDebugRepository get debugRepository;
}
