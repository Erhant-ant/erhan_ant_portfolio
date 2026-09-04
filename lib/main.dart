import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/constants/app_constants.dart';
import 'core/localization/app_language.dart';
import 'core/providers/theme_controller.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Future.wait([
    themeController.load(),
    appLanguageController.load(),
  ]);

  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: appLanguageController,
      builder: (context, language, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeController,
          builder: (context, themeMode, child) {
            return MaterialApp.router(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              locale: Locale(language == AppLanguage.english ? 'en' : 'tr'),
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              routerConfig: AppRouter.router,
            );
          },
        );
      },
    );
  }
}
