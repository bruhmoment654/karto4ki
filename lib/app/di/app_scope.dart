import 'package:karto4ki/feature/card_detail/domain/repository/i_card_repository.dart';
import 'package:karto4ki/feature/main/domain/repository/i_main_repository.dart';
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

  const AppScope({
    required this.database,
    required this.mainRepository,
    required this.cardRepository,
    required this.testsListRepository,
  });
}

abstract interface class IAppScope {
  AppDatabase get database;

  IMainRepository get mainRepository;

  ICardRepository get cardRepository;

  ITestsListRepository get testsListRepository;
}
