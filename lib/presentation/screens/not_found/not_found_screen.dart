import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/layout/app_scaffold.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.space3Xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '404',
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: 120,
                    fontWeight: FontWeight.w200,
                    color: theme.colorScheme.onSurface.withOpacity(0.1),
                  ),
                ),
                const SizedBox(height: AppConstants.spaceLg),
                Text(
                  'Sayfa Bulunamadi',
                  style: theme.textTheme.displayMedium,
                ),
                const SizedBox(height: AppConstants.spaceMd),
                Text(
                  'Aradiginiz sayfa mevcut degil veya tasinmis olabilir.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.space2Xl),
                ElevatedButton.icon(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.home, size: 18),
                  label: const Text('Ana Sayfaya Don'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
