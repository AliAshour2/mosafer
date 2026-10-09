import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/design_system/app_design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../application/auth_providers.dart';
import '../../domain/entities/auth_input_validator.dart';
import '../auth_error_message.dart';
import '../widgets/auth_brand_mark.dart';

class AuthSignInPage extends ConsumerStatefulWidget {
  const AuthSignInPage({super.key});

  @override
  ConsumerState<AuthSignInPage> createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends ConsumerState<AuthSignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  l10n.authPhoneTitle,
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.authPhoneSubtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        controller: _phoneController,
                        label: l10n.authPhoneLabel,
                        hint: l10n.authPhoneHint,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        textDirection: TextDirection.ltr,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        enabled: !action.isLoading,
                        onChanged: (_) => ref
                            .read(authControllerProvider.notifier)
                            .clearError(),
                        onFieldSubmitted: (_) => _continue(),
                        validator: (value) {
                          final phone =
                              AuthInputValidator.normalizePhone(value);
                          if (phone == null ||
                              !AuthInputValidator.isValidPhone(phone)) {
                            return l10n.authInvalidPhone;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.authPhoneHelp,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (action.hasError) ...[
                        const SizedBox(height: AppSpacing.lg),
                        AppInlineError(
                          message: authErrorMessage(l10n, action.error),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.xl),
                      AppButton(
                        label: l10n.authContinue,
                        isLoading: action.isLoading,
                        expand: true,
                        onPressed: _continue,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.authDemoNotice,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _continue() async {
    if (_formKey.currentState?.validate() != true) return;
    await ref.read(authControllerProvider.notifier).continueWithPhone(
          phone: AuthInputValidator.normalizePhone(_phoneController.text)!,
        );
    if (!mounted || ref.read(authControllerProvider).hasError) return;
    context.go(AppRoutes.home);
  }
}
