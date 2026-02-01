import 'package:karto4ki/feature/card_detail/domain/repository/i_card_repository.dart';
import 'package:karto4ki/feature/main/domain/repository/i_main_repository.dart';

final class AppScope implements IAppScope {
  @override
  final IMainRepository mainRepository;

  @override
  final ICardRepository cardRepository;

  const AppScope({
    required this.mainRepository,
    required this.cardRepository,
  });
}

abstract interface class IAppScope {
  IMainRepository get mainRepository;

  ICardRepository get cardRepository;
}
