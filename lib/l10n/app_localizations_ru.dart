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
  String get tinderTestUndoTooltip => 'Отменить последний ответ';

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
  String get testDetailSwapSides => 'Поменять стороны местами';

  @override
  String get testDetailMixup => 'Подмешивание вопросов';

  @override
  String get testDetailMixupDescription => 'Добавляет вопросы из других тестов группы';

  @override
  String get testDetailAddCardFab => 'Добавить';

  @override
  String get testsListAddTestFab => 'Создать';

  @override
  String get mainQuestionCardFront => 'Вопрос';

  @override
  String get mainQuestionCardBack => 'Ответ';

  @override
  String get csvImportButton => 'Импорт из файла';

  @override
  String get csvImportDialogTitle => 'Импорт карточек из файла';

  @override
  String get csvImportDialogDescription => 'Поддерживаемые форматы: CSV, TXT, TSV\n\nФормат файла:\n• 1 столбец — вопрос (слово)\n• 2 столбец — ответ (перевод)';

  @override
  String get csvImportDelimiterLabel => 'Разделитель';

  @override
  String get csvImportDelimiterHint => ';';

  @override
  String get csvImportAddFiles => 'Добавить файлы';

  @override
  String get csvImportFilesTitle => 'Файлы';

  @override
  String get csvImportNoFiles => 'Файлы не выбраны';

  @override
  String get csvImportDialogContinue => 'Импортировать';

  @override
  String get csvImportDialogCancel => 'Отмена';

  @override
  String get csvImportErrorEmpty => 'Файл пустой или не содержит данных';

  @override
  String get csvImportErrorFormat => 'Неверный формат файла. Требуется минимум 2 столбца.';

  @override
  String get csvImportErrorRead => 'Не удалось прочитать файл';

  @override
  String csvImportSuccess(int count, int fileCount) {
    return 'Импортировано карточек: $count из $fileCount файлов';
  }

  @override
  String csvImportPartialSuccess(int count, String failedFiles) {
    return 'Импортировано карточек: $count. Не удалось загрузить: $failedFiles';
  }

  @override
  String get csvImportCancelled => 'Импорт отменён';

  @override
  String get testMergeAppBarTitle => 'Объединение тестов';

  @override
  String get testMergeConfirmButton => 'Объединить';

  @override
  String get testMergeNewTestTitle => 'Название нового теста';

  @override
  String get testMergeSuccessMessage => 'Тест успешно создан';

  @override
  String get testMergeSelectHint => 'Выберите тесты для объединения';

  @override
  String get testActionsDialogTitle => 'Действия';

  @override
  String get testActionMerge => 'Объединить с другими';

  @override
  String get profileSettingsTitle => 'Профиль';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get profileShaderAnimationTitle => 'Анимация фона';

  @override
  String get profileAccentColorTitle => 'Цвет приложения';

  @override
  String get profileAnimationSpeedTitle => 'Скорость анимаций';

  @override
  String profileAnimationDurationLabel(int duration) {
    return '$duration мс';
  }

  @override
  String get questionStatsTitle => 'Статистика';

  @override
  String get questionStatsEmptyMessage => 'Статистика пока пуста.\nПройдите тест, чтобы начать отслеживание.';

  @override
  String get questionStatsCorrectLabel => 'Правильно';

  @override
  String get questionStatsIncorrectLabel => 'Неправильно';

  @override
  String get questionStatsStreakLabel => 'Серия';

  @override
  String get questionStatsAccuracyLabel => 'Точность';

  @override
  String get groupsListAppBarTitle => 'Группы';

  @override
  String get groupsListEmptyMessage => 'Нет групп.\nНажмите + чтобы создать первую группу.';

  @override
  String get groupsListAddGroupFab => 'Создать';

  @override
  String get groupsListDeleteDialogTitle => 'Удалить группу?';

  @override
  String groupsListDeleteDialogMessage(String title) {
    return 'Вы уверены, что хотите удалить \"$title\"? Тесты внутри группы не будут удалены.';
  }

  @override
  String get groupsListDeleteDialogCancel => 'Отмена';

  @override
  String get groupsListDeleteDialogConfirm => 'Удалить';

  @override
  String groupsListTestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'тестов',
      many: 'тестов',
      few: 'теста',
      one: 'тест',
    );
    return '$count $_temp0';
  }

  @override
  String groupsListErrorMessage(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get groupsListUnknownError => 'Неизвестная ошибка';

  @override
  String get groupsListNewGroupDialogTitle => 'Новая группа';

  @override
  String get groupsListNewGroupNameHint => 'Название группы';

  @override
  String get groupsListNewGroupCancel => 'Отмена';

  @override
  String get groupsListNewGroupCreate => 'Создать';

  @override
  String get groupDetailLoadingTitle => 'Загрузка...';

  @override
  String get groupDetailAddTestFab => 'Добавить';

  @override
  String get groupDetailEmptyMessage => 'Нет тестов в группе.\nНажмите + чтобы добавить первый тест.';

  @override
  String groupDetailErrorMessage(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get groupDetailUnknownError => 'Неизвестная ошибка';

  @override
  String get groupDetailRemoveTestTitle => 'Убрать тест из группы?';

  @override
  String groupDetailRemoveTestMessage(String title) {
    return 'Тест \"$title\" будет убран из этой группы, но не удалён.';
  }

  @override
  String get groupDetailRemoveTestLastGroupTitle => 'Последняя группа';

  @override
  String groupDetailRemoveTestLastGroupMessage(String title) {
    return 'Это последняя группа теста \"$title\". Тест останется без группы.';
  }

  @override
  String get groupDetailRemoveTestCancel => 'Отмена';

  @override
  String get groupDetailRemoveTestConfirm => 'Убрать';

  @override
  String get groupDetailEditTitleDialogTitle => 'Переименовать группу';

  @override
  String get groupDetailEditTitleHint => 'Название группы';

  @override
  String get groupDetailEditTitleCancel => 'Отмена';

  @override
  String get groupDetailEditTitleSave => 'Сохранить';

  @override
  String get groupDetailNewTestDialogTitle => 'Новый тест';

  @override
  String get groupDetailNewTestNameHint => 'Название теста';

  @override
  String get groupDetailNewTestDescriptionHint => 'Описание (необязательно)';

  @override
  String get groupDetailNewTestCancel => 'Отмена';

  @override
  String get groupDetailNewTestCreate => 'Создать';
}
