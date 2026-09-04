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

    return Container(
      width: double.infinity,
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
