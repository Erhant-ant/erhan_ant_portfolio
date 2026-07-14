import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/common/fade_in_section.dart';
import '../../widgets/layout/app_scaffold.dart';
import 'sections/hero_section.dart';
import 'sections/current_focus_section.dart';
import 'sections/about_preview_section.dart';
import 'sections/featured_projects_section.dart';
import 'sections/certificates_preview_section.dart';
import 'sections/latest_articles_section.dart';
import 'sections/contact_preview_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroSection(),
            FadeInSection(
              delay: const Duration(milliseconds: 100),
              child: const CurrentFocusSection(),
            ),
            FadeInSection(
              delay: const Duration(milliseconds: 200),
              child: const AboutPreviewSection(),
            ),
            FadeInSection(
              delay: const Duration(milliseconds: 300),
              child: const FeaturedProjectsSection(),
            ),
            FadeInSection(
              delay: const Duration(milliseconds: 400),
              child: const CertificatesPreviewSection(),
            ),
            FadeInSection(
              delay: const Duration(milliseconds: 500),
              child: const LatestArticlesSection(),
            ),
            FadeInSection(
              delay: const Duration(milliseconds: 600),
              child: const ContactPreviewSection(),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
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
