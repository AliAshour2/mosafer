import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/design_system/app_design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/presentation/auth_error_message.dart';
import '../../application/trip_providers.dart';
import '../../domain/entities/trip.dart';
import '../widgets/popular_route_tile.dart';
import '../widgets/travel_details_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authAction = ref.watch(authControllerProvider);
    final profile = ref.watch(currentUserProfileProvider).valueOrNull;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile?.fullName ?? l10n.homeGreeting,
                              style: theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              l10n.homeWelcome,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppIconButton(
                        icon: Icons.logout,
                        semanticLabel: l10n.authSignOut,
                        onPressed: authAction.isLoading
                            ? null
                            : () => ref
                                .read(authControllerProvider.notifier)
                                .signOut(),
                      ),
                    ],
                  ),
                  if (authAction.hasError) ...[
                    const SizedBox(height: AppSpacing.md),
                    AppInlineError(
                      message: authErrorMessage(l10n, authAction.error),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    l10n.homeSearchTitle,
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.homeSearchSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _LocationField(
                          label: l10n.homeFrom,
                          value: l10n.homeAlexandria,
                          icon: Icons.trip_origin,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: AppSpacing.sm,
                          ),
                          child: Icon(
                            Icons.swap_vert,
                            color: theme.colorScheme.primary,
                            size: AppSizes.iconMedium,
                          ),
                        ),
                        _LocationField(
                          label: l10n.homeTo,
                          value: l10n.homeCairo,
                          icon: Icons.location_on_outlined,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            Expanded(
                              child: _TripPreference(
                                icon: Icons.calendar_today_outlined,
                                label: l10n.homeToday,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: _TripPreference(
                                icon: Icons.access_time,
                                label: l10n.homeAnyTime,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppButton(
                          label: l10n.homeSearchTrips,
                          icon: Icons.search,
                          expand: true,
                          onPressed: () => context.go(AppRoutes.trips),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  const _HomeTripSections(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTripSections extends ConsumerWidget {
  const _HomeTripSections();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final trips = ref.watch(upcomingTripsProvider);
    return trips.when(
      loading: () => const AppSkeleton(height: 260),
      error: (error, stackTrace) => AppErrorState(
        title: l10n.homeTripsLoadTitle,
        message: l10n.homeTripsLoadError,
        retryLabel: l10n.homeRetry,
        onRetry: () => ref.invalidate(upcomingTripsProvider),
      ),
      data: (items) => _TripSectionsData(trips: items),
    );
  }
}

class _TripSectionsData extends StatelessWidget {
  const _TripSectionsData({required this.trips});

  final List<Trip> trips;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final materialLocalizations = MaterialLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.homeUpcoming,
                style: theme.textTheme.titleLarge,
              ),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.trips),
              child: Text(l10n.homeSeeAll),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        if (trips.isEmpty)
          Text(
            l10n.homeNoUpcomingTrips,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          )
        else
          TravelDetailsCard(
            trip: trips.first,
            departure: l10n.homeDepartureDetails(
              materialLocalizations.formatMediumDate(trips.first.departureAt),
              materialLocalizations.formatTimeOfDay(
                TimeOfDay.fromDateTime(trips.first.departureAt),
              ),
            ),
            status: l10n.homeTripStatus,
            seatsRemaining: l10n.homeSeatsRemaining(
              trips.first.seatsAvailable,
            ),
            imageDescription: l10n.homeTripImageDescription,
          ),
        const SizedBox(height: AppSpacing.xxl),
        Text(
          l10n.homePopularRoutes,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        if (trips.isEmpty)
          Text(
            l10n.homeNoPopularRoutes,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          )
        else
          SizedBox(
            height: AppSizes.minimumTapTarget * 2,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: trips.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final trip = trips[index];
                return PopularRouteTile(
                  origin: trip.origin,
                  destination: trip.destination,
                  onTap: () => context.go(AppRoutes.trips),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: AppSizes.iconMedium),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(value, style: theme.textTheme.titleMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _TripPreference extends StatelessWidget {
  const _TripPreference({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(
        minHeight: AppSizes.minimumTapTarget,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: AppSizes.iconSmall),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              label,
              style: theme.textTheme.labelLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
