import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/utils/responsive.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  const AppScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppConstants.headerHeight),
        child: const _AppHeader(),
      ),
      body: body,
      drawer: isMobile ? const _MobileDrawer() : null,
    );
  }
}

class _AppHeader extends ConsumerWidget {
  const _AppHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      height: AppConstants.headerHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceLg),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
            bottom:
                BorderSide(color: theme.colorScheme.outline.withOpacity(0.5))),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/'),
            child: Text('EA',
                style: theme.textTheme.displaySmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ),
          const Spacer(),
          if (!isMobile) ...[
            _NavLink('Hakkimda', '/about'),
            _NavLink('Projeler', '/projects'),
            _NavLink('Sertifikalar', '/certificates'),
            _NavLink('Blog', '/blog'),
            _NavLink('CV', '/cv'),
            _NavLink('Iletisim', '/contact'),
          ],
          IconButton(
            icon: Icon(
                ref.watch(themeModeProvider) == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
                size: 20),
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
          ),
          TextButton(
            onPressed: () => ref.read(localeProvider.notifier).toggle(),
            child: Text(ref.watch(localeProvider).languageCode.toUpperCase()),
          ),
          if (isMobile)
            Builder(
                builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, size: 24),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    )),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String route;
  const _NavLink(this.label, this.route);

  @override
  Widget build(BuildContext context) {
    final isActive = GoRouterState.of(context).matchedLocation == route;
    return TextButton(
      onPressed: () => context.go(route),
      style: TextButton.styleFrom(
        foregroundColor: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
      ),
      child: Text(label),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer();

  @override
  Widget build(BuildContext context) {
    final routes = [
      ('Ana Sayfa', '/'),
      ('Hakkimda', '/about'),
      ('Projeler', '/projects'),
      ('Sertifikalar', '/certificates'),
      ('Blog', '/blog'),
      ('CV', '/cv'),
      ('Iletisim', '/contact'),
    ];

    return Drawer(
      child: SafeArea(
        child: Column(
          children: routes
              .map((r) => ListTile(
                    title: Text(r.$1),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(r.$2);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
