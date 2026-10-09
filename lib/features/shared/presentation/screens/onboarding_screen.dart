import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_locale_provider.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/design_system/app_design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/widgets/auth_brand_mark.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final titles = [
      l10n.onboardingTitle,
      l10n.onboardingTripsTitle,
      l10n.onboardingSafeTitle,
    ];
    final descriptions = [
      l10n.onboardingDescription,
      l10n.onboardingTripsDescription,
      l10n.onboardingSafeDescription,
    ];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSizes.feedbackContentMaxWidth,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const AuthBrandMark(),
                      const Spacer(),
                      TextButton(
                        onPressed: () =>
                            ref.read(appLocaleProvider.notifier).toggle(),
                        child: Text(l10n.onboardingSwitchLanguage),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: titles.length,
                      onPageChanged: (page) => setState(() => _page = page),
                      itemBuilder: (context, index) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            l10n.onboardingEyebrow,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            titles[index],
                            style: theme.textTheme.headlineLarge,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            descriptions[index],
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Semantics(
                    label:
                        l10n.onboardingPageIndicator(_page + 1, titles.length),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        titles.length,
                        (index) => Container(
                          width: index == _page ? AppSpacing.lg : AppSpacing.xs,
                          height: AppSpacing.xs,
                          margin: const EdgeInsetsDirectional.only(
                            end: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: index == _page
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outlineVariant,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppButton(
                    label: _page == titles.length - 1
                        ? l10n.onboardingGetStarted
                        : l10n.authContinue,
                    expand: true,
                    onPressed: _continue,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.auth),
                    child: Text(l10n.onboardingAlreadyAccount),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _continue() {
    if (_page == 2) {
      context.go(AppRoutes.auth);
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }
}
