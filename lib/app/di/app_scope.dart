import 'package:karto4ki/feature/main/domain/repository/i_main_repository.dart';

final class AppScope implements IAppScope {
  @override
  final IMainRepository mainRepository;

  const AppScope({
    required this.mainRepository,
  });
}

abstract interface class IAppScope {
  IMainRepository get mainRepository;
}
