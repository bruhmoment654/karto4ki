import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'All We Need'**
  String get appName;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Что-то пошло не так'**
  String get somethingWentWrong;

  /// No description provided for @formatError.
  ///
  /// In en, this message translates to:
  /// **'Неправильный формат фотографии'**
  String get formatError;

  /// No description provided for @loadingWidgetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Идет загрузка'**
  String get loadingWidgetSubtitle;

  /// No description provided for @positiveResponse.
  ///
  /// In en, this message translates to:
  /// **'Да'**
  String get positiveResponse;

  /// No description provided for @navigationMain.
  ///
  /// In en, this message translates to:
  /// **'Главная'**
  String get navigationMain;

  /// No description provided for @navigationCatalog.
  ///
  /// In en, this message translates to:
  /// **'Каталог'**
  String get navigationCatalog;

  /// No description provided for @navigationCart.
  ///
  /// In en, this message translates to:
  /// **'Корзина'**
  String get navigationCart;

  /// No description provided for @navigationWishlist.
  ///
  /// In en, this message translates to:
  /// **'Вишлист'**
  String get navigationWishlist;

  /// No description provided for @navigationProfile.
  ///
  /// In en, this message translates to:
  /// **'Профиль'**
  String get navigationProfile;

  /// No description provided for @productIsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Скоро в продаже'**
  String get productIsComingSoon;

  /// No description provided for @productInStock.
  ///
  /// In en, this message translates to:
  /// **'Снова в наличии'**
  String get productInStock;

  /// No description provided for @productIsOnlyShops.
  ///
  /// In en, this message translates to:
  /// **'Только в магазинах'**
  String get productIsOnlyShops;

  /// No description provided for @authEnterCode.
  ///
  /// In en, this message translates to:
  /// **'Введите код из СМС'**
  String get authEnterCode;

  /// No description provided for @tinderTestAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get tinderTestAppBarTitle;

  /// No description provided for @tinderTestEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No cards in this test'**
  String get tinderTestEmptyTitle;

  /// No description provided for @tinderTestEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add cards to start the test'**
  String get tinderTestEmptySubtitle;

  /// No description provided for @tinderTestBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get tinderTestBackButton;

  /// No description provided for @tinderTestProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'Card {current} of {total}'**
  String tinderTestProgressLabel(int current, int total);

  /// No description provided for @tinderTestTapToShowAnswer.
  ///
  /// In en, this message translates to:
  /// **'Tap to show the answer'**
  String get tinderTestTapToShowAnswer;

  /// No description provided for @tinderTestUnknownBadge.
  ///
  /// In en, this message translates to:
  /// **'DON\'T KNOW'**
  String get tinderTestUnknownBadge;

  /// No description provided for @tinderTestKnownBadge.
  ///
  /// In en, this message translates to:
  /// **'KNOW'**
  String get tinderTestKnownBadge;

  /// No description provided for @tinderTestUndoTooltip.
  ///
  /// In en, this message translates to:
  /// **'Undo last answer'**
  String get tinderTestUndoTooltip;

  /// No description provided for @tinderTestSwipeUnknownHint.
  ///
  /// In en, this message translates to:
  /// **'Don\'t know'**
  String get tinderTestSwipeUnknownHint;

  /// No description provided for @tinderTestSwipeKnownHint.
  ///
  /// In en, this message translates to:
  /// **'Know'**
  String get tinderTestSwipeKnownHint;

  /// No description provided for @tinderTestResultsRestartButton.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get tinderTestResultsRestartButton;

  /// No description provided for @tinderTestResultsDoneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get tinderTestResultsDoneButton;

  /// No description provided for @tinderTestResultsAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get tinderTestResultsAppBarTitle;

  /// No description provided for @tinderTestResultsTitleGreat.
  ///
  /// In en, this message translates to:
  /// **'Great result!'**
  String get tinderTestResultsTitleGreat;

  /// No description provided for @tinderTestResultsTitleGood.
  ///
  /// In en, this message translates to:
  /// **'Good job!'**
  String get tinderTestResultsTitleGood;

  /// No description provided for @tinderTestResultsTitleRetry.
  ///
  /// In en, this message translates to:
  /// **'Room for improvement'**
  String get tinderTestResultsTitleRetry;

  /// No description provided for @tinderTestResultsDeltaUp.
  ///
  /// In en, this message translates to:
  /// **'+{delta}% vs last time'**
  String tinderTestResultsDeltaUp(int delta);

  /// No description provided for @tinderTestResultsDeltaDown.
  ///
  /// In en, this message translates to:
  /// **'−{delta}% vs last time'**
  String tinderTestResultsDeltaDown(int delta);

  /// No description provided for @tinderTestResultsDeltaSame.
  ///
  /// In en, this message translates to:
  /// **'Same as last time'**
  String get tinderTestResultsDeltaSame;

  /// No description provided for @tinderTestResultsFirstAttempt.
  ///
  /// In en, this message translates to:
  /// **'First attempt'**
  String get tinderTestResultsFirstAttempt;

  /// No description provided for @tinderTestResultsRecentAttempts.
  ///
  /// In en, this message translates to:
  /// **'Recent attempts'**
  String get tinderTestResultsRecentAttempts;

  /// No description provided for @tinderTestResultsAttemptsCount.
  ///
  /// In en, this message translates to:
  /// **'{shown} of {total}'**
  String tinderTestResultsAttemptsCount(int shown, int total);

  /// No description provided for @tinderTestResultsAttemptNow.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get tinderTestResultsAttemptNow;

  /// No description provided for @tinderTestResultsDynamicsPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress will appear later'**
  String get tinderTestResultsDynamicsPlaceholderTitle;

  /// No description provided for @tinderTestResultsDynamicsPlaceholderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Take the test again to compare the result with this attempt'**
  String get tinderTestResultsDynamicsPlaceholderSubtitle;

  /// No description provided for @tinderTestResultsByQuestion.
  ///
  /// In en, this message translates to:
  /// **'By question'**
  String get tinderTestResultsByQuestion;

  /// No description provided for @tinderTestResultsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get tinderTestResultsFilterAll;

  /// No description provided for @tinderTestResultsFilterMistakes.
  ///
  /// In en, this message translates to:
  /// **'Mistakes'**
  String get tinderTestResultsFilterMistakes;

  /// No description provided for @tinderTestResultsAnswerKnow.
  ///
  /// In en, this message translates to:
  /// **'Know'**
  String get tinderTestResultsAnswerKnow;

  /// No description provided for @tinderTestResultsAnswerDontKnow.
  ///
  /// In en, this message translates to:
  /// **'Don\'t know'**
  String get tinderTestResultsAnswerDontKnow;

  /// No description provided for @tinderTestResultsTrendFirstCorrect.
  ///
  /// In en, this message translates to:
  /// **'First correct'**
  String get tinderTestResultsTrendFirstCorrect;

  /// No description provided for @tinderTestResultsTrendFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get tinderTestResultsTrendFixed;

  /// No description provided for @tinderTestResultsTrendForgot.
  ///
  /// In en, this message translates to:
  /// **'Forgotten'**
  String get tinderTestResultsTrendForgot;

  /// No description provided for @tinderTestResultsTrendRepeatedMistake.
  ///
  /// In en, this message translates to:
  /// **'Wrong again'**
  String get tinderTestResultsTrendRepeatedMistake;

  /// No description provided for @tinderTestResultsTrendStable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get tinderTestResultsTrendStable;

  /// No description provided for @testsListAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Tests'**
  String get testsListAppBarTitle;

  /// No description provided for @testsListErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String testsListErrorMessage(String message);

  /// No description provided for @testsListUnknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get testsListUnknownError;

  /// No description provided for @testsListRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get testsListRetryButton;

  /// No description provided for @testsListEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No tests.\nTap + to create the first test.'**
  String get testsListEmptyMessage;

  /// No description provided for @testsListDeleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete test?'**
  String get testsListDeleteDialogTitle;

  /// No description provided for @testsListDeleteDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"?'**
  String testsListDeleteDialogMessage(String title);

  /// No description provided for @testsListDeleteDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get testsListDeleteDialogCancel;

  /// No description provided for @testsListDeleteDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get testsListDeleteDialogConfirm;

  /// No description provided for @testDetailLoadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get testDetailLoadingTitle;

  /// No description provided for @testDetailEditTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit test'**
  String get testDetailEditTooltip;

  /// No description provided for @testDetailErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String testDetailErrorMessage(String message);

  /// No description provided for @testDetailUnknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get testDetailUnknownError;

  /// No description provided for @testDetailRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get testDetailRetryButton;

  /// No description provided for @testDetailStartButton.
  ///
  /// In en, this message translates to:
  /// **'Start test'**
  String get testDetailStartButton;

  /// No description provided for @testDetailCardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cards ({count})'**
  String testDetailCardsTitle(int count);

  /// No description provided for @testDetailCardsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No cards} one{{count} card} other{{count} cards}}'**
  String testDetailCardsCount(int count);

  /// No description provided for @testDetailEmptyCardsMessage.
  ///
  /// In en, this message translates to:
  /// **'No cards.\nTap + to add the first one.'**
  String get testDetailEmptyCardsMessage;

  /// No description provided for @testDetailDeleteCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete card?'**
  String get testDetailDeleteCardTitle;

  /// No description provided for @testDetailDeleteCardMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this card?'**
  String get testDetailDeleteCardMessage;

  /// No description provided for @testDetailDeleteCardCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get testDetailDeleteCardCancel;

  /// No description provided for @testDetailDeleteCardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get testDetailDeleteCardConfirm;

  /// No description provided for @testDetailSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get testDetailSettingsButton;

  /// No description provided for @testDetailSwapSides.
  ///
  /// In en, this message translates to:
  /// **'Swap sides'**
  String get testDetailSwapSides;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get commonCreate;

  /// No description provided for @testDetailNewCardTitle.
  ///
  /// In en, this message translates to:
  /// **'New card'**
  String get testDetailNewCardTitle;

  /// No description provided for @testDetailEditCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit card'**
  String get testDetailEditCardTitle;

  /// No description provided for @testDetailEditTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit test'**
  String get testDetailEditTestTitle;

  /// No description provided for @testDetailCardFrontLabel.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get testDetailCardFrontLabel;

  /// No description provided for @testDetailCardFrontHint.
  ///
  /// In en, this message translates to:
  /// **'Enter question'**
  String get testDetailCardFrontHint;

  /// No description provided for @testDetailCardBackLabel.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get testDetailCardBackLabel;

  /// No description provided for @testDetailCardBackHint.
  ///
  /// In en, this message translates to:
  /// **'Enter answer (variants separated by |)'**
  String get testDetailCardBackHint;

  /// No description provided for @testDetailTestTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get testDetailTestTitleLabel;

  /// No description provided for @testDetailTestDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get testDetailTestDescriptionLabel;

  /// No description provided for @testSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Test settings'**
  String get testSettingsTitle;

  /// No description provided for @testSettingsSwapSides.
  ///
  /// In en, this message translates to:
  /// **'Invert sides'**
  String get testSettingsSwapSides;

  /// No description provided for @testSettingsSwapSidesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Swap question and answer'**
  String get testSettingsSwapSidesSubtitle;

  /// No description provided for @testSettingsAnswerVariant.
  ///
  /// In en, this message translates to:
  /// **'Answer variant'**
  String get testSettingsAnswerVariant;

  /// No description provided for @testSettingsApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get testSettingsApply;

  /// No description provided for @groupDetailMixup.
  ///
  /// In en, this message translates to:
  /// **'Question mixup'**
  String get groupDetailMixup;

  /// No description provided for @groupDetailMixupDescription.
  ///
  /// In en, this message translates to:
  /// **'Adds questions from other tests in the group'**
  String get groupDetailMixupDescription;

  /// No description provided for @testDetailAddCardFab.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get testDetailAddCardFab;

  /// No description provided for @testsListAddTestFab.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get testsListAddTestFab;

  /// No description provided for @mainQuestionCardFront.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get mainQuestionCardFront;

  /// No description provided for @mainQuestionCardBack.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get mainQuestionCardBack;

  /// No description provided for @csvImportButton.
  ///
  /// In en, this message translates to:
  /// **'Import from file'**
  String get csvImportButton;

  /// No description provided for @csvImportDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Import cards from file'**
  String get csvImportDialogTitle;

  /// No description provided for @csvImportDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'Supported formats: CSV, TXT, TSV\n\nFile format:\n• 1st column — question (word)\n• 2nd column — answer (translation)\n\nMultiple answer variants can be separated with | or //'**
  String get csvImportDialogDescription;

  /// No description provided for @csvImportDialogExample.
  ///
  /// In en, this message translates to:
  /// **'apple;яблоко\ncat;кот | кошка\ndog;собака // пёс'**
  String get csvImportDialogExample;

  /// No description provided for @csvImportDelimiterLabel.
  ///
  /// In en, this message translates to:
  /// **'Delimiter'**
  String get csvImportDelimiterLabel;

  /// No description provided for @csvImportDelimiterHint.
  ///
  /// In en, this message translates to:
  /// **';'**
  String get csvImportDelimiterHint;

  /// No description provided for @csvImportAddFiles.
  ///
  /// In en, this message translates to:
  /// **'Add files'**
  String get csvImportAddFiles;

  /// No description provided for @csvImportFilesTitle.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get csvImportFilesTitle;

  /// No description provided for @csvImportNoFiles.
  ///
  /// In en, this message translates to:
  /// **'No files selected'**
  String get csvImportNoFiles;

  /// No description provided for @csvImportDialogContinue.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get csvImportDialogContinue;

  /// No description provided for @csvImportDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get csvImportDialogCancel;

  /// No description provided for @csvImportErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'File is empty or contains no data'**
  String get csvImportErrorEmpty;

  /// No description provided for @csvImportErrorFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid file format. Minimum 2 columns required.'**
  String get csvImportErrorFormat;

  /// No description provided for @csvImportErrorRead.
  ///
  /// In en, this message translates to:
  /// **'Could not read file'**
  String get csvImportErrorRead;

  /// No description provided for @csvImportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Imported cards: {count} from {fileCount} files'**
  String csvImportSuccess(int count, int fileCount);

  /// No description provided for @csvImportPartialSuccess.
  ///
  /// In en, this message translates to:
  /// **'Imported cards: {count}. Failed to load: {failedFiles}'**
  String csvImportPartialSuccess(int count, String failedFiles);

  /// No description provided for @csvImportCancelled.
  ///
  /// In en, this message translates to:
  /// **'Import cancelled'**
  String get csvImportCancelled;

  /// No description provided for @testMergeAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Merge tests'**
  String get testMergeAppBarTitle;

  /// No description provided for @testMergeConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get testMergeConfirmButton;

  /// No description provided for @testMergeNewTestTitle.
  ///
  /// In en, this message translates to:
  /// **'New test name'**
  String get testMergeNewTestTitle;

  /// No description provided for @testMergeSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Test created successfully'**
  String get testMergeSuccessMessage;

  /// No description provided for @testMergeSelectHint.
  ///
  /// In en, this message translates to:
  /// **'Select tests to merge'**
  String get testMergeSelectHint;

  /// No description provided for @testActionsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get testActionsDialogTitle;

  /// No description provided for @testActionMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge with others'**
  String get testActionMerge;

  /// No description provided for @profileSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileSettingsTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @profileShaderAnimationTitle.
  ///
  /// In en, this message translates to:
  /// **'Background animation'**
  String get profileShaderAnimationTitle;

  /// No description provided for @profileAccentColorTitle.
  ///
  /// In en, this message translates to:
  /// **'Accent color'**
  String get profileAccentColorTitle;

  /// No description provided for @profileAnimationSpeedTitle.
  ///
  /// In en, this message translates to:
  /// **'Animation speed'**
  String get profileAnimationSpeedTitle;

  /// No description provided for @profileAnimationDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'{duration} ms'**
  String profileAnimationDurationLabel(int duration);

  /// No description provided for @profileCardFontSizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Card font size'**
  String get profileCardFontSizeTitle;

  /// No description provided for @profileCardFontSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'{value} px'**
  String profileCardFontSizeLabel(int value);

  /// No description provided for @questionStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get questionStatsTitle;

  /// No description provided for @questionStatsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No statistics yet.\nComplete a test to start tracking.'**
  String get questionStatsEmptyMessage;

  /// No description provided for @questionStatsCorrectLabel.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get questionStatsCorrectLabel;

  /// No description provided for @questionStatsIncorrectLabel.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get questionStatsIncorrectLabel;

  /// No description provided for @questionStatsStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get questionStatsStreakLabel;

  /// No description provided for @questionStatsAccuracyLabel.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get questionStatsAccuracyLabel;

  /// No description provided for @questionStatsSortByDate.
  ///
  /// In en, this message translates to:
  /// **'By date'**
  String get questionStatsSortByDate;

  /// No description provided for @questionStatsSortByStreak.
  ///
  /// In en, this message translates to:
  /// **'By streak'**
  String get questionStatsSortByStreak;

  /// No description provided for @questionStatsSortByAccuracy.
  ///
  /// In en, this message translates to:
  /// **'By accuracy'**
  String get questionStatsSortByAccuracy;

  /// No description provided for @questionStatsSortTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get questionStatsSortTitle;

  /// No description provided for @questionStatsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search cards'**
  String get questionStatsSearchHint;

  /// No description provided for @questionStatsSearchFound.
  ///
  /// In en, this message translates to:
  /// **'Found: {count}'**
  String questionStatsSearchFound(int count);

  /// No description provided for @questionStatsSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get questionStatsSearchEmpty;

  /// No description provided for @questionStatsTotalCount.
  ///
  /// In en, this message translates to:
  /// **'Total: {count}'**
  String questionStatsTotalCount(int count);

  /// No description provided for @profileDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileDashboardTitle;

  /// No description provided for @profileIdentityName.
  ///
  /// In en, this message translates to:
  /// **'karto4ki'**
  String get profileIdentityName;

  /// No description provided for @profileIdentitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'{groups, plural, one{{groups} group} other{{groups} groups}} · {tests, plural, one{{tests} test} other{{tests} tests}}'**
  String profileIdentitySubtitle(int groups, int tests);

  /// No description provided for @profileStatsCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get profileStatsCardTitle;

  /// No description provided for @profileStatsCardMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get profileStatsCardMore;

  /// No description provided for @profileRingAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get profileRingAccuracy;

  /// No description provided for @profileRingMastered.
  ///
  /// In en, this message translates to:
  /// **'Mastered'**
  String get profileRingMastered;

  /// No description provided for @profileRingFlawless.
  ///
  /// In en, this message translates to:
  /// **'Flawless'**
  String get profileRingFlawless;

  /// No description provided for @profileStreakDaysSuffix.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get profileStreakDaysSuffix;

  /// No description provided for @profileStreakBest.
  ///
  /// In en, this message translates to:
  /// **'Best streak: {count, plural, one{{count} day} other{{count} days}}'**
  String profileStreakBest(int count);

  /// No description provided for @profileWeekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get profileWeekdayMon;

  /// No description provided for @profileWeekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get profileWeekdayTue;

  /// No description provided for @profileWeekdayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get profileWeekdayWed;

  /// No description provided for @profileWeekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get profileWeekdayThu;

  /// No description provided for @profileWeekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get profileWeekdayFri;

  /// No description provided for @profileWeekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get profileWeekdaySat;

  /// No description provided for @profileWeekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get profileWeekdaySun;

  /// No description provided for @profileMetricAnswers.
  ///
  /// In en, this message translates to:
  /// **'Total answers'**
  String get profileMetricAnswers;

  /// No description provided for @profileMetricCards.
  ///
  /// In en, this message translates to:
  /// **'Total cards'**
  String get profileMetricCards;

  /// No description provided for @profileMetricWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak cards'**
  String get profileMetricWeak;

  /// No description provided for @profileMetricActiveDays.
  ///
  /// In en, this message translates to:
  /// **'Active days'**
  String get profileMetricActiveDays;

  /// No description provided for @profileMetricAvgPerDay.
  ///
  /// In en, this message translates to:
  /// **'Answers per day'**
  String get profileMetricAvgPerDay;

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load statistics'**
  String get profileLoadError;

  /// No description provided for @profileRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get profileRetryButton;

  /// No description provided for @groupsListAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groupsListAppBarTitle;

  /// No description provided for @groupsListEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No groups.\nTap + to create the first group.'**
  String get groupsListEmptyMessage;

  /// No description provided for @groupsListAddGroupFab.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get groupsListAddGroupFab;

  /// No description provided for @groupsListDeleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete group?'**
  String get groupsListDeleteDialogTitle;

  /// No description provided for @groupsListDeleteDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"? Tests inside the group will not be deleted.'**
  String groupsListDeleteDialogMessage(String title);

  /// No description provided for @groupsListDeleteDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupsListDeleteDialogCancel;

  /// No description provided for @groupsListDeleteDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get groupsListDeleteDialogConfirm;

  /// No description provided for @groupsListTestCount.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, one{test} other{tests}}'**
  String groupsListTestCount(int count);

  /// No description provided for @groupsListErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String groupsListErrorMessage(String message);

  /// No description provided for @groupsListUnknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get groupsListUnknownError;

  /// No description provided for @groupsListNewGroupDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'New group'**
  String get groupsListNewGroupDialogTitle;

  /// No description provided for @groupsListNewGroupNameHint.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get groupsListNewGroupNameHint;

  /// No description provided for @groupsListNewGroupCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupsListNewGroupCancel;

  /// No description provided for @groupsListNewGroupCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get groupsListNewGroupCreate;

  /// No description provided for @groupsListActiveSessionLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue test'**
  String get groupsListActiveSessionLabel;

  /// No description provided for @groupsListActiveSessionCards.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total} {total, plural, one{card} other{cards}}'**
  String groupsListActiveSessionCards(int current, int total);

  /// No description provided for @groupsListActiveSessionResume.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get groupsListActiveSessionResume;

  /// No description provided for @groupsListActiveSessionDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get groupsListActiveSessionDismiss;

  /// No description provided for @groupDetailLoadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get groupDetailLoadingTitle;

  /// No description provided for @groupDetailAddTestFab.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get groupDetailAddTestFab;

  /// No description provided for @groupDetailEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No tests in this group.\nTap + to add the first test.'**
  String get groupDetailEmptyMessage;

  /// No description provided for @groupDetailErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String groupDetailErrorMessage(String message);

  /// No description provided for @groupDetailUnknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get groupDetailUnknownError;

  /// No description provided for @groupDetailRemoveTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove test from group?'**
  String get groupDetailRemoveTestTitle;

  /// No description provided for @groupDetailRemoveTestMessage.
  ///
  /// In en, this message translates to:
  /// **'Test \"{title}\" will be removed from this group, but not deleted.'**
  String groupDetailRemoveTestMessage(String title);

  /// No description provided for @groupDetailRemoveTestLastGroupTitle.
  ///
  /// In en, this message translates to:
  /// **'Last group'**
  String get groupDetailRemoveTestLastGroupTitle;

  /// No description provided for @groupDetailRemoveTestLastGroupMessage.
  ///
  /// In en, this message translates to:
  /// **'This is the last group for test \"{title}\". The test will remain without a group.'**
  String groupDetailRemoveTestLastGroupMessage(String title);

  /// No description provided for @groupDetailRemoveTestCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupDetailRemoveTestCancel;

  /// No description provided for @groupDetailRemoveTestConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get groupDetailRemoveTestConfirm;

  /// No description provided for @groupDetailEditTitleDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename group'**
  String get groupDetailEditTitleDialogTitle;

  /// No description provided for @groupDetailEditTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get groupDetailEditTitleHint;

  /// No description provided for @groupDetailEditTitleCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupDetailEditTitleCancel;

  /// No description provided for @groupDetailEditTitleSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get groupDetailEditTitleSave;

  /// No description provided for @groupDetailNewTestDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'New test'**
  String get groupDetailNewTestDialogTitle;

  /// No description provided for @groupDetailNewTestNameHint.
  ///
  /// In en, this message translates to:
  /// **'Test name'**
  String get groupDetailNewTestNameHint;

  /// No description provided for @groupDetailNewTestDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get groupDetailNewTestDescriptionHint;

  /// No description provided for @groupDetailNewTestCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupDetailNewTestCancel;

  /// No description provided for @groupDetailNewTestCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get groupDetailNewTestCreate;

  /// No description provided for @groupDetailTestActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get groupDetailTestActionsTitle;

  /// No description provided for @groupDetailTestActionsOpen.
  ///
  /// In en, this message translates to:
  /// **'Open test'**
  String get groupDetailTestActionsOpen;

  /// No description provided for @groupDetailTestActionsRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from group'**
  String get groupDetailTestActionsRemove;

  /// No description provided for @groupDetailTestActionsAddToGroup.
  ///
  /// In en, this message translates to:
  /// **'Add to group'**
  String get groupDetailTestActionsAddToGroup;

  /// No description provided for @groupDetailAddToGroupTitle.
  ///
  /// In en, this message translates to:
  /// **'Select groups'**
  String get groupDetailAddToGroupTitle;

  /// No description provided for @groupDetailAddToGroupEmpty.
  ///
  /// In en, this message translates to:
  /// **'No other groups'**
  String get groupDetailAddToGroupEmpty;

  /// No description provided for @groupDetailAddToGroupSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get groupDetailAddToGroupSave;

  /// No description provided for @groupDetailAddToGroupCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get groupDetailAddToGroupCancel;

  /// No description provided for @groupDetailMixupRange.
  ///
  /// In en, this message translates to:
  /// **'Count: {min}–{max}'**
  String groupDetailMixupRange(int min, int max);

  /// No description provided for @groupDetailMixupCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get groupDetailMixupCountLabel;

  /// No description provided for @groupDetailMixupAlgorithm.
  ///
  /// In en, this message translates to:
  /// **'Mixup algorithm'**
  String get groupDetailMixupAlgorithm;

  /// No description provided for @groupDetailMixupAlgorithmClassic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get groupDetailMixupAlgorithmClassic;

  /// No description provided for @groupDetailMixupAlgorithmScoring.
  ///
  /// In en, this message translates to:
  /// **'Smart'**
  String get groupDetailMixupAlgorithmScoring;

  /// No description provided for @groupDetailStreakCoefficients.
  ///
  /// In en, this message translates to:
  /// **'Streak coefficients'**
  String get groupDetailStreakCoefficients;

  /// No description provided for @groupDetailStreakNegativeBonus.
  ///
  /// In en, this message translates to:
  /// **'Errors bonus'**
  String get groupDetailStreakNegativeBonus;

  /// No description provided for @groupDetailStreakPositivePenalty.
  ///
  /// In en, this message translates to:
  /// **'Correct penalty'**
  String get groupDetailStreakPositivePenalty;

  /// No description provided for @groupDetailStreakReset.
  ///
  /// In en, this message translates to:
  /// **'Reset to defaults'**
  String get groupDetailStreakReset;

  /// No description provided for @groupDetailNewTestButton.
  ///
  /// In en, this message translates to:
  /// **'New test'**
  String get groupDetailNewTestButton;

  /// No description provided for @groupDetailQuestionCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No questions} one{{count} question} other{{count} questions}}'**
  String groupDetailQuestionCount(int count);

  /// No description provided for @authTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authTitle;

  /// No description provided for @authSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sync groups, tests and progress across devices. All cards keep working without signing in.'**
  String get authSubtitle;

  /// No description provided for @authGoogleButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get authGoogleButton;

  /// No description provided for @authContinueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue without signing in'**
  String get authContinueAsGuest;

  /// No description provided for @authLegalNote.
  ///
  /// In en, this message translates to:
  /// **'By continuing you accept the terms of use and the privacy policy.'**
  String get authLegalNote;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed. Please try again'**
  String get authErrorGeneric;

  /// No description provided for @authWelcomeSnack.
  ///
  /// In en, this message translates to:
  /// **'Your local tests were added to the account'**
  String get authWelcomeSnack;

  /// No description provided for @profileSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get profileSignInTitle;

  /// No description provided for @profileSignInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To sync your progress'**
  String get profileSignInSubtitle;

  /// No description provided for @profileSignOutRow.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileSignOutRow;

  /// No description provided for @profileSignOutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get profileSignOutDialogTitle;

  /// No description provided for @profileSignOutDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Local cards stay on the device, syncing will stop.'**
  String get profileSignOutDialogMessage;

  /// No description provided for @profileSignOutDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileSignOutDialogConfirm;

  /// No description provided for @syncTitleSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get syncTitleSynced;

  /// No description provided for @syncTitleSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing…'**
  String get syncTitleSyncing;

  /// No description provided for @syncTitleNotSynced.
  ///
  /// In en, this message translates to:
  /// **'Not synced'**
  String get syncTitleNotSynced;

  /// No description provided for @syncTitleOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get syncTitleOffline;

  /// No description provided for @syncTitleExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired'**
  String get syncTitleExpired;

  /// No description provided for @syncTitleFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync failed'**
  String get syncTitleFailed;

  /// No description provided for @syncSubtitleSyncedRelative.
  ///
  /// In en, this message translates to:
  /// **'Last time — {time}'**
  String syncSubtitleSyncedRelative(String time);

  /// No description provided for @syncSubtitleNever.
  ///
  /// In en, this message translates to:
  /// **'Not synced yet'**
  String get syncSubtitleNever;

  /// No description provided for @syncSubtitleSyncingCounted.
  ///
  /// In en, this message translates to:
  /// **'Loaded {done} of {total} changes'**
  String syncSubtitleSyncingCounted(int done, int total);

  /// No description provided for @syncSubtitleSyncingPlain.
  ///
  /// In en, this message translates to:
  /// **'Sending changes and fetching new ones'**
  String get syncSubtitleSyncingPlain;

  /// No description provided for @syncSubtitlePending.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} change waiting to be sent} other{{count} changes waiting to be sent}}'**
  String syncSubtitlePending(int count);

  /// No description provided for @syncSubtitleOffline.
  ///
  /// In en, this message translates to:
  /// **'Changes will be sent once you are back online'**
  String get syncSubtitleOffline;

  /// No description provided for @syncSubtitleExpired.
  ///
  /// In en, this message translates to:
  /// **'Sign in again to resume syncing'**
  String get syncSubtitleExpired;

  /// No description provided for @syncSubtitleFailed.
  ///
  /// In en, this message translates to:
  /// **'Changes are stored on the device, try again'**
  String get syncSubtitleFailed;

  /// No description provided for @syncDialogBodySynced.
  ///
  /// In en, this message translates to:
  /// **'All cards, groups and progress are stored on the server.'**
  String get syncDialogBodySynced;

  /// No description provided for @syncDialogBodySyncing.
  ///
  /// In en, this message translates to:
  /// **'Sending your changes and fetching fresh cards from the server.'**
  String get syncDialogBodySyncing;

  /// No description provided for @syncDialogBodyNotSynced.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} change is only on this device: your other devices will not see it.} other{{count} changes are only on this device: your other devices will not see them.}}'**
  String syncDialogBodyNotSynced(int count);

  /// No description provided for @syncDialogBodyOffline.
  ///
  /// In en, this message translates to:
  /// **'No connection. The app works offline, changes are stored on the device and will be sent automatically.'**
  String get syncDialogBodyOffline;

  /// No description provided for @syncDialogBodyExpired.
  ///
  /// In en, this message translates to:
  /// **'The session has expired, so syncing stopped. Cards and progress are stored on the device.'**
  String get syncDialogBodyExpired;

  /// No description provided for @syncDialogBodyFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync failed. Cards and progress are stored on the device.'**
  String get syncDialogBodyFailed;

  /// No description provided for @syncDialogLastSyncLabel.
  ///
  /// In en, this message translates to:
  /// **'Last sync'**
  String get syncDialogLastSyncLabel;

  /// No description provided for @syncDialogLastSyncApprox.
  ///
  /// In en, this message translates to:
  /// **'About {time}'**
  String syncDialogLastSyncApprox(String time);

  /// No description provided for @syncDialogClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get syncDialogClose;

  /// No description provided for @syncActionSync.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get syncActionSync;

  /// No description provided for @syncActionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get syncActionRetry;

  /// No description provided for @syncActionSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get syncActionSignIn;

  /// No description provided for @syncTimeJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get syncTimeJustNow;

  /// No description provided for @syncTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} minute ago} other{{count} minutes ago}}'**
  String syncTimeMinutesAgo(int count);

  /// No description provided for @syncTimeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} hour ago} other{{count} hours ago}}'**
  String syncTimeHoursAgo(int count);

  /// No description provided for @syncTimeToday.
  ///
  /// In en, this message translates to:
  /// **'today at {time}'**
  String syncTimeToday(String time);

  /// No description provided for @syncTimeYesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday at {time}'**
  String syncTimeYesterday(String time);

  /// No description provided for @syncTimeAtDate.
  ///
  /// In en, this message translates to:
  /// **'{date} at {time}'**
  String syncTimeAtDate(String date, String time);

  /// No description provided for @syncReauthTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in again'**
  String get syncReauthTitle;

  /// No description provided for @syncReauthBody.
  ///
  /// In en, this message translates to:
  /// **'The session has expired. Cards and progress are stored on the device — everything will be uploaded after you sign in.'**
  String get syncReauthBody;

  /// No description provided for @syncReauthLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get syncReauthLater;

  /// No description provided for @syncReauthSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get syncReauthSignIn;

  /// No description provided for @groupsListTitle.
  ///
  /// In en, this message translates to:
  /// **'My groups'**
  String get groupsListTitle;

  /// No description provided for @groupsListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Test groups for flashcard learning'**
  String get groupsListSubtitle;

  /// No description provided for @syncSubtitleSyncedNoTime.
  ///
  /// In en, this message translates to:
  /// **'All changes are on the server'**
  String get syncSubtitleSyncedNoTime;

  /// No description provided for @settingsHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Test history'**
  String get settingsHistoryTitle;

  /// No description provided for @settingsHistoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Test attempts behind the charts and progress on the results screen'**
  String get settingsHistoryDescription;

  /// No description provided for @settingsHistoryUsage.
  ///
  /// In en, this message translates to:
  /// **'Takes up {size}'**
  String settingsHistoryUsage(String size);

  /// No description provided for @settingsHistoryUsageEstimate.
  ///
  /// In en, this message translates to:
  /// **'Takes up ≈ {size}'**
  String settingsHistoryUsageEstimate(String size);

  /// No description provided for @settingsHistoryUsageUnknown.
  ///
  /// In en, this message translates to:
  /// **'Size unknown'**
  String get settingsHistoryUsageUnknown;

  /// No description provided for @settingsHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get settingsHistoryEmpty;

  /// No description provided for @settingsHistoryClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get settingsHistoryClear;

  /// No description provided for @settingsHistoryClearDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear test history?'**
  String get settingsHistoryClearDialogTitle;

  /// No description provided for @settingsHistoryClearDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Charts and per-question progress will start over. Statistics, tests and cards will stay.'**
  String get settingsHistoryClearDialogMessage;

  /// No description provided for @settingsHistoryClearDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get settingsHistoryClearDialogConfirm;

  /// No description provided for @settingsHistoryClearedSnack.
  ///
  /// In en, this message translates to:
  /// **'History cleared'**
  String get settingsHistoryClearedSnack;

  /// No description provided for @settingsHistoryClearFailedSnack.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t clear history'**
  String get settingsHistoryClearFailedSnack;

  /// No description provided for @settingsHistorySizeBytes.
  ///
  /// In en, this message translates to:
  /// **'{size} B'**
  String settingsHistorySizeBytes(String size);

  /// No description provided for @settingsHistorySizeKilobytes.
  ///
  /// In en, this message translates to:
  /// **'{size} KB'**
  String settingsHistorySizeKilobytes(String size);

  /// No description provided for @settingsHistorySizeMegabytes.
  ///
  /// In en, this message translates to:
  /// **'{size} MB'**
  String settingsHistorySizeMegabytes(String size);

  /// No description provided for @settingsAppearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearanceTitle;

  /// No description provided for @settingsThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeTitle;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsStyleTitle.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get settingsStyleTitle;

  /// No description provided for @settingsStyleColorful.
  ///
  /// In en, this message translates to:
  /// **'Colorful'**
  String get settingsStyleColorful;

  /// No description provided for @settingsStyleMonochrome.
  ///
  /// In en, this message translates to:
  /// **'Monochrome'**
  String get settingsStyleMonochrome;

  /// No description provided for @settingsStyleAmoled.
  ///
  /// In en, this message translates to:
  /// **'AMOLED'**
  String get settingsStyleAmoled;

  /// No description provided for @settingsAccentHintColorful.
  ///
  /// In en, this message translates to:
  /// **'The whole app palette is built from this color'**
  String get settingsAccentHintColorful;

  /// No description provided for @settingsAccentHintMonochrome.
  ///
  /// In en, this message translates to:
  /// **'In monochrome the accent highlights only the essentials: buttons, progress, selection'**
  String get settingsAccentHintMonochrome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
