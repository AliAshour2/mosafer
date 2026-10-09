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

class ProfileCompletionPage extends ConsumerStatefulWidget {
  const ProfileCompletionPage({super.key});

  @override
  ConsumerState<ProfileCompletionPage> createState() =>
      _ProfileCompletionPageState();
}

class _ProfileCompletionPageState extends ConsumerState<ProfileCompletionPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _namePrefilled = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final profile = ref.watch(currentUserProfileProvider);
    final action = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSizes.feedbackContentMaxWidth,
            ),
            child: profile.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (_, __) => ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(AppSpacing.xl),
                children: [
                  const AuthBrandMark(),
                  const SizedBox(height: AppSpacing.xl),
                  AppInlineError(message: l10n.authProfileLoadError),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    label: l10n.authRetry,
                    expand: true,
                    onPressed: () => ref.invalidate(currentUserProfileProvider),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppButton(
                    label: l10n.authSignOut,
                    variant: AppButtonVariant.text,
                    expand: true,
                    onPressed: () =>
                        ref.read(authControllerProvider.notifier).signOut(),
                  ),
                ],
              ),
              data: (savedProfile) {
                if (!_namePrefilled) {
                  _nameController.text = savedProfile?.fullName ??
                      ref
                          .read(authRepositoryProvider)
                          .currentUser
                          ?.displayName ??
                      '';
                  _namePrefilled = true;
                }

                return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.xl,
                    AppSpacing.xxxl,
                    AppSpacing.xl,
                    AppSpacing.xl,
                  ),
                  children: [
                    const AuthBrandMark(),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.authProfileTitle,
                      style: theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.authProfileSubtitle,
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
                            key: const Key('profile-name'),
                            controller: _nameController,
                            label: l10n.authNameLabel,
                            hint: l10n.authNameHint,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.name],
                            enabled: !action.isLoading,
                            onChanged: (_) => ref
                                .read(authControllerProvider.notifier)
                                .clearError(),
                            validator: (value) =>
                                AuthInputValidator.normalizeName(value) == null
                                    ? l10n.authInvalidName
                                    : null,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          AppTextField(
                            key: const Key('profile-phone'),
                            controller: _phoneController,
                            label: l10n.authPhoneLabel,
                            hint: l10n.authPhoneHint,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            textDirection: TextDirection.ltr,
                            autofillHints: const [
                              AutofillHints.telephoneNumber
                            ],
                            enabled: !action.isLoading,
                            onChanged: (_) => ref
                                .read(authControllerProvider.notifier)
                                .clearError(),
                            onFieldSubmitted: (_) => _saveProfile(),
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
                            l10n.authPhoneNotVerifiedNotice,
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
                            label: l10n.authSaveProfile,
                            isLoading: action.isLoading,
                            expand: true,
                            onPressed: _saveProfile,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() != true) return;
    await ref.read(authControllerProvider.notifier).completeProfile(
          fullName: _nameController.text,
          phone: _phoneController.text,
        );
    if (!mounted || ref.read(authControllerProvider).hasError) return;
    context.go(AppRoutes.home);
  }
}
