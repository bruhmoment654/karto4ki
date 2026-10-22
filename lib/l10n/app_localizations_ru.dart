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
  String get tinderTestTapToShowAnswer => 'Нажмите, чтобы перевернуть';

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
  String get tinderTestResultsRestartButton => 'Повторить';

  @override
  String get tinderTestResultsDoneButton => 'Готово';

  @override
  String get tinderTestResultsAppBarTitle => 'Результат';

  @override
  String get tinderTestResultsTitleGreat => 'Отличный результат!';

  @override
  String get tinderTestResultsTitleGood => 'Хорошая работа!';

  @override
  String get tinderTestResultsTitleRetry => 'Есть над чем поработать';

  @override
  String tinderTestResultsDeltaUp(int delta) {
    return '+$delta% к прошлому разу';
  }

  @override
  String tinderTestResultsDeltaDown(int delta) {
    return '−$delta% от прошлого раза';
  }

  @override
  String get tinderTestResultsDeltaSame => 'Как в прошлый раз';

  @override
  String get tinderTestResultsFirstAttempt => 'Первое прохождение';

  @override
  String get tinderTestResultsRecentAttempts => 'Последние прохождения';

  @override
  String tinderTestResultsAttemptsCount(int shown, int total) {
    return '$shown из $total';
  }

  @override
  String get tinderTestResultsAttemptNow => 'сейчас';

  @override
  String get tinderTestResultsDynamicsPlaceholderTitle =>
      'Динамика появится позже';

  @override
  String get tinderTestResultsDynamicsPlaceholderSubtitle =>
      'Пройдите тест ещё раз — сравним результат с этим прохождением';

  @override
  String get tinderTestResultsByQuestion => 'По вопросам';

  @override
  String get tinderTestResultsFilterAll => 'Все';

  @override
  String get tinderTestResultsFilterMistakes => 'Ошибки';

  @override
  String get tinderTestResultsAnswerKnow => 'Знаю';

  @override
  String get tinderTestResultsAnswerDontKnow => 'Не знаю';

  @override
  String get tinderTestResultsTrendFirstCorrect => 'Впервые верно';

  @override
  String get tinderTestResultsTrendFixed => 'Исправлено';

  @override
  String get tinderTestResultsTrendForgot => 'Забыто';

  @override
  String get tinderTestResultsTrendRepeatedMistake => 'Снова ошибка';

  @override
  String get tinderTestResultsTrendStable => 'Стабильно';

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
  String get testsListEmptyMessage =>
      'Нет тестов.\nНажмите + чтобы создать первый тест.';

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
  String testDetailCardsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count карточек',
      many: '$count карточек',
      few: '$count карточки',
      one: '$count карточка',
      zero: 'Нет карточек',
    );
    return '$_temp0';
  }

  @override
  String get testDetailEmptyCardsTitle => 'В тесте нет карточек';

  @override
  String get testDetailEmptyCardsMessage =>
      'Карточка — это вопрос и ответ к нему. Добавьте первую вручную или загрузите сразу несколько из файла.';

  @override
  String get testDetailEmptyAddCardButton => 'Добавить карточку';

  @override
  String get testDetailCardDeletedSnack => 'Карточка удалена';

  @override
  String get testDetailSettingsButton => 'Настройки';

  @override
  String get testDetailSwapSides => 'Поменять стороны местами';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonCreate => 'Создать';

  @override
  String get commonUndo => 'Отменить';

  @override
  String actionSheetAccuracy(int percent) {
    return 'точность $percent%';
  }

  @override
  String get testDetailNewCardTitle => 'Новая карточка';

  @override
  String get testDetailEditCardTitle => 'Редактировать карточку';

  @override
  String get testDetailEditTestTitle => 'Редактировать тест';

  @override
  String get testDetailCardFrontLabel => 'Вопрос';

  @override
  String get testDetailCardFrontHint => 'Введите вопрос';

  @override
  String get testDetailCardBackLabel => 'Ответ';

  @override
  String get testDetailCardBackHint => 'Введите ответ (варианты через |)';

  @override
  String get testDetailTestTitleLabel => 'Название';

  @override
  String get testDetailTestDescriptionLabel => 'Описание';

  @override
  String get testSettingsTitle => 'Настройка теста';

  @override
  String get testSettingsSwapSides => 'Инвертировать стороны';

  @override
  String get testSettingsSwapSidesSubtitle => 'Поменять вопрос и ответ местами';

  @override
  String get testSettingsAnswerVariant => 'Вариант для вопроса';

  @override
  String get testSettingsApply => 'Применить';

  @override
  String get groupDetailMixup => 'Подмешивание вопросов';

  @override
  String get groupDetailMixupDescription =>
      'Добавляет вопросы из других тестов группы';

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
  String get csvImportDialogDescription =>
      'Поддерживаемые форматы: CSV, TXT, TSV\n\nФормат файла:\n• 1 столбец — вопрос (слово)\n• 2 столбец — ответ (перевод)\n\nНесколько вариантов ответа можно разделить через | или //';

  @override
  String get csvImportDialogExample =>
      'apple;яблоко\ncat;кот | кошка\ndog;собака // пёс';

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
  String get csvImportErrorFormat =>
      'Неверный формат файла. Требуется минимум 2 столбца.';

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
  String get profileAccentColorTitle => 'Акцентный цвет';

  @override
  String get profileAnimationSpeedTitle => 'Скорость анимаций';

  @override
  String profileAnimationDurationLabel(int duration) {
    return '$duration мс';
  }

  @override
  String get profileCardFontSizeTitle => 'Размер шрифта на карточке';

  @override
  String profileCardFontSizeLabel(int value) {
    return '$value px';
  }

  @override
  String get questionStatsTitle => 'Статистика';

  @override
  String get questionStatsEmptyMessage =>
      'Статистика пока пуста.\nПройдите тест, чтобы начать отслеживание.';

  @override
  String get questionStatsCorrectLabel => 'Правильно';

  @override
  String get questionStatsIncorrectLabel => 'Неправильно';

  @override
  String get questionStatsStreakLabel => 'Серия';

  @override
  String get questionStatsAccuracyLabel => 'Точность';

  @override
  String get questionStatsSortByDate => 'По дате';

  @override
  String get questionStatsSortByStreak => 'По серии';

  @override
  String get questionStatsSortByAccuracy => 'По точности';

  @override
  String get questionStatsSortTitle => 'Сортировка';

  @override
  String get questionStatsSearchHint => 'Поиск по карточкам';

  @override
  String questionStatsSearchFound(int count) {
    return 'Найдено: $count';
  }

  @override
  String get questionStatsSearchEmpty => 'Ничего не найдено';

  @override
  String questionStatsTotalCount(int count) {
    return 'Всего: $count';
  }

  @override
  String get profileDashboardTitle => 'Профиль';

  @override
  String get profileIdentityName => 'karto4ki';

  @override
  String profileIdentitySubtitle(int groups, int tests) {
    String _temp0 = intl.Intl.pluralLogic(
      groups,
      locale: localeName,
      other: '$groups групп',
      many: '$groups групп',
      few: '$groups группы',
      one: '$groups группа',
    );
    String _temp1 = intl.Intl.pluralLogic(
      tests,
      locale: localeName,
      other: '$tests тестов',
      many: '$tests тестов',
      few: '$tests теста',
      one: '$tests тест',
    );
    return '$_temp0 · $_temp1';
  }

  @override
  String get profileStatsCardTitle => 'Статистика';

  @override
  String get profileStatsCardMore => 'Подробнее';

  @override
  String get profileRingAccuracy => 'Точность';

  @override
  String get profileRingMastered => 'Изучено';

  @override
  String get profileRingFlawless => 'Без ошибок';

  @override
  String get profileStreakDaysSuffix => 'дней подряд';

  @override
  String profileStreakBest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дней',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return 'Лучшая серия: $_temp0';
  }

  @override
  String get profileWeekdayMon => 'Пн';

  @override
  String get profileWeekdayTue => 'Вт';

  @override
  String get profileWeekdayWed => 'Ср';

  @override
  String get profileWeekdayThu => 'Чт';

  @override
  String get profileWeekdayFri => 'Пт';

  @override
  String get profileWeekdaySat => 'Сб';

  @override
  String get profileWeekdaySun => 'Вс';

  @override
  String get profileMetricAnswers => 'Всего ответов';

  @override
  String get profileMetricCards => 'Всего карточек';

  @override
  String get profileMetricWeak => 'Слабые карточки';

  @override
  String get profileMetricActiveDays => 'Дней активности';

  @override
  String get profileMetricAvgPerDay => 'Ответов в день';

  @override
  String get profileLoadError => 'Не удалось загрузить статистику';

  @override
  String get profileRetryButton => 'Повторить';

  @override
  String get groupsListAppBarTitle => 'Группы';

  @override
  String get groupsListEmptyTitle => 'Пока нет групп';

  @override
  String get groupsListEmptyMessage =>
      'Группа объединяет тесты по одной теме. Создайте первую, чтобы начать.';

  @override
  String get groupsListEmptyCreateButton => 'Создать группу';

  @override
  String get groupsListAddGroupFab => 'Создать';

  @override
  String get groupsListDeleteDialogCancel => 'Отмена';

  @override
  String get groupsListDeleteDialogConfirm => 'Удалить';

  @override
  String get groupsListActionRename => 'Переименовать';

  @override
  String get groupsListActionSettings => 'Настройки группы';

  @override
  String get groupsListActionDelete => 'Удалить группу';

  @override
  String groupsListDeleteGroupTitle(String title) {
    return 'Удалить группу «$title»?';
  }

  @override
  String get groupsListDeleteGroupBody =>
      'Удалится только группа — тесты из неё останутся в приложении.';

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
  String get groupsListNoTests => 'Нет тестов';

  @override
  String get groupsListAddTest => 'Добавить тест';

  @override
  String get groupsListNotStarted => 'Ещё не начат';

  @override
  String get progressGreatAccuracy => 'Отличная точность';

  @override
  String progressWeakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'слабых',
      many: 'слабых',
      few: 'слабых',
      one: 'слабый',
    );
    return '$count $_temp0';
  }

  @override
  String progressNewCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'новых',
      many: 'новых',
      few: 'новых',
      one: 'новый',
    );
    return '$count $_temp0';
  }

  @override
  String progressStudied(String when) {
    return 'занимались $when';
  }

  @override
  String get progressToday => 'сегодня';

  @override
  String get progressYesterday => 'вчера';

  @override
  String progressDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'дней',
      many: 'дней',
      few: 'дня',
      one: 'день',
    );
    return '$count $_temp0 назад';
  }

  @override
  String get groupsListActiveSessionLabel => 'Продолжить тест';

  @override
  String groupsListActiveSessionCards(int current, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'карточки',
      many: 'карточек',
      few: 'карточек',
      one: 'карточки',
    );
    return '$current из $total $_temp0';
  }

  @override
  String get groupsListActiveSessionResume => 'Продолжить';

  @override
  String get groupsListActiveSessionDismiss => 'Отменить';

  @override
  String get groupDetailLoadingTitle => 'Загрузка...';

  @override
  String get groupDetailAddTestFab => 'Добавить';

  @override
  String get groupDetailEmptyTitle => 'В группе нет тестов';

  @override
  String get groupDetailEmptyMessage =>
      'Тест — это набор карточек-вопросов. Добавьте карточки вручную или загрузите их из файла.';

  @override
  String groupDetailErrorMessage(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get groupDetailUnknownError => 'Неизвестная ошибка';

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

  @override
  String get groupDetailTestActionsRemove => 'Убрать из группы';

  @override
  String get groupDetailAddToGroupTitle => 'Выберите группы';

  @override
  String get groupDetailAddToGroupEmpty => 'Нет других групп';

  @override
  String get groupDetailAddToGroupSave => 'Сохранить';

  @override
  String get groupDetailAddToGroupCancel => 'Отмена';

  @override
  String get groupDetailTestActionsStart => 'Начать';

  @override
  String get groupDetailTestActionsRename => 'Переименовать';

  @override
  String get groupDetailTestActionsMove => 'Переместить в группу';

  @override
  String get groupDetailTestActionsImport => 'Импорт карточек';

  @override
  String get groupDetailRenameTestTitle => 'Переименовать тест';

  @override
  String get groupDetailRenameTestHint => 'Название теста';

  @override
  String groupDetailTestRemovedSnack(String title) {
    return '«$title» убран из группы';
  }

  @override
  String groupDetailTestRemovedLastGroupSnack(String title) {
    return '«$title» убран — других групп у теста нет';
  }

  @override
  String groupDetailMixupRange(int min, int max) {
    return 'Количество: $min–$max';
  }

  @override
  String get groupDetailMixupCountLabel => 'Количество';

  @override
  String get groupDetailMixupAlgorithm => 'Алгоритм подмешивания';

  @override
  String get groupDetailMixupAlgorithmClassic => 'Классический';

  @override
  String get groupDetailMixupAlgorithmScoring => 'Умный';

  @override
  String get groupDetailStreakCoefficients => 'Коэффициенты streak';

  @override
  String get groupDetailStreakNegativeBonus => 'Бонус ошибок';

  @override
  String get groupDetailStreakPositivePenalty => 'Штраф верных';

  @override
  String get groupDetailStreakReset => 'Сбросить по умолчанию';

  @override
  String get groupDetailSettingsSheetTitle => 'Подмешивание';

  @override
  String get groupDetailSettingsButton => 'Настройки подмешивания';

  @override
  String get groupDetailTestsHeader => 'Тесты';

  @override
  String get groupDetailMastered => 'Освоено';

  @override
  String get groupDetailLearning => 'Учится';

  @override
  String get groupDetailWeak => 'Слабые';

  @override
  String get groupDetailNew => 'Новые';

  @override
  String get groupDetailTestNotStarted => 'Не начат';

  @override
  String get groupDetailTestAddCards => 'Добавить';

  @override
  String get groupDetailNewTestButton => 'Новый тест';

  @override
  String groupDetailQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count вопросов',
      many: '$count вопросов',
      few: '$count вопроса',
      one: '$count вопрос',
      zero: 'Нет вопросов',
    );
    return '$_temp0';
  }

  @override
  String get authTitle => 'Войдите в аккаунт';

  @override
  String get authSubtitle =>
      'Синхронизация групп, тестов и прогресса между устройствами. Все карточки продолжат работать и без входа.';

  @override
  String get authGoogleButton => 'Войти через Google';

  @override
  String get authContinueAsGuest => 'Продолжить без входа';

  @override
  String get authLegalNote =>
      'Продолжая, вы принимаете условия использования и политику конфиденциальности.';

  @override
  String get authErrorGeneric => 'Не удалось войти. Попробуйте ещё раз';

  @override
  String get authWelcomeSnack => 'Ваши локальные тесты добавлены в аккаунт';

  @override
  String get profileSignInTitle => 'Войдите в аккаунт';

  @override
  String get profileSignInSubtitle => 'Чтобы синхронизировать прогресс';

  @override
  String get profileSignOutRow => 'Выйти';

  @override
  String get profileSignOutDialogTitle => 'Выйти из аккаунта?';

  @override
  String get profileSignOutDialogMessage =>
      'Локальные карточки останутся на устройстве, синхронизация остановится.';

  @override
  String get profileSignOutDialogConfirm => 'Выйти';

  @override
  String get syncTitleSynced => 'Синхронизировано';

  @override
  String get syncTitleSyncing => 'Синхронизация…';

  @override
  String get syncTitleNotSynced => 'Не синхронизировано';

  @override
  String get syncTitleOffline => 'Офлайн';

  @override
  String get syncTitleExpired => 'Сессия истекла';

  @override
  String get syncTitleFailed => 'Не удалось синхронизировать';

  @override
  String syncSubtitleSyncedRelative(String time) {
    return 'Последний раз — $time';
  }

  @override
  String get syncSubtitleNever => 'Ещё не синхронизировано';

  @override
  String syncSubtitleSyncingCounted(int done, int total) {
    final intl.NumberFormat doneNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String doneString = doneNumberFormat.format(done);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return 'Загружено $doneString из $totalString изменений';
  }

  @override
  String get syncSubtitleSyncingPlain =>
      'Отправляем изменения и забираем свежие';

  @override
  String syncSubtitlePending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count изменения ждут отправки',
      many: '$count изменений ждут отправки',
      few: '$count изменения ждут отправки',
      one: '$count изменение ждёт отправки',
    );
    return '$_temp0';
  }

  @override
  String get syncSubtitleOffline => 'Отправим изменения, когда появится сеть';

  @override
  String get syncSubtitleExpired =>
      'Войдите заново, чтобы синхронизация продолжилась';

  @override
  String get syncSubtitleFailed =>
      'Изменения сохранены на устройстве, попробуйте повторить';

  @override
  String get syncDialogBodySynced =>
      'Все карточки, группы и прогресс сохранены на сервере.';

  @override
  String get syncDialogBodySyncing =>
      'Отправляем изменения и забираем свежие карточки с сервера.';

  @override
  String syncDialogBodyNotSynced(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count изменения пока только на устройстве: их не увидят другие ваши устройства.',
      many:
          '$count изменений пока только на устройстве: их не увидят другие ваши устройства.',
      few:
          '$count изменения пока только на устройстве: их не увидят другие ваши устройства.',
      one:
          '$count изменение пока только на устройстве: его не увидят другие ваши устройства.',
    );
    return '$_temp0';
  }

  @override
  String get syncDialogBodyOffline =>
      'Нет подключения. Приложение работает офлайн, изменения сохраняются на устройстве и уедут автоматически.';

  @override
  String get syncDialogBodyExpired =>
      'Срок сессии истёк, поэтому синхронизация остановлена. Карточки и прогресс сохранены на устройстве.';

  @override
  String get syncDialogBodyFailed =>
      'Синхронизация не удалась. Карточки и прогресс сохранены на устройстве.';

  @override
  String get syncDialogLastSyncLabel => 'Последняя синхронизация';

  @override
  String syncDialogLastSyncApprox(String time) {
    return 'Примерно $time';
  }

  @override
  String get syncDialogClose => 'Закрыть';

  @override
  String get syncActionSync => 'Синхронизировать';

  @override
  String get syncActionRetry => 'Повторить';

  @override
  String get syncActionSignIn => 'Войти';

  @override
  String get syncTimeJustNow => 'только что';

  @override
  String syncTimeMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минуты назад',
      many: '$count минут назад',
      few: '$count минуты назад',
      one: '$count минуту назад',
    );
    return '$_temp0';
  }

  @override
  String syncTimeHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count часа назад',
      many: '$count часов назад',
      few: '$count часа назад',
      one: '$count час назад',
    );
    return '$_temp0';
  }

  @override
  String syncTimeToday(String time) {
    return 'сегодня в $time';
  }

  @override
  String syncTimeYesterday(String time) {
    return 'вчера в $time';
  }

  @override
  String syncTimeAtDate(String date, String time) {
    return '$date в $time';
  }

  @override
  String get syncReauthTitle => 'Нужно войти заново';

  @override
  String get syncReauthBody =>
      'Срок сессии истёк. Карточки и прогресс сохранены на устройстве — после входа всё уедет на сервер.';

  @override
  String get syncReauthLater => 'Позже';

  @override
  String get syncReauthSignIn => 'Войти';

  @override
  String get groupsListTitle => 'Мои группы';

  @override
  String get groupsListSubtitle => 'Группы тестов для обучения по карточкам';

  @override
  String get syncSubtitleSyncedNoTime => 'Все изменения на сервере';

  @override
  String get settingsHistoryTitle => 'История прохождений';

  @override
  String get settingsHistoryDescription =>
      'Прохождения тестов для графиков и динамики на экране результата';

  @override
  String settingsHistoryUsage(String size) {
    return 'Занимает $size';
  }

  @override
  String settingsHistoryUsageEstimate(String size) {
    return 'Занимает ≈ $size';
  }

  @override
  String get settingsHistoryUsageUnknown => 'Размер неизвестен';

  @override
  String get settingsHistoryEmpty => 'Пусто';

  @override
  String get settingsHistoryClear => 'Очистить';

  @override
  String get settingsHistoryClearDialogTitle => 'Очистить историю прохождений?';

  @override
  String get settingsHistoryClearDialogMessage =>
      'Графики и динамика по вопросам начнутся заново. Статистика, тесты и карточки останутся.';

  @override
  String get settingsHistoryClearDialogConfirm => 'Очистить';

  @override
  String get settingsHistoryClearedSnack => 'История очищена';

  @override
  String get settingsHistoryClearFailedSnack => 'Не удалось очистить историю';

  @override
  String settingsHistorySizeBytes(String size) {
    return '$size Б';
  }

  @override
  String settingsHistorySizeKilobytes(String size) {
    return '$size КБ';
  }

  @override
  String settingsHistorySizeMegabytes(String size) {
    return '$size МБ';
  }

  @override
  String get settingsAppearanceTitle => 'Внешний вид';

  @override
  String get settingsThemeTitle => 'Тема';

  @override
  String get settingsThemeLight => 'Светлая';

  @override
  String get settingsThemeDark => 'Тёмная';

  @override
  String get settingsThemeSystem => 'Как в системе';

  @override
  String get settingsStyleTitle => 'Стиль';

  @override
  String get settingsStyleColorful => 'Цветной';

  @override
  String get settingsStyleMonochrome => 'Монохром';

  @override
  String get settingsStyleAmoled => 'AMOLED';

  @override
  String get settingsAccentHintColorful =>
      'Из этого цвета строится вся палитра приложения';

  @override
  String get settingsAccentHintMonochrome =>
      'В монохроме акцент подсвечивает только главное: кнопки, прогресс, выбранное';
}
