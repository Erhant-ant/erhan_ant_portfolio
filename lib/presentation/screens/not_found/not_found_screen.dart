import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/router/app_router.dart';
import '../../widgets/layout/app_footer.dart';
import '../../widgets/layout/app_scaffold.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      body: PageScrollWrapper(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.space2Xl,
          vertical: 64,
        ),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 120,
                color: theme.colorScheme.secondary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: AppConstants.space2Xl),
              Text(
                '404',
                style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(height: AppConstants.spaceMd),
              Text(
                localized(
                  'Oops! Page not found.',
                  'Hoppala! Sayfa bulunamadı.',
                ),
                style: theme.textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spaceLg),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Text(
                  localized(
                    'The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.',
                    'Aradığınız sayfa kaldırılmış, adı değiştirilmiş veya geçici olarak kullanım dışı olabilir.',
                  ),
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppConstants.space3Xl),
              ElevatedButton.icon(
                onPressed: () => context.go(AppRoutes.home),
                icon: const Icon(Icons.home),
                label: Text(
                  localized('Back to Home', 'Ana Sayfaya Dön'),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.space2Xl,
                    vertical: AppConstants.spaceMd,
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ],
      ),
    );
  }
}
