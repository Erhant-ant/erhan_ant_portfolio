import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_language.dart';
import '../../../../core/router/app_router.dart';

class ContactPreviewSection extends StatelessWidget {
  const ContactPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final accent = theme.colorScheme.secondary;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary.withValues(alpha: isDark ? 0.15 : 0.08),
            theme.colorScheme.surface,
            accent.withValues(alpha: isDark ? 0.15 : 0.08),
          ],
        ),
        border: Border.symmetric(
          horizontal: BorderSide(color: primary.withValues(alpha: 0.2)),
        )
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceLg,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: primary.withValues(alpha: 0.4), width: 2),
                  boxShadow: [
                    BoxShadow(color: primary.withValues(alpha: 0.2), blurRadius: 30)
                  ]
                ),
                child: Icon(Icons.rocket_launch_rounded, color: primary, size: 30),
              ),
              const SizedBox(height: AppConstants.spaceLg),
              Text(
                localized('Ready to initialize?', 'Sistemi başlatmaya hazır mıyız?'),
                style: theme.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spaceMd),
              Text(
                localized(
                  'Looking for a developer to bring your game concept or software project to life? Let\'s talk.',
                  'Oyun konseptini veya yazılım projeni hayata geçirecek bir geliştirici mi arıyorsun? Konuşalım.',
                ),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spaceXl),
              ElevatedButton.icon(
                onPressed: () {
                  context.go(AppRoutes.contact);
                },
                icon: const Icon(Icons.forum_rounded),
                label: Text(localized('Initialize Contact', 'İletişime Geç')),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}