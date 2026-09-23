import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  // Başlangıç temasını sistem yerine doğrudan modern konseptimiz olan Dark (Koyu) yapıyoruz.
  ThemeController() : super(ThemeMode.dark);

  static const _themeKey = 'theme_mode';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<void> load() async {
    final savedTheme = await _preferences.getString(_themeKey);

    // Eğer kullanıcı daha önce açık temayı (Light) seçip kaydettiyse onu yüklüyoruz.
    if (savedTheme == ThemeMode.light.name) {
      value = ThemeMode.light;
    } else {
      // Eğer daha önce kaydedilmiş bir tercih yoksa (ilk giriş) veya Dark seçilmişse,
      // her zaman Koyu (Dark) temayı varsayılan olarak veriyoruz.
      value = ThemeMode.dark;
    }
  }

  void toggle() {
    // Sadece Dark ve Light arasında kusursuz ikili (binary) geçiş.
    final nextTheme = value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    value = nextTheme;
    _preferences.setString(_themeKey, nextTheme.name);
  }
}

// İŞTE EKSİK OLAN SATIR! (Diğer dosyaların bu sınıfa ulaşmasını sağlayan obje)
final themeController = ThemeController();