import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_language.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final heroMinHeight =
        MediaQuery.sizeOf(context).height - AppConstants.headerHeight;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        Responsive.pagePadding(context),
        AppConstants.spaceLg,
        Responsive.pagePadding(context),
        AppConstants.space3Xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: _HeroFrame(
            minHeight: isMobile ? null : heroMinHeight - AppConstants.spaceLg,
            isMobile: isMobile,
          ),
        ),
      ),
    );
  }
}

class _HeroFrame extends StatelessWidget {
  const _HeroFrame({required this.minHeight, required this.isMobile});

  final double? minHeight;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accent = theme.colorScheme.secondary;
    final frameBackground = isDark
        ? const Color(0xFF101417)
        : const Color(0xFFF1F5F6);

    return Container(
      constraints: BoxConstraints(minHeight: minHeight ?? 0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: frameBackground,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -90,
            child: _AccentOrb(color: accent, size: 320),
          ),
          Positioned(
            bottom: -160,
            left: -110,
            child: _AccentOrb(color: accent, size: 300),
          ),
          Positioned(
            top: 28,
            right: 32,
            child: Text(
              'EA / 2026',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.42),
                fontWeight: FontWeight.w700,
                letterSpacing: 1.8,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isMobile ? AppConstants.spaceLg : 56),
            child: isMobile
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeroContent(),
                      SizedBox(height: AppConstants.space2Xl),
                      Center(child: SizedBox(width: 290, child: _ProfilePanel())),
                    ],
                  )
                : const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 12, child: _HeroContent()),
                      SizedBox(width: AppConstants.space3Xl),
                      Expanded(flex: 9, child: _ProfilePanel()),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(
          icon: Icons.auto_awesome_outlined,
          label: localized('Portfolio / 2026', 'Portfolyo / 2026'),
        ),
        const SizedBox(height: AppConstants.spaceLg),
        Text(
          localized('Technology,\nwith purpose.', 'Teknoloji,\namacla.'),
          style: theme.textTheme.displayMedium?.copyWith(
            fontSize: 44,
            fontWeight: FontWeight.w800,
            height: 1.02,
            letterSpacing: -1.4,
          ),
        ),
        const SizedBox(height: AppConstants.spaceMd),
        Text.rich(
          TextSpan(
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            children: [
              const TextSpan(text: 'Erhan Ant'),
              TextSpan(text: '.', style: TextStyle(color: accent)),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spaceLg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            localized(
              'I build practical software projects while developing skills in IT support, systems, and modern web development.',
              'IT destek, sistemler ve modern web gelistirme alanlarinda becerilerimi gelistirirken pratik yazilim projeleri uretiyorum.',
            ),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.78),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spaceXl),
        Wrap(
          spacing: AppConstants.spaceSm,
          runSpacing: AppConstants.spaceSm,
          children: [
            _SkillPill(label: 'Flutter', color: accent),
            _SkillPill(label: 'IT Support', color: accent),
            _SkillPill(label: 'SQL', color: accent),
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
              label: Text(localized('Explore Projects', 'Projeleri Kesfet')),
            ),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.about);
              },
              icon: const Icon(Icons.person_outline),
              label: Text(localized('About Me', 'Hakkimda')),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spaceLg),
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.certificates);
          },
          icon: const Icon(Icons.school_outlined),
          label: Text(localized('View learning journey', 'Ogrenme yolculugumu gor')),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.secondary),
        const SizedBox(width: AppConstants.spaceSm),
        Text(
          label.toUpperCase(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
      ],
    );
  }
}

class _SkillPill extends StatelessWidget {
  const _SkillPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceMd,
        vertical: AppConstants.spaceSm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.28)),
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ProfilePanel extends StatelessWidget {
  const _ProfilePanel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    return AspectRatio(
      aspectRatio: 0.82,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: const Offset(12, 12),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: accent.withValues(alpha: 0.7)),
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                'assets/images/profile.jpeg',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                semanticLabel: 'Portrait of Erhan Ant',
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: theme.colorScheme.surface,
                    child: Icon(
                      Icons.person_outline,
                      size: 72,
                      color: accent,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: -18,
            left: -18,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spaceMd,
                vertical: AppConstants.spaceSm,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                border: Border.all(color: theme.colorScheme.outline),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.14),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bolt_outlined, size: 18, color: accent),
                  const SizedBox(width: AppConstants.spaceSm),
                  Text(
                    localized('Building in public', 'Ureterek ogreniyor'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccentOrb extends StatelessWidget {
  const _AccentOrb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.28), color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}
