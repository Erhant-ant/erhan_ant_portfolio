import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/router/app_router.dart';
import '../../widgets/layout/app_scaffold.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    return AppScaffold(
      body: PageScrollWrapper(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.space2Xl,
          vertical: 100,
        ),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Glitch Icon Effect
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: accent.withValues(alpha: 0.2), blurRadius: 40, spreadRadius: 10)
                  ]
                ),
                child: Icon(
                  Icons.bug_report_rounded,
                  size: 80,
                  color: accent,
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .fadeIn(duration: 1.seconds)
               .shimmer(duration: 2.seconds, color: accent.withValues(alpha: 0.5)),
               
              const SizedBox(height: AppConstants.space2Xl),
              
              Text(
                '404',
                style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 80,
                  color: accent,
                  letterSpacing: 4,
                ),
              ),
              
              const SizedBox(height: AppConstants.spaceSm),
              
              Text(
                localized(
                  'SYSTEM ERROR / LEVEL NOT FOUND',
                  'SİSTEM HATASI / BÖLÜM BULUNAMADI',
                ),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppConstants.spaceLg),
              
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Text(
                  localized(
                    'The digital coordinate you are trying to reach has either been removed, renamed, or is currently out of bounds.',
                    'Ulaşmaya çalıştığınız dijital koordinat silinmiş, yeniden adlandırılmış veya şu an oyun sınırları dışında olabilir.',
                  ),
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: AppConstants.space3Xl),
              
              ElevatedButton.icon(
                onPressed: () => context.go(AppRoutes.home),
                icon: const Icon(Icons.home_rounded),
                label: Text(
                  localized('Reboot System (Return Home)', 'Sistemi Yeniden Başlat (Ana Sayfa)'),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  backgroundColor: accent,
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