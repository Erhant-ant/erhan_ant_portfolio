import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_language.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/responsive.dart';

class FeaturedProjectSection extends StatelessWidget {
  const FeaturedProjectSection({super.key});

  Future<void> _openRepository(BuildContext context) async {
    final opened = await launchUrl(
      Uri.parse('https://github.com/Erhant-ant/it_support_ticket_tracker'),
      webOnlyWindowName: '_blank',
    );

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localized('The link could not be opened.', 'Bağlantı açılamadı.'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.pagePadding(context),
        vertical: AppConstants.space3Xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF131B2A) : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: primary.withValues(alpha: 0.2), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: primary.withValues(alpha: 0.1),
                  blurRadius: 40,
                  spreadRadius: 5,
                )
              ]
            ),
            child: Padding(
              padding: EdgeInsets.all(
                isMobile ? AppConstants.spaceLg : AppConstants.space3Xl,
              ),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _ProjectVisual(),
                        const SizedBox(height: AppConstants.space2Xl),
                        _FeaturedProjectContent(onOpenRepository: _openRepository),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(flex: 11, child: _ProjectVisual()),
                        const SizedBox(width: 48),
                        Expanded(
                          flex: 10,
                          child: _FeaturedProjectContent(
                            onOpenRepository: _openRepository,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectVisual extends StatelessWidget {
  const _ProjectVisual();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return AspectRatio(
      aspectRatio: 16 / 11,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Glow Frame
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(16, 16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: primary.withValues(alpha: 0.4), width: 2),
                  boxShadow: [
                    BoxShadow(color: primary.withValues(alpha: 0.1), blurRadius: 20)
                  ]
                ),
              ),
            ),
          ),
          // Main Image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: theme.colorScheme.outline),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/supportdesk_dashboard.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      semanticLabel: 'SupportDesk dashboard preview',
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: theme.colorScheme.surface,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.dashboard_customize_rounded,
                            size: 64,
                            color: primary,
                          ),
                        );
                      },
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                        ),
                      ),
                    ),
                    Positioned(
                      left: AppConstants.spaceLg,
                      right: AppConstants.spaceLg,
                      bottom: AppConstants.spaceLg,
                      child: Text(
                        localized(
                          'A scalable workspace for support teams.',
                          'Destek ekipleri için ölçeklenebilir bir çalışma alanı.',
                        ),
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: AppConstants.spaceLg,
            left: AppConstants.spaceLg,
            child: _ProjectTypeLabel(color: primary),
          ),
        ],
      ),
    );
  }
}

class _ProjectTypeLabel extends StatelessWidget {
  const _ProjectTypeLabel({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 10)
        ]
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            'FULL-STACK APP',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProjectContent extends StatelessWidget {
  const _FeaturedProjectContent({required this.onOpenRepository});

  final Future<void> Function(BuildContext context) onOpenRepository;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localized('Featured Build', 'Öne Çıkan Uygulama').toUpperCase(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: primary,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: AppConstants.spaceSm),
        Text('SupportDesk', style: theme.textTheme.displayMedium),
        const SizedBox(height: AppConstants.spaceMd),
        Text(
          localized(
            'A bilingual IT support ticket tracker that turns scattered requests into a clear, manageable workflow. Built to demonstrate solid architecture and UI principles.',
            'Dağınık IT destek taleplerini net ve yönetilebilir bir iş akışına dönüştüren iki dilli ticket takip uygulaması. Sağlam mimari ve UI prensiplerini sergilemek için geliştirildi.',
          ),
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        const SizedBox(height: AppConstants.spaceXl),
        Wrap(
          spacing: AppConstants.spaceSm,
          runSpacing: AppConstants.spaceSm,
          children: [
            _Capability(label: localized('Bilingual Support', 'İki dilli destek'), icon: Icons.language_rounded),
            _Capability(label: localized('Workflow Board', 'İş akışı panosu'), icon: Icons.view_kanban_rounded),
            _Capability(label: localized('SLA Tracking', 'SLA takibi'), icon: Icons.timer_rounded),
          ],
        ),
        const SizedBox(height: AppConstants.spaceXl),
        Wrap(
          spacing: AppConstants.spaceMd,
          runSpacing: AppConstants.spaceSm,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                context.go(AppRoutes.projects);
              },
              icon: const Icon(Icons.rocket_launch_rounded),
              label: Text(localized('See All Projects', 'Tüm Projeleri Gör')),
            ),
            OutlinedButton.icon(
              onPressed: () => onOpenRepository(context),
              icon: const Icon(Icons.code_rounded),
              label: Text(localized('View Source', 'Kaynağı İncele')),
            ),
          ],
        ),
      ],
    );
  }
}

class _Capability extends StatelessWidget {
  const _Capability({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
        border: Border.all(color: primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.9)
            ),
          ),
        ],
      ),
    );
  }
}