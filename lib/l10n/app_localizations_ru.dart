// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

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
  String get authEnterCode => 'Введите код';

  @override
  String get tinderTestAppBarTitle => 'Тест';

  @override
  String get tinderTestEmptyTitle => 'В тесте нет карточек';

  @override
  String get tinderTestEmptySubtitle => 'Добавьте карточки, чтобы начать тест';

  @override
  String get tinderTestBackButton => 'Назад';

  @override
  String tinderTestProgressLabel(int current, int total) {
    return 'Карточка $current из $total';
  }

  @override
  String get tinderTestTapToShowAnswer => 'Нажмите, чтобы увидеть ответ';

  @override
  String get tinderTestUnknownBadge => 'НЕ ЗНАЮ';

  @override
  String get tinderTestKnownBadge => 'ЗНАЮ';

  @override
  String get tinderTestSwipeUnknownHint => 'Не знаю';

  @override
  String get tinderTestSwipeKnownHint => 'Знаю';

  @override
  String get tinderTestResultsTitle => 'Тест завершён!';

  @override
  String get tinderTestResultsCorrectLabel => 'Правильно';

  @override
  String get tinderTestResultsIncorrectLabel => 'Неправильно';

  @override
  String get tinderTestResultsPercentageLabel => 'Результат';

  @override
  String get tinderTestResultsRestartButton => 'Повторить';

  @override
  String get tinderTestResultsDoneButton => 'Готово';

  @override
  String get testsListAppBarTitle => 'Тесты';

  @override
  String testsListErrorMessage(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get testsListUnknownError => 'Неизвестная ошибка';

  @override
  String get testsListRetryButton => 'Повторить';

  @override
  String get testsListEmptyMessage => 'Нет тестов.\nНажмите + чтобы создать первый тест.';

  @override
  String get testsListDeleteDialogTitle => 'Удалить тест?';

  @override
  String testsListDeleteDialogMessage(String title) {
    return 'Вы уверены, что хотите удалить \"$title\"?';
  }

  @override
  String get testsListDeleteDialogCancel => 'Отмена';

  @override
  String get testsListDeleteDialogConfirm => 'Удалить';

  @override
  String get testDetailLoadingTitle => 'Загрузка...';

  @override
  String get testDetailEditTooltip => 'Редактировать тест';

  @override
  String testDetailErrorMessage(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get testDetailUnknownError => 'Неизвестная ошибка';

  @override
  String get testDetailRetryButton => 'Повторить';

  @override
  String get testDetailStartButton => 'Начать тест';

  @override
  String testDetailCardsTitle(int count) {
    return 'Карточки ($count)';
  }

  @override
  String get testDetailEmptyCardsMessage => 'Нет карточек.\nНажмите + чтобы добавить первую.';

  @override
  String get testDetailDeleteCardTitle => 'Удалить карточку?';

  @override
  String get testDetailDeleteCardMessage => 'Вы уверены, что хотите удалить эту карточку?';

  @override
  String get testDetailDeleteCardCancel => 'Отмена';

  @override
  String get testDetailDeleteCardConfirm => 'Удалить';

  @override
  String get mainQuestionCardFront => 'Вопрос';

  @override
  String get mainQuestionCardBack => 'Ответ';

  @override
  String get csvImportButton => 'Импорт CSV';

  @override
  String get csvImportDialogTitle => 'Импорт карточек из CSV';

  @override
  String get csvImportDialogDescription => 'Формат файла:\n• 1 столбец — вопрос (слово)\n• 2 столбец — ответ (перевод)\n• Разделитель: точка с запятой (;)';

  @override
  String get csvImportDialogContinue => 'Выбрать файл';

  @override
  String get csvImportDialogCancel => 'Отмена';

  @override
  String get csvImportErrorEmpty => 'Файл пустой или не содержит данных';

  @override
  String get csvImportErrorFormat => 'Неверный формат CSV. Требуется минимум 2 столбца.';

  @override
  String get csvImportErrorRead => 'Не удалось прочитать файл';

  @override
  String csvImportSuccess(int count) {
    return 'Импортировано карточек: $count';
  }

  @override
  String get csvImportCancelled => 'Импорт отменён';
}
