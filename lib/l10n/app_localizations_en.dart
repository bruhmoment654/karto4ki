// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'All We Need';

  @override
  String get somethingWentWrong => 'Что-то пошло не так';

  @override
  String get formatError => 'Неправильный формат фотографии';

  @override
  String get loadingWidgetSubtitle => 'Идет загрузка';

  @override
  String get positiveResponse => 'Да';

  @override
  String get navigationMain => 'Главная';

  @override
  String get navigationCatalog => 'Каталог';

  @override
  String get navigationCart => 'Корзина';

  @override
  String get navigationWishlist => 'Вишлист';

  @override
  String get navigationProfile => 'Профиль';

  @override
  String get productIsComingSoon => 'Скоро в продаже';

  @override
  String get productInStock => 'Снова в наличии';

  @override
  String get productIsOnlyShops => 'Только в магазинах';

  @override
  String get authEnterCode => 'Введите код из СМС';
}
