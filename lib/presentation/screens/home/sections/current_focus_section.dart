import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class CurrentFocusSection extends StatelessWidget {
  const CurrentFocusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final focuses = [
      (
        icon: Icons.phone_android,
        title: 'Flutter Web',
        description:
            'Cross-platform uygulama gelistirme ve modern UI paradigmalari',
      ),
      (
        icon: Icons.cloud,
        title: 'Firebase',
        description: 'Backend servisleri ve serverless mimari ogrenimi',
      ),
      (
        icon: Icons.psychology,
        title: 'Yapay Zeka',
        description: 'LLM entegrasyonlari ve prompt engineering calismalari',
      ),
    ];

    return Container(
      width: double.infinity,
      color: theme.colorScheme.surface,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Su An Ne Yapiyorum?',
              style: theme.textTheme.displayMedium,
            ),
            const SizedBox(height: AppConstants.space2Xl),
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 700;
                return isNarrow
                    ? Column(
                        children:
                            focuses.map((f) => _FocusCard(focus: f)).toList(),
                      )
                    : Row(
                        children: focuses
                            .map((f) => Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: focuses.indexOf(f) == 1
                                          ? AppConstants.spaceMd
                                          : 0,
                                    ),
                                    child: _FocusCard(focus: f),
                                  ),
                                ))
                            .toList(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FocusCard extends StatelessWidget {
  final ({IconData icon, String title, String description}) focus;

  const _FocusCard({required this.focus});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(focus.icon, size: 32, color: theme.colorScheme.secondary),
            const SizedBox(height: AppConstants.spaceMd),
            Text(focus.title, style: theme.textTheme.displaySmall),
            const SizedBox(height: AppConstants.spaceSm),
            Text(
              focus.description,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
