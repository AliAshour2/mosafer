import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get authPhoneTitle => 'Continue with your phone';

  @override
  String get authPhoneSubtitle => 'Enter your phone number to continue.';

  @override
  String get authPhoneLabel => 'Phone number';

  @override
  String get authPhoneHint => 'Enter phone number';

  @override
  String get authPhoneHelp => 'Include your country calling code. No code will be sent in this demo.';

  @override
  String get authDemoNotice => 'Demo only: this number is not verified and does not create a secure account.';

  @override
  String get authContinue => 'Continue';

  @override
  String get authInvalidPhone => 'Enter a valid phone number with its country calling code.';

  @override
  String get authUnexpectedFailure => 'Something went wrong. Please try again.';

  @override
  String get authSignOut => 'Sign out';

  @override
  String get onboardingEyebrow => 'TRACK YOUR TRIP';

  @override
  String get onboardingTitle => 'Know exactly where you are';

  @override
  String get onboardingDescription => 'Follow your ride live, see your driver, and get notified at every stage.';

  @override
  String get onboardingTripsTitle => 'Your trips, all in one place';

  @override
  String get onboardingTripsDescription => 'Find the details you need before, during, and after every journey.';

  @override
  String get onboardingSafeTitle => 'Travel with confidence';

  @override
  String get onboardingSafeDescription => 'Stay informed from pickup to arrival with helpful trip updates.';

  @override
  String get onboardingSwitchLanguage => 'العربية';

  @override
  String get onboardingGetStarted => 'Get started';

  @override
  String get onboardingAlreadyAccount => 'Continue with phone number';

  @override
  String onboardingPageIndicator(int current, int total) {
    return 'Page $current of $total';
  }
}
