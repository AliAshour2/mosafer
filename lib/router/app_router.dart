import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/constants/app_routes.dart';
import '../features/auth/application/auth_providers.dart';
import '../features/auth/presentation/pages/auth_sign_in_page.dart';
import '../features/auth/presentation/pages/profile_completion_page.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/shared/presentation/screens/onboarding_screen.dart';
import '../features/shared/presentation/screens/placeholder_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final router = GoRouter(
    initialLocation: AppRoutes.onboarding,
    redirect: (context, state) {
      final isAuthRoute = AppRoutes.isAuthRoute(state.matchedLocation);
      final isOnboardingRoute =
          AppRoutes.isOnboardingRoute(state.matchedLocation);
      final isProfileCompletionRoute =
          AppRoutes.isProfileCompletionRoute(state.matchedLocation);
      final user = authRepository.currentUser;
      final isSignedIn = user != null;

      if (!isSignedIn && !isAuthRoute && !isOnboardingRoute) {
        return AppRoutes.onboarding;
      }
      if (isSignedIn) {
        final profile = ref.read(currentUserProfileProvider);
        if (profile.valueOrNull != null) {
          if (isAuthRoute || isOnboardingRoute || isProfileCompletionRoute) {
            return AppRoutes.home;
          }
          return null;
        }
        if (!isProfileCompletionRoute) return AppRoutes.completeProfile;
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthSignInPage(),
      ),
      GoRoute(
        path: AppRoutes.completeProfile,
        builder: (context, state) => const ProfileCompletionPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.trips,
        builder: (context, state) => const PlaceholderScreen(title: 'Trips'),
      ),
      GoRoute(
        path: AppRoutes.booking,
        builder: (context, state) => const PlaceholderScreen(title: 'Booking'),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const PlaceholderScreen(title: 'Profile'),
      ),
      GoRoute(
        path: AppRoutes.driver,
        builder: (context, state) => const PlaceholderScreen(title: 'Driver'),
      ),
      GoRoute(
        path: AppRoutes.admin,
        builder: (context, state) => const PlaceholderScreen(title: 'Admin'),
      ),
    ],
  );

  ref.listen(authStateProvider, (previous, next) {
    if (previous?.valueOrNull?.id != next.valueOrNull?.id) {
      ref.invalidate(currentUserProfileProvider);
    }
    router.refresh();
  });
  ref.listen(currentUserProfileProvider, (_, __) => router.refresh());
  ref.onDispose(router.dispose);
  return router;
}
