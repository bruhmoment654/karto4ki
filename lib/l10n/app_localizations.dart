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
    Locale('ru')
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
  /// **'DON'T KNOW'**
  String get tinderTestUnknownBadge;

  /// No description provided for @tinderTestKnownBadge.
  ///
  /// In en, this message translates to:
  /// **'KNOW'**
  String get tinderTestKnownBadge;

  /// No description provided for @tinderTestSwipeUnknownHint.
  ///
  /// In en, this message translates to:
  /// **'Don't know'**
  String get tinderTestSwipeUnknownHint;

  /// No description provided for @tinderTestSwipeKnownHint.
  ///
  /// In en, this message translates to:
  /// **'Know'**
  String get tinderTestSwipeKnownHint;

  /// No description provided for @tinderTestResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Test completed!'**
  String get tinderTestResultsTitle;

  /// No description provided for @tinderTestResultsCorrectLabel.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get tinderTestResultsCorrectLabel;

  /// No description provided for @tinderTestResultsIncorrectLabel.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get tinderTestResultsIncorrectLabel;

  /// No description provided for @tinderTestResultsPercentageLabel.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get tinderTestResultsPercentageLabel;

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
  /// **'Are you sure you want to delete "{title}"?'**
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
      'that was used.');
}
