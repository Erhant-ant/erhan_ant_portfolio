import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.system);

  static const _themeKey = 'theme_mode';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<void> load() async {
    final savedTheme = await _preferences.getString(_themeKey);

    if (savedTheme == ThemeMode.dark.name) {
      value = ThemeMode.dark;
    } else if (savedTheme == ThemeMode.light.name) {
      value = ThemeMode.light;
    } else {
      value = ThemeMode.system;
    }
  }

  void toggle() {
    final nextTheme = value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    value = nextTheme;
    _preferences.setString(_themeKey, nextTheme.name);
  }
}

final themeController = ThemeController();
