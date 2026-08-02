import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_language.dart';

class CurrentFocusSection extends StatelessWidget {
  const CurrentFocusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      color: theme.colorScheme.surface,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localized('Current Focus', 'Su Anki Odak'),
                style: theme.textTheme.displayMedium,
              ),
              const SizedBox(height: AppConstants.space2Xl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 760;
                  final cardWidth = isNarrow
                      ? constraints.maxWidth
                      : (constraints.maxWidth - AppConstants.spaceLg * 2) / 3;

                  return Wrap(
                    spacing: AppConstants.spaceLg,
                    runSpacing: AppConstants.spaceLg,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: _FocusCard(
                          icon: Icons.flutter_dash,
                          title: 'Flutter',
                          description: localized(
                            'Building responsive web and mobile interfaces.',
                            'Responsive web ve mobil arayuzler gelistiriyorum.',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _FocusCard(
                          icon: Icons.computer_outlined,
                          title: localized('IT Support', 'IT Destek'),
                          description: localized(
                            'Developing practical skills in systems, networks, and technical support.',
                            'Sistemler, aglar ve teknik destek alaninda pratik beceriler gelistiriyorum.',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _FocusCard(
                          icon: Icons.psychology_outlined,
                          title: localized('AI Tools', 'Yapay Zeka Araclari'),
                          description: localized(
                            'Learning AI tools and foundational chatbot integrations.',
                            'Yapay zeka araclarini ve temel chatbot entegrasyonlarini ogreniyorum.',
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FocusCard extends StatelessWidget {
  const _FocusCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: theme.colorScheme.secondary),
            const SizedBox(height: AppConstants.spaceLg),
            Text(title, style: theme.textTheme.displaySmall),
            const SizedBox(height: AppConstants.spaceSm),
            Text(description, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
