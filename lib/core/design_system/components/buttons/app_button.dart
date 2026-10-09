import 'package:flutter/material.dart';

import '../../tokens/app_sizes.dart';
import '../../tokens/app_spacing.dart';

enum AppButtonVariant {
  primary,
  secondary,
  outlined,
  text,
  danger,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final progressColor = switch (variant) {
      AppButtonVariant.primary => colorScheme.onPrimary,
      AppButtonVariant.secondary => colorScheme.onSecondaryContainer,
      AppButtonVariant.outlined ||
      AppButtonVariant.text =>
        colorScheme.onSurface,
      AppButtonVariant.danger => colorScheme.onError,
    };
    final child = _ButtonContents(
      label: label,
      icon: icon,
      isLoading: isLoading,
      progressColor: progressColor,
    );
    final callback = isLoading ? null : onPressed;
    final button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
          onPressed: callback,
          child: child,
        ),
      AppButtonVariant.secondary => FilledButton.tonal(
          onPressed: callback,
          child: child,
        ),
      AppButtonVariant.outlined => OutlinedButton(
          onPressed: callback,
          child: child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: callback,
          child: child,
        ),
      AppButtonVariant.danger => ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          child: child,
        ),
    };

    if (!expand) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}

class _ButtonContents extends StatelessWidget {
  const _ButtonContents({
    required this.label,
    required this.icon,
    required this.isLoading,
    required this.progressColor,
  });

  final String label;
  final IconData? icon;
  final bool isLoading;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: AppSizes.iconSmall,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              semanticsLabel: 'Loading',
              color: progressColor,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(label),
        ],
      );
    }

    if (icon == null) return Text(label);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppSizes.iconMedium),
        const SizedBox(width: AppSpacing.sm),
        Text(label),
      ],
    );
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
    this.isSelected = false,
    this.matchTextDirection = false,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final bool isSelected;
  final bool matchTextDirection;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: onPressed,
      tooltip: semanticLabel,
      iconSize: AppSizes.iconLarge,
      constraints: const BoxConstraints.tightFor(
        width: AppSizes.minimumTapTarget,
        height: AppSizes.minimumTapTarget,
      ),
      isSelected: isSelected,
      selectedIcon: Icon(
        _directionalIcon,
        color: colorScheme.primary,
      ),
      icon: Icon(
        _directionalIcon,
        color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
      ),
    );
  }

  IconData get _directionalIcon {
    if (!matchTextDirection) return icon;
    return IconData(
      icon.codePoint,
      fontFamily: icon.fontFamily,
      fontPackage: icon.fontPackage,
      matchTextDirection: true,
    );
  }
}
