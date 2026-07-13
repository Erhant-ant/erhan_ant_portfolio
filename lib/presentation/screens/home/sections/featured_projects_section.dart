import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            Text('One Cikan Projeler', style: theme.textTheme.displayMedium),
            const SizedBox(height: AppConstants.space2Xl),
            _buildEmptyState(context),
            const SizedBox(height: AppConstants.space2Xl),
            Center(
              child: OutlinedButton.icon(
                onPressed: () => context.go('/projects'),
                icon: const Icon(Icons.folder, size: 18),
                label: const Text('Tum Projeler'),
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
        padding: const EdgeInsets.all(AppConstants.space3Xl),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.folder_open,
                size: 48,
                color: theme.colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: AppConstants.spaceMd),
              Text(
                'Projeler yakinda eklenecek',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: AppConstants.spaceSm),
              Text(
                'Su anda uzerinde calistigim projeleri burada gorebilirsiniz.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
