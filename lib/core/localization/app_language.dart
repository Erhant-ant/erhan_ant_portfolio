import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { english, turkish }

class AppLanguageController extends ValueNotifier<AppLanguage> {
  AppLanguageController() : super(AppLanguage.english);

  static const _languageKey = 'app_language';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<void> load() async {
    final savedLanguage = await _preferences.getString(_languageKey);
    value = savedLanguage == AppLanguage.turkish.name
        ? AppLanguage.turkish
        : AppLanguage.english;
  }

  void setLanguage(AppLanguage language) {
    value = language;
    _preferences.setString(_languageKey, language.name);
  }
}

final appLanguageController = AppLanguageController();

String localized(String english, String turkish) {
  return appLanguageController.value == AppLanguage.english ? english : turkish;
}
