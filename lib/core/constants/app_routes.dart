class AppRoutes {
  AppRoutes._();

  static const auth = '/auth/sign-in';
  static const completeProfile = '/auth/complete-profile';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const trips = '/trips';
  static const booking = '/booking';
  static const profile = '/profile';
  static const driver = '/driver';
  static const admin = '/admin';

  static bool isAuthRoute(String location) {
    return location == auth;
  }

  static bool isOnboardingRoute(String location) {
    return location == onboarding;
  }

  static bool isProfileCompletionRoute(String location) {
    return location == completeProfile;
  }
}
