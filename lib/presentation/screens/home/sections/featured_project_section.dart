import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_language.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/responsive.dart';

class FeaturedProjectSection extends StatelessWidget {
  const FeaturedProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

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
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.space2Xl),
              child: isMobile
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProjectPreview(),
                        SizedBox(height: AppConstants.spaceXl),
                        _FeaturedProjectContent(),
                      ],
                    )
                  : const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 11, child: _ProjectPreview()),
                        SizedBox(width: AppConstants.space2Xl),
                        Expanded(flex: 10, child: _FeaturedProjectContent()),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectPreview extends StatelessWidget {
  const _ProjectPreview();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 16 / 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        child: Image.asset(
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
                color: theme.colorScheme.secondary,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FeaturedProjectContent extends StatelessWidget {
  const _FeaturedProjectContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            localized('Featured Project', 'One Cikan Proje'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spaceLg),
        Text('SupportDesk', style: theme.textTheme.displaySmall),
        const SizedBox(height: AppConstants.spaceMd),
        Text(
          localized(
            'A bilingual IT support ticket management application for small and medium-sized organizations.',
            'Kucuk ve orta olcekli kurumlar icin iki dilli IT destek talep yonetim uygulamasi.',
          ),
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: AppConstants.spaceLg),
        Wrap(
          spacing: AppConstants.spaceSm,
          runSpacing: AppConstants.spaceSm,
          children: const [
            Chip(label: Text('Flutter')),
            Chip(label: Text('Dart')),
            Chip(label: Text('IT Support')),
            Chip(label: Text('Web')),
          ],
        ),
        const SizedBox(height: AppConstants.spaceXl),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.projects);
          },
          icon: const Icon(Icons.folder_open_outlined),
          label: Text(localized('View Project', 'Projeyi Goruntule')),
        ),
      ],
    );
  }
}
