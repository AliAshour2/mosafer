import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @authPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue with your phone'**
  String get authPhoneTitle;

  /// No description provided for @authPhoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to continue.'**
  String get authPhoneSubtitle;

  /// No description provided for @authPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get authPhoneLabel;

  /// No description provided for @authPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get authPhoneHint;

  /// No description provided for @authPhoneHelp.
  ///
  /// In en, this message translates to:
  /// **'Include your country calling code. No code will be sent in this demo.'**
  String get authPhoneHelp;

  /// No description provided for @authDemoNotice.
  ///
  /// In en, this message translates to:
  /// **'Demo only: this number is not verified and does not create a secure account.'**
  String get authDemoNotice;

  /// No description provided for @authContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get authContinue;

  /// No description provided for @authInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number with its country calling code.'**
  String get authInvalidPhone;

  /// No description provided for @authUnexpectedFailure.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authUnexpectedFailure;

  /// No description provided for @authSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get authSignOut;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Mosafer'**
  String get homeGreeting;

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Your next journey starts here.'**
  String get homeWelcome;

  /// No description provided for @homeSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Where are you going?'**
  String get homeSearchTitle;

  /// No description provided for @homeSearchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Book a seat on a scheduled coach.'**
  String get homeSearchSubtitle;

  /// No description provided for @homeFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get homeFrom;

  /// No description provided for @homeTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get homeTo;

  /// No description provided for @homeAlexandria.
  ///
  /// In en, this message translates to:
  /// **'Alexandria'**
  String get homeAlexandria;

  /// No description provided for @homeCairo.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get homeCairo;

  /// No description provided for @homeGiza.
  ///
  /// In en, this message translates to:
  /// **'Giza'**
  String get homeGiza;

  /// No description provided for @homeToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get homeToday;

  /// No description provided for @homeAnyTime.
  ///
  /// In en, this message translates to:
  /// **'Any time'**
  String get homeAnyTime;

  /// No description provided for @homeSearchTrips.
  ///
  /// In en, this message translates to:
  /// **'Search trips'**
  String get homeSearchTrips;

  /// No description provided for @homeUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get homeUpcoming;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeSeeAll;

  /// No description provided for @homeDepartureDetails.
  ///
  /// In en, this message translates to:
  /// **'{date} · {time}'**
  String homeDepartureDetails(Object date, Object time);

  /// No description provided for @homeTripStatus.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get homeTripStatus;

  /// No description provided for @homeTripImageDescription.
  ///
  /// In en, this message translates to:
  /// **'Alexandria and Cairo city views'**
  String get homeTripImageDescription;

  /// No description provided for @homePopularRoutes.
  ///
  /// In en, this message translates to:
  /// **'Popular routes'**
  String get homePopularRoutes;

  /// No description provided for @homeSeatsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} seats left'**
  String homeSeatsRemaining(int count);

  /// No description provided for @homeNoUpcomingTrips.
  ///
  /// In en, this message translates to:
  /// **'No upcoming trips right now.'**
  String get homeNoUpcomingTrips;

  /// No description provided for @homeNoPopularRoutes.
  ///
  /// In en, this message translates to:
  /// **'Popular routes will appear here.'**
  String get homeNoPopularRoutes;

  /// No description provided for @homeTripsLoadTitle.
  ///
  /// In en, this message translates to:
  /// **'Trips are temporarily unavailable'**
  String get homeTripsLoadTitle;

  /// No description provided for @homeTripsLoadError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load demo trips. Check your connection and try again.'**
  String get homeTripsLoadError;

  /// No description provided for @homeRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get homeRetry;

  /// No description provided for @onboardingEyebrow.
  ///
  /// In en, this message translates to:
  /// **'TRACK YOUR TRIP'**
  String get onboardingEyebrow;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Know exactly where you are'**
  String get onboardingTitle;

  /// No description provided for @onboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Follow your ride live, see your driver, and get notified at every stage.'**
  String get onboardingDescription;

  /// No description provided for @onboardingTripsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your trips, all in one place'**
  String get onboardingTripsTitle;

  /// No description provided for @onboardingTripsDescription.
  ///
  /// In en, this message translates to:
  /// **'Find the details you need before, during, and after every journey.'**
  String get onboardingTripsDescription;

  /// No description provided for @onboardingSafeTitle.
  ///
  /// In en, this message translates to:
  /// **'Travel with confidence'**
  String get onboardingSafeTitle;

  /// No description provided for @onboardingSafeDescription.
  ///
  /// In en, this message translates to:
  /// **'Stay informed from pickup to arrival with helpful trip updates.'**
  String get onboardingSafeDescription;

  /// No description provided for @onboardingSwitchLanguage.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get onboardingSwitchLanguage;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingAlreadyAccount.
  ///
  /// In en, this message translates to:
  /// **'Continue with phone number'**
  String get onboardingAlreadyAccount;

  /// No description provided for @onboardingPageIndicator.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String onboardingPageIndicator(int current, int total);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
