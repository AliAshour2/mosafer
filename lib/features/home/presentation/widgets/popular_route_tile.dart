import 'package:flutter/material.dart';

import '../../../../core/design_system/app_design_system.dart';

class PopularRouteTile extends StatelessWidget {
  const PopularRouteTile({
    super.key,
    required this.origin,
    required this.destination,
    required this.onTap,
  });

  final String origin;
  final String destination;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 220,
      child: AppCard(
        onTap: onTap,
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.sm,
        ),
        child: Row(
          children: [
            Icon(
              Icons.swap_horiz,
              color: theme.colorScheme.primary,
              size: AppSizes.iconMedium,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                '$origin  →  $destination',
                style: theme.textTheme.labelLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
