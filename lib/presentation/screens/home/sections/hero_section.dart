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

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: heroMinHeight),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pagePadding(context),
          vertical: AppConstants.space3Xl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppConstants.maxContentWidth,
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _HeroContent(),
                      const SizedBox(height: AppConstants.space2Xl),
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 280),
                          child: const _ProfilePhoto(),
                        ),
                      ),
                    ],
                  )
                : const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _HeroContent()),
                      SizedBox(width: AppConstants.space3Xl),
                      SizedBox(width: 320, child: _ProfilePhoto()),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localized('Hello, I am', 'Merhaba, ben'),
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: AppConstants.spaceSm),
        Text('Erhan Ant', style: theme.textTheme.displayLarge),
        const SizedBox(height: AppConstants.spaceMd),
        Text(
          localized('Technology & Software', 'Teknoloji & Yazılım'),
          style: theme.textTheme.displaySmall,
        ),
        const SizedBox(height: AppConstants.spaceMd),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceMd,
            vertical: AppConstants.spaceSm,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppConstants.radiusFull),
          ),
          child: Text(
            localized('Learning and building', 'Su anda ogreniyor ve uretiyor'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spaceLg),
        Text(
          localized(
            'I enjoy exploring technology, building applications, solving problems, and turning ideas into practical projects. '
                'Here, I share the things I build, learn, and explore along the way.',
            'Teknolojiyi keşfetmeyi, uygulamalar geliştirmeyi, problemleri çözmeyi ve fikirleri pratik projelere dönüştürmeyi seviyorum. '
                'Burada geliştirdiğim, öğrendiğim ve keşfettiğim şeyleri paylaşıyorum.',
          ),
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: AppConstants.spaceXl),
        Wrap(
          spacing: AppConstants.spaceSm,
          runSpacing: AppConstants.spaceSm,
          children: [
            const Chip(label: Text('Flutter')),
            const Chip(label: Text('Firebase')),
            Chip(label: Text(localized('IT Support', 'IT Teknolojileri'))),
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
              icon: const Icon(Icons.folder_open),
              label: Text(localized('View Projects', 'Projelerimi Gor')),
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
        const SizedBox(height: AppConstants.spaceMd),
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.certificates);
          },
          icon: const Icon(Icons.school_outlined),
          label: Text(localized('View Learning', 'Egitimlerimi Gor')),
        ),
      ],
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 0.86,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        child: Image.asset(
          'assets/images/profile.jpeg',
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: theme.colorScheme.surface,
              child: Icon(
                Icons.person_outline,
                size: 72,
                color: theme.colorScheme.secondary,
              ),
            );
          },
        ),
      ),
    );
  }
}
