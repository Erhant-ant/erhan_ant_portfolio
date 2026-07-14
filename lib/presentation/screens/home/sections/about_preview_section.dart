import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';

class AboutPreviewSection extends StatelessWidget {
  const AboutPreviewSection({super.key});

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
            Text('Hakkımda', style: theme.textTheme.displayMedium),
            const SizedBox(height: AppConstants.spaceLg),
            Text(
              'Yazılım geliştirme ve bilgi teknolojileri '
              'alanlarında kendimi sürekli geliştiren bir geliştiriciyim. '
              'Flutter ile web ve mobil uygulamalar geliştiriyor, backend '
              'teknolojileri, veritabanları ve kurumsal IT sistemleri üzerine '
              'çalışarak gerçek dünya projeleriyle deneyim kazanıyorum.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppConstants.spaceMd),
            Text(
              'Temiz kod, kullanıcı odaklı tasarım ve sürekli öğrenme anlayışını '
              'benimsiyorum. Amacım, güvenilir ve sürdürülebilir yazılımlar '
              'geliştirirken hem yazılım geliştirme hem de bilgi teknolojileri '
              'alanında kendimi sürekli ileriye taşımaktır.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppConstants.spaceLg),
            TextButton.icon(
              onPressed: () => context.go('/about'),
              icon: const Text('Daha Fazla'),
              label: const Icon(Icons.arrow_forward, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
