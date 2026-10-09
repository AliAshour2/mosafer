import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appLocaleProvider =
    NotifierProvider<AppLocaleController, Locale>(AppLocaleController.new);

class AppLocaleController extends Notifier<Locale> {
  @override
  Locale build() => const Locale('ar');

  void toggle() {
    state =
        state.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
  }
}
