import 'package:flutter/material.dart';

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
                localized('Let\'s Connect', 'Baglanti Kuralim'),
                style: theme.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spaceMd),
              Text(
                localized(
                  'Follow my current work through GitHub and LinkedIn.',
                  'Guncel calismalarimi GitHub ve LinkedIn uzerinden takip edebilirsin.',
                ),
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spaceXl),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.contact);
                },
                icon: const Icon(Icons.forum_outlined),
                label: Text(localized('Contact Details', 'Iletisim Bilgileri')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
