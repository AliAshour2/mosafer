import '../../../l10n/app_localizations.dart';
import '../domain/entities/auth_failure.dart';

String authErrorMessage(AppLocalizations l10n, Object? error) {
  if (error is! AuthFailure) return l10n.authUnexpectedFailure;

  return switch (error.type) {
    AuthFailureType.invalidPhone => l10n.authInvalidPhone,
  };
}
