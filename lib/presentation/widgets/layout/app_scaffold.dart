import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/providers/theme_controller.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/seo_service.dart'; // Eklendi
import 'app_footer.dart';

// SEO işlemleri için StatefulWidget'a çevirdik
class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.pageTitleBuilder,
    this.pageDescriptionBuilder, // SEO Description Eklendi
    this.showFooter = true,
  });

  final Widget body;
  final String Function()? pageTitleBuilder;
  final String Function()? pageDescriptionBuilder;
  final bool showFooter;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Sayfa her yüklendiğinde SEO'yu otomatik günceller
    _updateSeo();
  }

  void _updateSeo() {
    final title = widget.pageTitleBuilder?.call() ?? AppConstants.appName;
    // Eğer özel bir açıklama verilmemişse default açıklamayı kullanır
    final description = widget.pageDescriptionBuilder?.call() ?? 
        localized(
          'EANT Studio - Software projects, Game Development, IT support experience, and professional profiles.',
          'EANT Studio - Yazılım projeleri, Oyun Geliştirme, IT destek deneyimi ve profesyonel profiller.',
        );
    
    SeoService.updateMeta(title: title, description: description);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
// ... DOSYANIN GERİ KALANI AYNI KALACAK ...
      valueListenable: appLanguageController,
      builder: (context, language, child) {
        final theme = Theme.of(context);
        final isMobile = Responsive.isMobile(context);
        final primary = theme.colorScheme.primary;

        return Title(
          title: widget.pageTitleBuilder?.call() ?? AppConstants.appName,
          color: primary,
          child: SelectionArea(
            child: Scaffold(
            appBar: AppBar(
              toolbarHeight: AppConstants.headerHeight,
              titleSpacing: Responsive.pagePadding(context),
              title: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.go('/'),
                  // YENİ HARİKA LOGOMUZ BURADA ÇAĞRILIYOR
                  child: const BrandLogo(fontSize: 22, showText: true),
                ),
              ),
              actions: [
                if (!isMobile) ...[
                  _HeaderLink(label: localized('About', 'Hakkımda'), route: '/about'),
                  _HeaderLink(
                    label: localized('Projects', 'Projeler'),
                    route: '/projects',
                  ),
                  _HeaderLink(
                    label: 'Blog', 
                    route: '/blog',
                  ),
                  const _HeaderLink(label: 'CV', route: '/cv'),
                  _HeaderLink(
                    label: localized('Contact', 'İletişim'),
                    route: '/contact',
                  ),
                ],
                const SizedBox(width: AppConstants.spaceSm),
                // Language Dropdown
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                    border: Border.all(color: primary.withValues(alpha: 0.2)),
                  ),
                  child: PopupMenuButton<AppLanguage>(
                    tooltip: localized('Language', 'Dil'),
                    icon: Icon(Icons.language_rounded, size: 18, color: primary),
                    color: theme.colorScheme.surface,
                    position: PopupMenuPosition.under,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
                    ),
                    onSelected: appLanguageController.setLanguage,
                    itemBuilder: (context) {
                      return [
                        CheckedPopupMenuItem(
                          value: AppLanguage.english,
                          checked: language == AppLanguage.english,
                          child: Text('English', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                        ),
                        CheckedPopupMenuItem(
                          value: AppLanguage.turkish,
                          checked: language == AppLanguage.turkish,
                          child: Text('Türkçe', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                        ),
                      ];
                    },
                  ),
                ),
                const SizedBox(width: AppConstants.spaceSm),
                // Theme Toggle
                Padding(
                  padding: EdgeInsets.only(
                    right: Responsive.pagePadding(context) - AppConstants.spaceSm,
                  ),
                  child: ValueListenableBuilder<ThemeMode>(
                    valueListenable: themeController,
                    builder: (context, themeMode, child) {
                      final isDark = themeMode == ThemeMode.dark;
                      final accent = theme.colorScheme.secondary;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                          border: Border.all(color: accent.withValues(alpha: 0.2)),
                        ),
                        child: IconButton(
                          tooltip: isDark
                              ? localized('Light theme', 'Aydınlık tema')
                              : localized('Dark theme', 'Koyu tema'),
                          onPressed: themeController.toggle,
                          icon: Icon(
                            isDark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                            size: 18,
                            color: accent,
                          ),
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
              child: widget.body,
            ),
          ),
        ),
      );
      },
    );
  }
}

class _HeaderLink extends StatefulWidget {
  const _HeaderLink({required this.label, required this.route});

  final String label;
  final String route;

  @override
  State<_HeaderLink> createState() => _HeaderLinkState();
}

