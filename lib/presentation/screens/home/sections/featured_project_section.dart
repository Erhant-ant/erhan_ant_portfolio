import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            localized('The link could not be opened.', 'Baglanti acilamadi.'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

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
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.surface,
                  accent.withValues(alpha: 0.10),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                isMobile ? AppConstants.spaceLg : AppConstants.space2Xl,
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
                        const SizedBox(width: AppConstants.space3Xl),
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
    final accent = theme.colorScheme.secondary;

    return AspectRatio(
      aspectRatio: 16 / 11,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(10, 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accent.withValues(alpha: 0.65)),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
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
                          Icons.support_agent_outlined,
                          size: 56,
                          color: accent,
                        ),
                      );
                    },
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withValues(alpha: 0.56)],
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppConstants.spaceLg,
                    right: AppConstants.spaceLg,
                    bottom: AppConstants.spaceLg,
                    child: Text(
                      localized(
                        'A practical workspace for IT support teams.',
                        'IT destek ekipleri icin pratik bir calisma alani.',
                      ),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: AppConstants.spaceMd,
            left: AppConstants.spaceMd,
            child: _ProjectTypeLabel(color: accent),
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
        horizontal: AppConstants.spaceSm,
        vertical: AppConstants.spaceXs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      ),
      child: Text(
        'FLUTTER WEB APP',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.9,
        ),
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
    final accent = theme.colorScheme.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localized('Featured Build', 'One Cikan Uygulama').toUpperCase(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: accent,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: AppConstants.spaceSm),
        Text('SupportDesk', style: theme.textTheme.displayMedium),
        const SizedBox(height: AppConstants.spaceMd),
        Text(
          localized(
            'A bilingual IT support ticket tracker that turns scattered requests into a clear, manageable workflow.',
            'Daginik IT destek taleplerini net ve yonetilebilir bir is akisina donusturen iki dilli ticket takip uygulamasi.',
          ),
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: AppConstants.spaceXl),
        Wrap(
          spacing: AppConstants.spaceSm,
          runSpacing: AppConstants.spaceSm,
          children: [
            _Capability(label: localized('Bilingual', 'Iki dilli')),
            _Capability(label: localized('Workflow board', 'Is akisi panosu')),
            _Capability(label: localized('SLA tracking', 'SLA takibi')),
          ],
        ),
        const SizedBox(height: AppConstants.spaceXl),
        Wrap(
          spacing: AppConstants.spaceMd,
          runSpacing: AppConstants.spaceSm,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.projects);
              },
              icon: const Icon(Icons.arrow_outward),
              label: Text(localized('Read the Case Study', 'Vaka Calismasini Oku')),
            ),
            OutlinedButton.icon(
              onPressed: () => onOpenRepository(context),
              icon: const Icon(Icons.code_outlined),
              label: Text(localized('View Source', 'Kaynagi Goruntule')),
            ),
          ],
        ),
      ],
    );
  }
}

class _Capability extends StatelessWidget {
  const _Capability({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceMd,
        vertical: AppConstants.spaceSm,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
