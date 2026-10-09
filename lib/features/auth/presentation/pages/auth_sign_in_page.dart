import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/app_design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../application/auth_providers.dart';
import '../auth_error_message.dart';
import '../widgets/auth_brand_mark.dart';

class AuthSignInPage extends ConsumerWidget {
  const AuthSignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final action = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSizes.feedbackContentMaxWidth,
            ),
            child: ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl,
                AppSpacing.xxxl,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              shrinkWrap: true,
              children: [
                const AuthBrandMark(),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.authGoogleTitle,
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.authGoogleSubtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                if (action.hasError) ...[
                  AppInlineError(
                    message: authErrorMessage(l10n, action.error),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
                AppButton(
                  label: l10n.authGoogleAction,
                  isLoading: action.isLoading,
                  expand: true,
                  onPressed: () => ref
                      .read(authControllerProvider.notifier)
                      .signInWithGoogle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
