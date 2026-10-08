import 'package:flutter/material.dart';

import '../../tokens/app_colors.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_sizes.dart';
import '../../tokens/app_spacing.dart';

enum AppStatusTone {
  neutral,
  success,
  warning,
  error,
  info,
}

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.label,
    required this.tone,
    this.icon,
  });

  final String label;
  final AppStatusTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semanticColors = theme.extension<AppSemanticColors>()!;
    final (foreground, background, defaultIcon) = switch (tone) {
      AppStatusTone.neutral => (
          theme.colorScheme.onSurfaceVariant,
          theme.colorScheme.surfaceContainerHighest,
          Icons.circle_outlined,
        ),
      AppStatusTone.success => (
          semanticColors.success,
          semanticColors.successContainer,
          Icons.check_circle_outline,
        ),
      AppStatusTone.warning => (
          semanticColors.warning,
          semanticColors.warningContainer,
          Icons.warning_amber_rounded,
        ),
      AppStatusTone.error => (
          semanticColors.error,
          semanticColors.errorContainer,
          Icons.error_outline,
        ),
      AppStatusTone.info => (
          semanticColors.info,
          semanticColors.infoContainer,
          Icons.info_outline,
        ),
    };

    return Semantics(
      label: label,
      child: ExcludeSemantics(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon ?? defaultIcon,
                size: AppSizes.iconSmall,
                color: foreground,
                semanticLabel: null,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