class _HeaderLinkState extends State<_HeaderLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPath = GoRouterState.of(context).uri.path;
    final isActive = currentPath == widget.route;
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: TextButton(
          onPressed: () {
            if (!isActive) {
              context.go(widget.route);
            }
          },
          style: TextButton.styleFrom(
            foregroundColor: isActive ? primary : theme.colorScheme.onSurface,
            textStyle: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
            ),
            overlayColor: Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: AppConstants.durationFast,
                curve: Curves.easeOut,
                height: 3,
                width: isActive ? 24 : (_isHovered ? 12 : 0),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: isActive || _isHovered
                      ? [BoxShadow(color: primary.withValues(alpha: 0.5), blurRadius: 6)]
                      : [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  const _MobileMenu();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF0B0F19) : theme.colorScheme.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(AppConstants.spaceLg),
              // YENİ LOGO MOBİL MENÜYE DE EKLENDİ
              child: BrandLogo(fontSize: 24, showText: true),
            ),
            Divider(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
            const SizedBox(height: 8),
            _MobileMenuItem(icon: Icons.dashboard_rounded, label: localized('Home', 'Ana Sayfa'), route: '/'),
            _MobileMenuItem(icon: Icons.person_rounded, label: localized('About', 'Hakkımda'), route: '/about'),
            _MobileMenuItem(icon: Icons.rocket_launch_rounded, label: localized('Projects', 'Projeler'), route: '/projects'),
            _MobileMenuItem(icon: Icons.article_rounded, label: 'Blog', route: '/blog'),
            _MobileMenuItem(icon: Icons.forum_rounded, label: localized('Contact', 'İletişim'), route: '/contact'),
            _MobileMenuItem(icon: Icons.description_rounded, label: 'CV', route: '/cv'),
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
    final currentPath = GoRouterState.of(context).uri.path;
    final isActive = currentPath == route;
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        selected: isActive,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.transparent,
        selectedTileColor: primary.withValues(alpha: 0.1),
        leading: Icon(icon, color: isActive ? primary : theme.colorScheme.onSurface.withValues(alpha: 0.6)),
        title: Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
            color: isActive ? primary : theme.colorScheme.onSurface,
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
          if (!isActive) {
            context.go(route);
          }
        },
      ),
    );
  }
}

class PageScrollWrapper extends StatelessWidget {
  const PageScrollWrapper({
    super.key,
    required this.children,
    this.padding = EdgeInsets.zero,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverList(
            delegate: SliverChildListDelegate(children),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: const AppFooter(),
          ),
        ),
      ],
    );
  }
}

// =========================================================
// YENİ "EANT STUDIO" KAPSÜL LOGO TASARIMI (BRAND LOGO)
// =========================================================
class BrandLogo extends StatelessWidget {
  final double fontSize;
  final bool showText;
  
  const BrandLogo({
    super.key, 
    this.fontSize = 24, 
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final accent = theme.colorScheme.secondary;

    return Container(
      // Logonun tamamını kaplayan şık bir cam kapsül
      padding: EdgeInsets.symmetric(
        horizontal: fontSize * 0.6, 
        vertical: fontSize * 0.3
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131B2A) : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(fontSize), // Tam oval kenarlar
        border: Border.all(
          color: primary.withValues(alpha: 0.3), 
          width: 1.5
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.15), 
            blurRadius: fontSize * 0.8, 
            spreadRadius: 1
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Studio İkonu (Katmanlı Geometrik Şekil)
          Icon(
            Icons.layers_rounded, // Oyun motorları ve mimariyi temsil eder
            color: accent, 
            size: fontSize * 1.2
          ),
          
          if (showText) ...[
            SizedBox(width: fontSize * 0.4),
            
            // 2. Ana Marka: EANT (Gradient & İtalik)
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [primary, accent], 
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'EANT',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: fontSize,
                  letterSpacing: 1.5,
                  fontStyle: FontStyle.italic, 
                  color: Colors.white, // ShaderMask için beyaz kalmalı
                ),
              ),
            ),
            
            SizedBox(width: fontSize * 0.4),
            
            // 3. Ayraç Çizgisi (Neon Divider)
            Container(
              width: 2,
              height: fontSize * 1.1,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(color: primary.withValues(alpha: 0.5), blurRadius: 4)
                ]
              ),
            ),
            
            SizedBox(width: fontSize * 0.4),
            
            // 4. Alt Marka: STUDIO (Geniş aralıklı, sade)
            Text(
              'STUDIO',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: fontSize * 0.65,
                letterSpacing: 3.5, // Geniş harf aralığı kurumsal gösterir
                color: primary,
              ),
            ),
          ]
        ],
      ),
    );
  }
}