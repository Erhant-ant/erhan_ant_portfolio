import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/providers/theme_controller.dart';
import '../../../core/utils/responsive.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.body, this.pageTitleBuilder});

  final Widget body;
  final String Function()? pageTitleBuilder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: appLanguageController,
      builder: (context, language, child) {
        final theme = Theme.of(context);
        final isMobile = Responsive.isMobile(context);

        return Title(
          title: pageTitleBuilder?.call() ?? AppConstants.appName,
          color: theme.colorScheme.primary,
          child: Scaffold(
          appBar: AppBar(
            toolbarHeight: AppConstants.headerHeight,
            titleSpacing: Responsive.pagePadding(context),
            title: TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: theme.colorScheme.onSurface,
              ),
              child: Text(
                'EA',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            actions: [
              if (!isMobile) ...[
                _HeaderLink(label: localized('About', 'Hakkimda'), route: '/about'),
                _HeaderLink(
                  label: localized('Projects', 'Projeler'),
                  route: '/projects',
                ),
                _HeaderLink(
                  label: localized('Learning', 'Egitimler'),
                  route: '/certificates',
                ),
                const _HeaderLink(label: 'CV', route: '/cv'),
                _HeaderLink(
                  label: localized('Contact', 'Iletisim'),
                  route: '/contact',
                ),
              ],
              PopupMenuButton<AppLanguage>(
                tooltip: localized('Language', 'Dil'),
                icon: const Icon(Icons.language_outlined),
                onSelected: appLanguageController.setLanguage,
                itemBuilder: (context) {
                  return [
                    CheckedPopupMenuItem(
                      value: AppLanguage.english,
                      checked: language == AppLanguage.english,
                      child: const Text('English'),
                    ),
                    CheckedPopupMenuItem(
                      value: AppLanguage.turkish,
                      checked: language == AppLanguage.turkish,
                      child: const Text('Turkce'),
                    ),
                  ];
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: Responsive.pagePadding(context) - AppConstants.spaceSm,
                ),
                child: ValueListenableBuilder<ThemeMode>(
                  valueListenable: themeController,
                  builder: (context, themeMode, child) {
                    final isDark = themeMode == ThemeMode.dark;

                    return IconButton(
                      tooltip: isDark
                          ? localized('Light theme', 'Aydinlik tema')
                          : localized('Dark theme', 'Koyu tema'),
                      onPressed: themeController.toggle,
                      icon: Icon(
                        isDark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          drawer: isMobile ? const _MobileMenu() : null,
            body: KeyedSubtree(
              key: ValueKey(language),
              child: body,
            ),
          ),
        );
      },
    );
  }
}

class _HeaderLink extends StatelessWidget {
  const _HeaderLink({required this.label, required this.route});

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == route;

    return TextButton(
      onPressed: () {
        if (!isActive) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(route, (route) => route.isFirst);
        }
      },
      style: TextButton.styleFrom(
        foregroundColor: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface,
        textStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      child: Text(label),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  const _MobileMenu();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.spaceLg),
              child: Text('Erhan Ant', style: theme.textTheme.displaySmall),
            ),
            const Divider(),
            _MobileMenuItem(
              icon: Icons.home_outlined,
              label: localized('Home', 'Ana Sayfa'),
              route: '/',
            ),
            _MobileMenuItem(
              icon: Icons.person_outline,
              label: localized('About', 'Hakkimda'),
              route: '/about',
            ),
            _MobileMenuItem(
              icon: Icons.folder_outlined,
              label: localized('Projects', 'Projeler'),
              route: '/projects',
            ),
            _MobileMenuItem(
              icon: Icons.school_outlined,
              label: localized('Learning', 'Egitimler'),
              route: '/certificates',
            ),
            _MobileMenuItem(
              icon: Icons.forum_outlined,
              label: localized('Contact', 'Iletisim'),
              route: '/contact',
            ),
            _MobileMenuItem(
              icon: Icons.description_outlined,
              label: 'CV',
              route: '/cv',
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatelessWidget {
  const _MobileMenuItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == route;

    return ListTile(
      selected: isActive,
      selectedColor: theme.colorScheme.primary,
      leading: Icon(icon),
      title: Text(
        label,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();

        if (!isActive) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(route, (route) => route.isFirst);
        }
      },
    );
  }
}
