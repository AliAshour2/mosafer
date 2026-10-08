import 'package:flutter/material.dart';

import '../../tokens/app_colors.dart';
import '../../tokens/app_sizes.dart';
import '../../tokens/app_spacing.dart';

class AppRouteDisplay extends StatelessWidget {
  const AppRouteDisplay({
    super.key,
    required this.origin,
    required this.destination,
    this.originLabel = 'Pickup',
    this.destinationLabel = 'Drop-off',
  });

  final String origin;
  final String destination;
  final String originLabel;
  final String destinationLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semanticColors = theme.extension<AppSemanticColors>()!;

    return Semantics(
      container: true,
      label: '$originLabel: $origin. $destinationLabel: $destination.',
      child: ExcludeSemantics(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Icon(
                  Icons.trip_origin,
                  size: AppSizes.iconMedium,
                  color: theme.colorScheme.primary,
                ),
                Container(
                  width: 1,
                  height: AppSpacing.xxl,
                  color: semanticColors.border,
                ),
                Icon(
                  Icons.location_on_outlined,
                  size: AppSizes.iconMedium,
                  color: semanticColors.info,
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(originLabel, style: theme.textTheme.labelMedium),
                  Text(origin, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: AppSpacing.md),
                  Text(destinationLabel, style: theme.textTheme.labelMedium),
                  Text(destination, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
