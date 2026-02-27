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
  String get tinderTestResultsTitle => 'Test completed!';

  @override
  String get tinderTestResultsCorrectLabel => 'Correct';

  @override
  String get tinderTestResultsIncorrectLabel => 'Incorrect';

  @override
  String get tinderTestResultsPercentageLabel => 'Result';

  @override
  String get tinderTestResultsRestartButton => 'Repeat';

  @override
  String get tinderTestResultsDoneButton => 'Done';

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
  String get testsListEmptyMessage => 'No tests.\nTap + to create the first test.';

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
  String get testDetailEmptyCardsMessage => 'No cards.\nTap + to add the first one.';

  @override
  String get testDetailDeleteCardTitle => 'Delete card?';

  @override
  String get testDetailDeleteCardMessage => 'Are you sure you want to delete this card?';

  @override
  String get testDetailDeleteCardCancel => 'Cancel';

  @override
  String get testDetailDeleteCardConfirm => 'Delete';

  @override
  String get testDetailSwapSides => 'Swap sides';

  @override
  String get testDetailMixup => 'Question mixup';

  @override
  String get testDetailMixupDescription => 'Adds questions from other tests in the group';

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
  String get csvImportDialogDescription => 'Supported formats: CSV, TXT, TSV\n\nFile format:\n• 1st column — question (word)\n• 2nd column — answer (translation)';

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
  String get csvImportErrorFormat => 'Invalid file format. Minimum 2 columns required.';

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
  String get groupsListAppBarTitle => 'Groups';

  @override
  String get groupsListEmptyMessage => 'No groups.\nTap + to create the first group.';

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
  String get groupDetailLoadingTitle => 'Loading...';

  @override
  String get groupDetailAddTestFab => 'Add';

  @override
  String get groupDetailEmptyMessage => 'No tests in this group.\nTap + to add the first test.';

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
}
