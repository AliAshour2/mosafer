import 'package:flutter/material.dart';

import '../../../../core/design_system/app_design_system.dart';
import '../../domain/entities/trip.dart';

class TravelDetailsCard extends StatelessWidget {
  const TravelDetailsCard({
    super.key,
    required this.trip,
    required this.departure,
    required this.status,
    required this.seatsRemaining,
    required this.imageDescription,
  });

  static const imageAsset = 'assets/images/alexandria-cairo.png';

  final Trip trip;
  final String departure;
  final String status;
  final String seatsRemaining;
  final String imageDescription;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      label:
          '${trip.origin}, ${trip.destination}, $departure. $status. $seatsRemaining.',
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: theme.colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              image: true,
              label: imageDescription,
              child: Image.asset(
                imageAsset,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => ColoredBox(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const SizedBox(height: 160),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${trip.origin}  →  ${trip.destination}',
                          style: theme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      AppStatusBadge(
                        label: status,
                        tone: AppStatusTone.success,
                        icon: Icons.near_me_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: AppSizes.iconSmall,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        departure,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppPriceDisplay(
                        amount: trip.price.toStringAsFixed(0),
                        currency: trip.currency,
                      ),
                      Flexible(
                        child: Text(
                          seatsRemaining,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
