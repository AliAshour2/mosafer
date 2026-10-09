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
  String get homeGreeting => 'Mosafer';

  @override
  String get homeWelcome => 'Your next journey starts here.';

  @override
  String get homeSearchTitle => 'Where are you going?';

  @override
  String get homeSearchSubtitle => 'Book a seat on a scheduled coach.';

  @override
  String get homeFrom => 'From';

  @override
  String get homeTo => 'To';

  @override
  String get homeAlexandria => 'Alexandria';

  @override
  String get homeCairo => 'Cairo';

  @override
  String get homeGiza => 'Giza';

  @override
  String get homeToday => 'Today';

  @override
  String get homeAnyTime => 'Any time';

  @override
  String get homeSearchTrips => 'Search trips';

  @override
  String get homeUpcoming => 'Upcoming';

  @override
  String get homeSeeAll => 'See all';

  @override
  String homeDepartureDetails(Object date, Object time) {
    return '$date · $time';
  }

  @override
  String get homeTripStatus => 'Upcoming';

  @override
  String get homeTripImageDescription => 'Alexandria and Cairo city views';

  @override
  String get homePopularRoutes => 'Popular routes';

  @override
  String homeSeatsRemaining(int count) {
    return '$count seats left';
  }

  @override
  String get homeNoUpcomingTrips => 'No upcoming trips right now.';

  @override
  String get homeNoPopularRoutes => 'Popular routes will appear here.';

  @override
  String get homeTripsLoadTitle => 'Trips are temporarily unavailable';

  @override
  String get homeTripsLoadError => 'We couldn\'t load demo trips. Check your connection and try again.';

  @override
  String get homeRetry => 'Retry';

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
