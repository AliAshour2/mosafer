import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get authPhoneTitle => 'المتابعة برقم الهاتف';

  @override
  String get authPhoneSubtitle => 'أدخل رقم هاتفك للمتابعة.';

  @override
  String get authPhoneLabel => 'رقم الهاتف';

  @override
  String get authPhoneHint => 'أدخل رقم الهاتف';

  @override
  String get authPhoneHelp => 'أدخل مفتاح الدولة. لن يُرسل أي رمز في هذه النسخة التجريبية.';

  @override
  String get authDemoNotice => 'نسخة تجريبية فقط: لم يتم التحقق من الرقم ولا يتم إنشاء حساب آمن.';

  @override
  String get authContinue => 'متابعة';

  @override
  String get authInvalidPhone => 'أدخل رقم هاتف صحيحًا مع مفتاح الدولة.';

  @override
  String get authUnexpectedFailure => 'حدث خطأ ما. حاول مجددًا.';

  @override
  String get authSignOut => 'تسجيل الخروج';

  @override
  String get onboardingEyebrow => 'تابع رحلتك';

  @override
  String get onboardingTitle => 'اعرف موقعك بدقة';

  @override
  String get onboardingDescription => 'تابع رحلتك مباشرة، وتعرّف على السائق، واحصل على تحديثات في كل مرحلة.';

  @override
  String get onboardingTripsTitle => 'كل رحلاتك في مكان واحد';

  @override
  String get onboardingTripsDescription => 'اعثر على التفاصيل التي تحتاجها قبل كل رحلة وأثناءها وبعدها.';

  @override
  String get onboardingSafeTitle => 'سافر براحة واطمئنان';

  @override
  String get onboardingSafeDescription => 'ابقَ على اطلاع من نقطة الانطلاق حتى الوصول.';

  @override
  String get onboardingSwitchLanguage => 'English';

  @override
  String get onboardingGetStarted => 'ابدأ الآن';

  @override
  String get onboardingAlreadyAccount => 'المتابعة برقم الهاتف';

  @override
  String onboardingPageIndicator(int current, int total) {
    return 'الصفحة $current من $total';
  }
}
