import 'package:flutter/material.dart';

import '../../tokens/app_colors.dart';
import '../../tokens/app_radius.dart';
import '../../tokens/app_spacing.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
    this.isEnabled = true,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isEnabled;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final semanticColors = Theme.of(context).extension<AppSemanticColors>();
    final card = Card(
      color: isEnabled
          ? colorScheme.surface
          : semanticColors?.disabledBackground ?? colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: onTap != null && isEnabled
          ? InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppRadius.large),
              child: Padding(padding: padding, child: child),
            )
          : Padding(padding: padding, child: child),
    );

    return Semantics(
      enabled: isEnabled,
      selected: isSelected,
      child: card,
    );
  }
}
