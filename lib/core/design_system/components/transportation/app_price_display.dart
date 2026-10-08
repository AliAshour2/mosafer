import 'package:flutter/material.dart';

import '../../tokens/app_spacing.dart';

class AppPriceDisplay extends StatelessWidget {
  const AppPriceDisplay({
    super.key,
    required this.amount,
    required this.currency,
    this.caption,
  });

  final String amount;
  final String currency;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: [caption, amount, currency].whereType<String>().join(' '),
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (caption != null) ...[
              Text(
                caption!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: amount, style: theme.textTheme.titleLarge),
                  const TextSpan(text: ' '),
                  TextSpan(text: currency, style: theme.textTheme.labelMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
