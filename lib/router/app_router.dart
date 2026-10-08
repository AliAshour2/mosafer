import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/constants/app_routes.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/shared/presentation/screens/placeholder_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (_, __) => null,
    routes: <RouteBase>[
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
}
