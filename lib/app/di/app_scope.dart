import 'package:quizzerg/core/services/csv_import_service.dart';
import 'package:quizzerg/feature/group_detail/domain/repository/i_group_detail_repository.dart';
import 'package:quizzerg/feature/groups_list/domain/repository/i_groups_list_repository.dart';
import 'package:quizzerg/feature/main/domain/repository/i_main_repository.dart';
import 'package:quizzerg/feature/mixup/domain/bloc/mixup_bloc.dart';
import 'package:quizzerg/feature/question_stats/domain/repository/i_question_stats_repository.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_card_repository.dart';
import 'package:quizzerg/feature/test_detail/domain/repository/i_test_detail_repository.dart';
import 'package:quizzerg/feature/test_merge/domain/repository/i_test_merge_repository.dart';
import 'package:quizzerg/feature/tests_list/domain/repository/i_tests_list_repository.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
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
}
