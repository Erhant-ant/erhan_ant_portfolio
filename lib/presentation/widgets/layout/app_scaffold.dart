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

class _AppFooter extends StatelessWidget {
  const _AppFooter();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.space3Xl,
        horizontal: AppConstants.spaceLg,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.colorScheme.outline),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              Text(
                'EA',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppConstants.spaceMd),
              Text(
                'Professional without pretending.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: AppConstants.spaceLg),
              Wrap(
                spacing: AppConstants.spaceMd,
                runSpacing: AppConstants.spaceSm,
                alignment: WrapAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => context.go('/'),
                      child: const Text('Ana Sayfa')),
                  TextButton(
                      onPressed: () => context.go('/about'),
                      child: const Text('Hakkimda')),
                  TextButton(
                      onPressed: () => context.go('/projects'),
                      child: const Text('Projeler')),
                  TextButton(
                      onPressed: () => context.go('/blog'),
                      child: const Text('Blog')),
                  TextButton(
                      onPressed: () => context.go('/contact'),
                      child: const Text('Iletisim')),
                  TextButton(
                      onPressed: () => context.go('/privacy'),
                      child: const Text('Gizlilik')),
                ],
              ),
              const SizedBox(height: AppConstants.spaceLg),
              Divider(color: theme.colorScheme.outline),
              const SizedBox(height: AppConstants.spaceMd),
              Text(
                '2026 Erhan Ant. Tum haklari saklidir.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: AppConstants.spaceSm),
              Text(
                'Son guncelleme: 14 Temmuz 2026',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
