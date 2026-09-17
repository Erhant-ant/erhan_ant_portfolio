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
    final accent = theme.colorScheme.secondary;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: isDark ? 0.08 : 0.05),
            theme.colorScheme.surface,
            accent.withValues(alpha: isDark ? 0.06 : 0.03),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceLg,
        vertical: AppConstants.space3Xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.forum_outlined, color: accent, size: 22),
              ),
              const SizedBox(height: AppConstants.spaceLg),
              Text(
                localized('Let\'s Connect', 'Bağlantı Kuralım'),
                style: theme.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spaceMd),
              Text(
                localized(
                  'Follow my current work through GitHub and LinkedIn.',
                  'Güncel çalışmalarımı GitHub ve LinkedIn üzerinden takip edebilirsin.',
                ),
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spaceXl),
              ElevatedButton.icon(
                onPressed: () {
                  context.go(AppRoutes.contact);
                },
                icon: const Icon(Icons.forum_outlined),
                label: Text(localized('Contact Details', 'İletişim Bilgileri')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
