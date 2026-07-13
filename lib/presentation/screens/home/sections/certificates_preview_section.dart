import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';

class CertificatesPreviewSection extends StatelessWidget {
  const CertificatesPreviewSection({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sertifikalar', style: theme.textTheme.displayMedium),
            const SizedBox(height: AppConstants.space2Xl),
            _buildEmptyState(context),
            const SizedBox(height: AppConstants.spaceLg),
            Center(
              child: TextButton(
                onPressed: () => context.go('/certificates'),
                child: const Text('Tum Sertifikalari Gor'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.space2Xl),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.school,
                size: 40,
                color: theme.colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: AppConstants.spaceMd),
              Text(
                'Sertifikalar yakinda eklenecek',
                style: theme.textTheme.bodyLarge?.copyWith(
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
