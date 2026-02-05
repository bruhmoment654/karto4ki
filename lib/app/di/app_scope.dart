import 'package:karto4ki/core/services/csv_import_service.dart';
import 'package:karto4ki/feature/card_detail/domain/repository/i_card_repository.dart';
import 'package:karto4ki/feature/main/domain/repository/i_main_repository.dart';
import 'package:karto4ki/feature/test_detail/domain/repository/i_test_detail_repository.dart';
import 'package:karto4ki/feature/tests_list/domain/repository/i_tests_list_repository.dart';
import 'package:karto4ki/persistence/database/app_database.dart';

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

  const AppScope({
    required this.database,
    required this.mainRepository,
    required this.cardRepository,
    required this.testsListRepository,
    required this.testDetailRepository,
    required this.csvImportService,
  });
}

abstract interface class IAppScope {
  AppDatabase get database;

  IMainRepository get mainRepository;

  ICardRepository get cardRepository;

  ITestsListRepository get testsListRepository;

  ITestDetailRepository get testDetailRepository;

  ICsvImportService get csvImportService;
}
