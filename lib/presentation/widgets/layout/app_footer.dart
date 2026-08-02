import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceLg,
        vertical: AppConstants.space2Xl,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(top: BorderSide(color: theme.colorScheme.outline)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            children: [
              Text(
                'EA',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppConstants.spaceSm),
              Text(
                localized(
                  'Learning, building, and growing.',
                  'Ogreniyor, uretiyor, gelisiyor.',
                ),
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppConstants.spaceLg),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: AppConstants.spaceMd,
                runSpacing: AppConstants.spaceSm,
                children: [
                  _FooterLink(label: localized('Home', 'Ana Sayfa'), route: '/'),
                  _FooterLink(label: localized('About', 'Hakkimda'), route: '/about'),
                  _FooterLink(label: localized('Projects', 'Projeler'), route: '/projects'),
                  _FooterLink(label: localized('Learning', 'Egitimler'), route: '/certificates'),
                  const _FooterLink(label: 'CV', route: '/cv'),
                  _FooterLink(label: localized('Contact', 'Iletisim'), route: '/contact'),
                ],
              ),
              const SizedBox(height: AppConstants.spaceLg),
              Text(
                '2026 Erhan Ant. ${localized('All rights reserved.', 'Tum haklari saklidir.')}',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.route});

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => route.isFirst);
      },
      child: Text(label),
    );
  }
}
