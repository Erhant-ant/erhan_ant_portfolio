import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';

class ContactPreviewSection extends StatelessWidget {
  const ContactPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200
            ? (MediaQuery.of(context).size.width - 1200) / 2
            : 24,
        vertical: AppConstants.space3Xl,
      ),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Iletisim', style: theme.textTheme.displayMedium),
            const SizedBox(height: AppConstants.spaceLg),
            Text(
              'Bir proje fikriniz mi var veya sadece merhaba demek mi istiyorsunuz?',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spaceXl),
            ElevatedButton.icon(
              onPressed: () => launchUrl(Uri.parse('mailto:erhan@example.com')),
              icon: const Icon(Icons.email, size: 18),
              label: const Text('E-posta Gonder'),
            ),
            const SizedBox(height: AppConstants.spaceMd),
            TextButton(
              onPressed: () => context.go('/contact'),
              child: const Text('Diger Iletisim Kanallari'),
            ),
          ],
        ),
      ),
    );
  }
}
