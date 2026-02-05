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
  String get mainQuestionCardFront => 'Question';

  @override
  String get mainQuestionCardBack => 'Answer';

  @override
  String get csvImportButton => 'Import CSV';

  @override
  String get csvImportDialogTitle => 'Import cards from CSV';

  @override
  String get csvImportDialogDescription => 'File format:\n• 1st column — question (word)\n• 2nd column — answer (translation)\n• Delimiter: semicolon (;)';

  @override
  String get csvImportDialogContinue => 'Select file';

  @override
  String get csvImportDialogCancel => 'Cancel';

  @override
  String get csvImportErrorEmpty => 'File is empty or contains no data';

  @override
  String get csvImportErrorFormat => 'Invalid CSV format. Minimum 2 columns required.';

  @override
  String get csvImportErrorRead => 'Could not read file';

  @override
  String csvImportSuccess(int count) {
    return 'Imported cards: $count';
  }

  @override
  String get csvImportCancelled => 'Import cancelled';
}
