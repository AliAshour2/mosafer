import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get authGoogleTitle => 'أنشئ حسابك أو سجّل الدخول';

  @override
  String get authGoogleSubtitle => 'تابع بأمان باستخدام Google. أضف اسمك ورقم هاتفك عند إنشاء حساب جديد.';

  @override
  String get authGoogleAction => 'المتابعة باستخدام Google';

  @override
  String get authProfileTitle => 'بعض التفاصيل';

  @override
  String get authProfileSubtitle => 'أكد اسمك وأضف رقم الهاتف الذي يمكننا التواصل معك من خلاله.';

  @override
  String get authNameLabel => 'الاسم الكامل';

  @override
  String get authNameHint => 'أدخل اسمك';

  @override
  String get authPhoneLabel => 'رقم الهاتف';

  @override
  String get authPhoneHint => 'أدخل رقم الهاتف';

  @override
  String get authPhoneNotVerifiedNotice => 'لن يتم إرسال رمز تحقق. سيُحفظ رقم الهاتف على أنه غير موثّق.';

  @override
  String get authInvalidName => 'أدخل اسمك (بحد أقصى 100 حرف).';

  @override
  String get authInvalidPhone => 'أدخل رقم هاتف صحيحًا مع مفتاح الدولة.';

  @override
  String get authSaveProfile => 'حفظ ومتابعة';

  @override
  String get authProfileLoadError => 'تعذر تحميل ملفك الشخصي. تحقق من اتصالك وحاول مجددًا.';

  @override
  String get authRetry => 'إعادة المحاولة';

  @override
  String get authUnexpectedFailure => 'حدث خطأ ما. حاول مجددًا.';

  @override
  String get authSignOut => 'تسجيل الخروج';

  @override
  String get homeGreeting => 'مسافر';

  @override
  String get homeWelcome => 'رحلتك القادمة تبدأ من هنا.';

  @override
  String get homeSearchTitle => 'إلى أين تريد الذهاب؟';

  @override
  String get homeSearchSubtitle => 'احجز مقعدًا في حافلة بين المدن.';

  @override
  String get homeFrom => 'من';

  @override
  String get homeTo => 'إلى';

  @override
  String get homeAlexandria => 'الإسكندرية';

  @override
  String get homeCairo => 'القاهرة';

  @override
  String get homeGiza => 'الجيزة';

  @override
  String get homeToday => 'اليوم';

  @override
  String get homeAnyTime => 'أي وقت';

  @override
  String get homeSearchTrips => 'ابحث عن رحلات';

  @override
  String get homeUpcoming => 'الرحلات القادمة';

  @override
  String get homeSeeAll => 'عرض الكل';

  @override
  String homeDepartureDetails(Object date, Object time) {
    return '$date · $time';
  }

  @override
  String get homeTripStatus => 'قادمة';

  @override
  String get homeTripImageDescription => 'مناظر لمدينتي الإسكندرية والقاهرة';

  @override
  String get homePopularRoutes => 'المسارات الشائعة';

  @override
  String homeSeatsRemaining(int count) {
    return 'متبقي $count مقاعد';
  }

  @override
  String get homeNoUpcomingTrips => 'لا توجد رحلات قادمة حاليًا.';

  @override
  String get homeNoPopularRoutes => 'ستظهر المسارات الشائعة هنا.';

  @override
  String get homeTripsLoadTitle => 'الرحلات غير متاحة مؤقتًا';

  @override
  String get homeTripsLoadError => 'تعذر تحميل الرحلات التجريبية. تحقق من اتصالك وحاول مجددًا.';

  @override
  String get homeRetry => 'إعادة المحاولة';

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
  String get onboardingContinue => 'متابعة';

  @override
  String get onboardingAlreadyAccount => 'المتابعة باستخدام Google';

  @override
  String onboardingPageIndicator(int current, int total) {
    return 'الصفحة $current من $total';
  }
}
