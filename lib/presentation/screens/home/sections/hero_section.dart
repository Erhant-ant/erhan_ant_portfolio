import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      constraints: BoxConstraints(
          minHeight: isMobile ? 500 : MediaQuery.of(context).size.height * 0.8),
      padding: const EdgeInsets.all(AppConstants.space2Xl),
      child: isMobile
          ? _buildMobile(context, theme)
          : _buildDesktop(context, theme),
    );
  }

  Widget _buildDesktop(BuildContext context, ThemeData theme) {
    return Row(
      children: [
        Expanded(flex: 6, child: _buildContent(context, theme)),
        const SizedBox(width: AppConstants.space3Xl),
        Expanded(flex: 4, child: _buildPortrait(context, theme)),
      ],
    );
  }

  Widget _buildMobile(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        _buildContent(context, theme, center: true),
        const SizedBox(height: AppConstants.space2Xl),
        _buildPortrait(context, theme),
      ],
    );
  }

  Widget _buildContent(BuildContext context, ThemeData theme,
      {bool center = false}) {
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text('Merhaba, ben', style: theme.textTheme.bodyMedium),
        const SizedBox(height: AppConstants.spaceSm),
        Text('Erhan Ant', style: theme.textTheme.displayLarge),
        const SizedBox(height: AppConstants.spaceMd),
        Text('Bilgisayar Muhendisligi Ogrencisi',
            style: theme.textTheme.displaySmall),
        const SizedBox(height: AppConstants.spaceMd),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spaceMd, vertical: AppConstants.spaceSm),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusFull),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search, size: 14, color: theme.colorScheme.secondary),
              const SizedBox(width: AppConstants.spaceSm),
              Text('Su anda ogreniyor ve uretiyor',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.secondary)),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spaceLg),
        Text(
          'Flutter ve modern web teknolojileri uzerine calisiyor, acik kaynak projelere katki sagliyor ve yazilim muhendisligi temellerini guclendiriyorum.',
          style: theme.textTheme.bodyLarge,
          textAlign: center ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: AppConstants.spaceXl),
        Wrap(
          spacing: AppConstants.spaceMd,
          children: [
            ElevatedButton.icon(
              onPressed: () => context.go('/projects'),
              icon: const Icon(Icons.folder_open, size: 18),
              label: const Text('Projelerimi Gor'),
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/about'),
              icon: const Icon(Icons.person, size: 18),
              label: const Text('Hakkimda'),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spaceLg),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: const Icon(Icons.code, size: 22),
                onPressed: () => launchUrl(Uri.parse('https://github.com'))),
            IconButton(
                icon: const Icon(Icons.business, size: 22),
                onPressed: () => launchUrl(Uri.parse('https://linkedin.com'))),
            IconButton(
                icon: const Icon(Icons.email, size: 22),
                onPressed: () => launchUrl(Uri.parse('mailto:test@test.com'))),
          ],
        ),
      ],
    );
  }

  Widget _buildPortrait(BuildContext context, ThemeData theme) {
    return Container(
      width: Responsive.isMobile(context)
          ? AppConstants.heroPortraitMaxWidthMobile
          : AppConstants.heroPortraitMaxWidth,
      // Yüksekliği otomatik, aspect ratio koruyarak
      constraints: const BoxConstraints(
        maxHeight: 450,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        child: Image.asset(
          'assets/images/image.png',
          fit: BoxFit.contain, // Şeffaf alanları koru
          errorBuilder: (context, error, stackTrace) {
            // Fotoğraf yoksa placeholder
            return Container(
              height: AppConstants.heroPortraitMaxWidth * 4 / 3,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppConstants.radiusLg),
                border: Border.all(color: theme.colorScheme.outline),
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: theme.colorScheme.onSurface.withOpacity(0.2),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
