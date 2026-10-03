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

  @override
  String get tinderTestAppBarTitle => 'Test';

  @override
  String get tinderTestEmptyTitle => 'No cards in this test';

  @override
  String get tinderTestEmptySubtitle => 'Add cards to start the test';

  @override
  String get tinderTestBackButton => 'Back';

  @override
  String tinderTestProgressLabel(int current, int total) {
    return 'Card $current of $total';
  }

  @override
  String get tinderTestTapToShowAnswer => 'Tap to show the answer';

  @override
  String get tinderTestUnknownBadge => 'DON\'T KNOW';

  @override
  String get tinderTestKnownBadge => 'KNOW';

  @override
  String get tinderTestUndoTooltip => 'Undo last answer';

  @override
  String get tinderTestSwipeUnknownHint => 'Don\'t know';

  @override
  String get tinderTestSwipeKnownHint => 'Know';

  @override
  String get tinderTestResultsRestartButton => 'Repeat';

  @override
  String get tinderTestResultsDoneButton => 'Done';

  @override
  String get tinderTestResultsAppBarTitle => 'Result';

  @override
  String get tinderTestResultsTitleGreat => 'Great result!';

  @override
  String get tinderTestResultsTitleGood => 'Good job!';

  @override
  String get tinderTestResultsTitleRetry => 'Room for improvement';

  @override
  String tinderTestResultsDeltaUp(int delta) {
    return '+$delta% vs last time';
  }

  @override
  String tinderTestResultsDeltaDown(int delta) {
    return '−$delta% vs last time';
  }

  @override
  String get tinderTestResultsDeltaSame => 'Same as last time';

  @override
  String get tinderTestResultsFirstAttempt => 'First attempt';

  @override
  String get tinderTestResultsRecentAttempts => 'Recent attempts';

  @override
  String tinderTestResultsAttemptsCount(int shown, int total) {
    return '$shown of $total';
  }

  @override
  String get tinderTestResultsAttemptNow => 'now';

  @override
  String get tinderTestResultsDynamicsPlaceholderTitle =>
      'Progress will appear later';

  @override
  String get tinderTestResultsDynamicsPlaceholderSubtitle =>
      'Take the test again to compare the result with this attempt';

  @override
  String get tinderTestResultsByQuestion => 'By question';

  @override
  String get tinderTestResultsFilterAll => 'All';

  @override
  String get tinderTestResultsFilterMistakes => 'Mistakes';

  @override
  String get tinderTestResultsAnswerKnow => 'Know';

  @override
  String get tinderTestResultsAnswerDontKnow => 'Don\'t know';

  @override
  String get tinderTestResultsTrendFirstCorrect => 'First correct';

  @override
  String get tinderTestResultsTrendFixed => 'Fixed';

  @override
  String get tinderTestResultsTrendForgot => 'Forgotten';

  @override
  String get tinderTestResultsTrendRepeatedMistake => 'Wrong again';

  @override
  String get tinderTestResultsTrendStable => 'Stable';

  @override
  String get testsListAppBarTitle => 'Tests';

  @override
  String testsListErrorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get testsListUnknownError => 'Unknown error';

  @override
  String get testsListRetryButton => 'Retry';

  @override
  String get testsListEmptyMessage =>
      'No tests.\nTap + to create the first test.';

  @override
  String get testsListDeleteDialogTitle => 'Delete test?';

  @override
  String testsListDeleteDialogMessage(String title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get testsListDeleteDialogCancel => 'Cancel';

  @override
  String get testsListDeleteDialogConfirm => 'Delete';

  @override
  String get testDetailLoadingTitle => 'Loading...';

  @override
  String get testDetailEditTooltip => 'Edit test';

  @override
  String testDetailErrorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get testDetailUnknownError => 'Unknown error';

  @override
  String get testDetailRetryButton => 'Retry';

  @override
  String get testDetailStartButton => 'Start test';

  @override
  String testDetailCardsTitle(int count) {
    return 'Cards ($count)';
  }

  @override
  String testDetailCardsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cards',
      one: '$count card',
      zero: 'No cards',
    );
    return '$_temp0';
  }

  @override
  String get testDetailEmptyCardsMessage =>
      'No cards.\nTap + to add the first one.';

  @override
  String get testDetailDeleteCardTitle => 'Delete card?';

  @override
  String get testDetailDeleteCardMessage =>
      'Are you sure you want to delete this card?';

  @override
  String get testDetailDeleteCardCancel => 'Cancel';

  @override
  String get testDetailDeleteCardConfirm => 'Delete';

  @override
  String get testDetailSettingsButton => 'Settings';

  @override
  String get testDetailSwapSides => 'Swap sides';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCreate => 'Create';

  @override
  String get testDetailNewCardTitle => 'New card';

  @override
  String get testDetailEditCardTitle => 'Edit card';

  @override
  String get testDetailEditTestTitle => 'Edit test';

  @override
  String get testDetailCardFrontLabel => 'Question';

  @override
  String get testDetailCardFrontHint => 'Enter question';

  @override
  String get testDetailCardBackLabel => 'Answer';

  @override
  String get testDetailCardBackHint => 'Enter answer (variants separated by |)';

  @override
  String get testDetailTestTitleLabel => 'Title';

  @override
  String get testDetailTestDescriptionLabel => 'Description';

  @override
  String get testSettingsTitle => 'Test settings';

  @override
  String get testSettingsSwapSides => 'Invert sides';

  @override
  String get testSettingsSwapSidesSubtitle => 'Swap question and answer';

  @override
  String get testSettingsAnswerVariant => 'Answer variant';

  @override
  String get testSettingsApply => 'Apply';

  @override
  String get groupDetailMixup => 'Question mixup';

  @override
  String get groupDetailMixupDescription =>
      'Adds questions from other tests in the group';

  @override
  String get testDetailAddCardFab => 'Add';

  @override
  String get testsListAddTestFab => 'Create';

  @override
  String get mainQuestionCardFront => 'Question';

  @override
  String get mainQuestionCardBack => 'Answer';

  @override
  String get csvImportButton => 'Import from file';

  @override
  String get csvImportDialogTitle => 'Import cards from file';

  @override
  String get csvImportDialogDescription =>
      'Supported formats: CSV, TXT, TSV\n\nFile format:\n• 1st column — question (word)\n• 2nd column — answer (translation)\n\nMultiple answer variants can be separated with | or //';

  @override
  String get csvImportDialogExample =>
      'apple;яблоко\ncat;кот | кошка\ndog;собака // пёс';

  @override
  String get csvImportDelimiterLabel => 'Delimiter';

  @override
  String get csvImportDelimiterHint => ';';

  @override
  String get csvImportAddFiles => 'Add files';

  @override
  String get csvImportFilesTitle => 'Files';

  @override
  String get csvImportNoFiles => 'No files selected';

  @override
  String get csvImportDialogContinue => 'Import';

  @override
  String get csvImportDialogCancel => 'Cancel';

  @override
  String get csvImportErrorEmpty => 'File is empty or contains no data';

  @override
  String get csvImportErrorFormat =>
      'Invalid file format. Minimum 2 columns required.';

  @override
  String get csvImportErrorRead => 'Could not read file';

  @override
  String csvImportSuccess(int count, int fileCount) {
    return 'Imported cards: $count from $fileCount files';
  }

  @override
  String csvImportPartialSuccess(int count, String failedFiles) {
    return 'Imported cards: $count. Failed to load: $failedFiles';
  }

  @override
  String get csvImportCancelled => 'Import cancelled';

  @override
  String get testMergeAppBarTitle => 'Merge tests';

  @override
  String get testMergeConfirmButton => 'Merge';

  @override
  String get testMergeNewTestTitle => 'New test name';

  @override
  String get testMergeSuccessMessage => 'Test created successfully';

  @override
  String get testMergeSelectHint => 'Select tests to merge';

  @override
  String get testActionsDialogTitle => 'Actions';

  @override
  String get testActionMerge => 'Merge with others';

  @override
  String get profileSettingsTitle => 'Profile';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get profileShaderAnimationTitle => 'Background animation';

  @override
  String get profileAccentColorTitle => 'App color';

  @override
  String get profileAnimationSpeedTitle => 'Animation speed';

  @override
  String profileAnimationDurationLabel(int duration) {
    return '$duration ms';
  }

  @override
  String get profileCardFontSizeTitle => 'Card font size';

  @override
  String profileCardFontSizeLabel(int value) {
    return '$value px';
  }

  @override
  String get questionStatsTitle => 'Statistics';

  @override
  String get questionStatsEmptyMessage =>
      'No statistics yet.\nComplete a test to start tracking.';

  @override
  String get questionStatsCorrectLabel => 'Correct';

  @override
  String get questionStatsIncorrectLabel => 'Incorrect';

  @override
  String get questionStatsStreakLabel => 'Streak';

  @override
  String get questionStatsAccuracyLabel => 'Accuracy';

  @override
  String get questionStatsSortByDate => 'By date';

  @override
  String get questionStatsSortByStreak => 'By streak';

  @override
  String get questionStatsSortByAccuracy => 'By accuracy';

  @override
  String get questionStatsSortTitle => 'Sort';

  @override
  String get questionStatsSearchHint => 'Search cards';

  @override
  String questionStatsSearchFound(int count) {
    return 'Found: $count';
  }

  @override
  String get questionStatsSearchEmpty => 'Nothing found';

  @override
  String questionStatsTotalCount(int count) {
    return 'Total: $count';
  }

  @override
  String get profileDashboardTitle => 'Profile';

  @override
  String get profileIdentityName => 'karto4ki';

  @override
  String profileIdentitySubtitle(int groups, int tests) {
    String _temp0 = intl.Intl.pluralLogic(
      groups,
      locale: localeName,
      other: '$groups groups',
      one: '$groups group',
    );
    String _temp1 = intl.Intl.pluralLogic(
      tests,
      locale: localeName,
      other: '$tests tests',
      one: '$tests test',
    );
    return '$_temp0 · $_temp1';
  }

  @override
  String get profileStatsCardTitle => 'Statistics';

  @override
  String get profileStatsCardMore => 'More';

  @override
  String get profileRingAccuracy => 'Accuracy';

  @override
  String get profileRingMastered => 'Mastered';

  @override
  String get profileRingFlawless => 'Flawless';

  @override
  String get profileStreakDaysSuffix => 'day streak';

  @override
  String profileStreakBest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return 'Best streak: $_temp0';
  }

  @override
  String get profileWeekdayMon => 'Mon';

  @override
  String get profileWeekdayTue => 'Tue';

  @override
  String get profileWeekdayWed => 'Wed';

  @override
  String get profileWeekdayThu => 'Thu';

  @override
  String get profileWeekdayFri => 'Fri';

  @override
  String get profileWeekdaySat => 'Sat';

  @override
  String get profileWeekdaySun => 'Sun';

  @override
  String get profileMetricAnswers => 'Total answers';

  @override
  String get profileMetricCards => 'Total cards';

  @override
  String get profileMetricWeak => 'Weak cards';

  @override
  String get profileMetricActiveDays => 'Active days';

  @override
  String get profileMetricAvgPerDay => 'Answers per day';

  @override
  String get profileLoadError => 'Failed to load statistics';

  @override
  String get profileRetryButton => 'Retry';

  @override
  String get groupsListAppBarTitle => 'Groups';

  @override
  String get groupsListEmptyMessage =>
      'No groups.\nTap + to create the first group.';

  @override
  String get groupsListAddGroupFab => 'Create';

  @override
  String get groupsListDeleteDialogTitle => 'Delete group?';

  @override
  String groupsListDeleteDialogMessage(String title) {
    return 'Are you sure you want to delete \"$title\"? Tests inside the group will not be deleted.';
  }

  @override
  String get groupsListDeleteDialogCancel => 'Cancel';

  @override
  String get groupsListDeleteDialogConfirm => 'Delete';

  @override
  String groupsListTestCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tests',
      one: 'test',
    );
    return '$count $_temp0';
  }

  @override
  String groupsListErrorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get groupsListUnknownError => 'Unknown error';

  @override
  String get groupsListNewGroupDialogTitle => 'New group';

  @override
  String get groupsListNewGroupNameHint => 'Group name';

  @override
  String get groupsListNewGroupCancel => 'Cancel';

  @override
  String get groupsListNewGroupCreate => 'Create';

  @override
  String get groupsListActiveSessionLabel => 'Continue test';

  @override
  String groupsListActiveSessionCards(int current, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'cards',
      one: 'card',
    );
    return '$current of $total $_temp0';
  }

  @override
  String get groupsListActiveSessionResume => 'Continue';

  @override
  String get groupsListActiveSessionDismiss => 'Dismiss';

  @override
  String get groupDetailLoadingTitle => 'Loading...';

  @override
  String get groupDetailAddTestFab => 'Add';

  @override
  String get groupDetailEmptyMessage =>
      'No tests in this group.\nTap + to add the first test.';

  @override
  String groupDetailErrorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get groupDetailUnknownError => 'Unknown error';

  @override
  String get groupDetailRemoveTestTitle => 'Remove test from group?';

  @override
  String groupDetailRemoveTestMessage(String title) {
    return 'Test \"$title\" will be removed from this group, but not deleted.';
  }

  @override
  String get groupDetailRemoveTestLastGroupTitle => 'Last group';

  @override
  String groupDetailRemoveTestLastGroupMessage(String title) {
    return 'This is the last group for test \"$title\". The test will remain without a group.';
  }

  @override
  String get groupDetailRemoveTestCancel => 'Cancel';

  @override
  String get groupDetailRemoveTestConfirm => 'Remove';

  @override
  String get groupDetailEditTitleDialogTitle => 'Rename group';

  @override
  String get groupDetailEditTitleHint => 'Group name';

  @override
  String get groupDetailEditTitleCancel => 'Cancel';

  @override
  String get groupDetailEditTitleSave => 'Save';

  @override
  String get groupDetailNewTestDialogTitle => 'New test';

  @override
  String get groupDetailNewTestNameHint => 'Test name';

  @override
  String get groupDetailNewTestDescriptionHint => 'Description (optional)';

  @override
  String get groupDetailNewTestCancel => 'Cancel';

  @override
  String get groupDetailNewTestCreate => 'Create';

  @override
  String get groupDetailTestActionsTitle => 'Actions';

  @override
  String get groupDetailTestActionsOpen => 'Open test';

  @override
  String get groupDetailTestActionsRemove => 'Remove from group';

  @override
  String get groupDetailTestActionsAddToGroup => 'Add to group';

  @override
  String get groupDetailAddToGroupTitle => 'Select groups';

  @override
  String get groupDetailAddToGroupEmpty => 'No other groups';

  @override
  String get groupDetailAddToGroupSave => 'Save';

  @override
  String get groupDetailAddToGroupCancel => 'Cancel';

  @override
  String groupDetailMixupRange(int min, int max) {
    return 'Count: $min–$max';
  }

  @override
  String get groupDetailMixupCountLabel => 'Count';

  @override
  String get groupDetailMixupAlgorithm => 'Mixup algorithm';

  @override
  String get groupDetailMixupAlgorithmClassic => 'Classic';

  @override
  String get groupDetailMixupAlgorithmScoring => 'Smart';

  @override
  String get groupDetailStreakCoefficients => 'Streak coefficients';

  @override
  String get groupDetailStreakNegativeBonus => 'Errors bonus';

  @override
  String get groupDetailStreakPositivePenalty => 'Correct penalty';

  @override
  String get groupDetailStreakReset => 'Reset to defaults';

  @override
  String get groupDetailNewTestButton => 'New test';

  @override
  String groupDetailQuestionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions',
      one: '$count question',
      zero: 'No questions',
    );
    return '$_temp0';
  }

  @override
  String get authTitle => 'Sign in';

  @override
  String get authSubtitle =>
      'Sync groups, tests and progress across devices. All cards keep working without signing in.';

  @override
  String get authGoogleButton => 'Sign in with Google';

  @override
  String get authContinueAsGuest => 'Continue without signing in';

  @override
  String get authLegalNote =>
      'By continuing you accept the terms of use and the privacy policy.';

  @override
  String get authErrorGeneric => 'Sign-in failed. Please try again';

  @override
  String get authWelcomeSnack => 'Your local tests were added to the account';

  @override
  String get profileSignInTitle => 'Sign in';

  @override
  String get profileSignInSubtitle => 'To sync your progress';

  @override
  String get profileSignOutRow => 'Sign out';

  @override
  String get profileSignOutDialogTitle => 'Sign out?';

  @override
  String get profileSignOutDialogMessage =>
      'Local cards stay on the device, syncing will stop.';

  @override
  String get profileSignOutDialogConfirm => 'Sign out';

  @override
  String get syncTitleSynced => 'Synced';

  @override
  String get syncTitleSyncing => 'Syncing…';

  @override
  String get syncTitleNotSynced => 'Not synced';

  @override
  String get syncTitleOffline => 'Offline';

  @override
  String get syncTitleExpired => 'Session expired';

  @override
  String get syncTitleFailed => 'Sync failed';

  @override
  String syncSubtitleSyncedRelative(String time) {
    return 'Last time — $time';
  }

  @override
  String get syncSubtitleNever => 'Not synced yet';

  @override
  String syncSubtitleSyncingCounted(int done, int total) {
    final intl.NumberFormat doneNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String doneString = doneNumberFormat.format(done);
    final intl.NumberFormat totalNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String totalString = totalNumberFormat.format(total);

    return 'Loaded $doneString of $totalString changes';
  }

  @override
  String get syncSubtitleSyncingPlain =>
      'Sending changes and fetching new ones';

  @override
  String syncSubtitlePending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count changes waiting to be sent',
      one: '$count change waiting to be sent',
    );
    return '$_temp0';
  }

  @override
  String get syncSubtitleOffline =>
      'Changes will be sent once you are back online';

  @override
  String get syncSubtitleExpired => 'Sign in again to resume syncing';

  @override
  String get syncSubtitleFailed =>
      'Changes are stored on the device, try again';

  @override
  String get syncDialogBodySynced =>
      'All cards, groups and progress are stored on the server.';

  @override
  String get syncDialogBodySyncing =>
      'Sending your changes and fetching fresh cards from the server.';

  @override
  String syncDialogBodyNotSynced(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count changes are only on this device: your other devices will not see them.',
      one:
          '$count change is only on this device: your other devices will not see it.',
    );
    return '$_temp0';
  }

  @override
  String get syncDialogBodyOffline =>
      'No connection. The app works offline, changes are stored on the device and will be sent automatically.';

  @override
  String get syncDialogBodyExpired =>
      'The session has expired, so syncing stopped. Cards and progress are stored on the device.';

  @override
  String get syncDialogBodyFailed =>
      'Sync failed. Cards and progress are stored on the device.';

  @override
  String get syncDialogLastSyncLabel => 'Last sync';

  @override
  String syncDialogLastSyncApprox(String time) {
    return 'About $time';
  }

  @override
  String get syncDialogClose => 'Close';

  @override
  String get syncActionSync => 'Sync';

  @override
  String get syncActionRetry => 'Retry';

  @override
  String get syncActionSignIn => 'Sign in';

  @override
  String get syncTimeJustNow => 'just now';

  @override
  String syncTimeMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '$count minute ago',
    );
    return '$_temp0';
  }

  @override
  String syncTimeHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '$count hour ago',
    );
    return '$_temp0';
  }

  @override
  String syncTimeToday(String time) {
    return 'today at $time';
  }

  @override
  String syncTimeYesterday(String time) {
    return 'yesterday at $time';
  }

  @override
  String syncTimeAtDate(String date, String time) {
    return '$date at $time';
  }

  @override
  String get syncReauthTitle => 'Sign in again';

  @override
  String get syncReauthBody =>
      'The session has expired. Cards and progress are stored on the device — everything will be uploaded after you sign in.';

  @override
  String get syncReauthLater => 'Later';

  @override
  String get syncReauthSignIn => 'Sign in';

  @override
  String get groupsListTitle => 'My groups';

  @override
  String get groupsListSubtitle => 'Test groups for flashcard learning';

  @override
  String get syncSubtitleSyncedNoTime => 'All changes are on the server';
}
