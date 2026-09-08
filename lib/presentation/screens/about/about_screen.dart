import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/layout/app_scaffold.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    return AppScaffold(
      pageTitleBuilder: () =>
          localized('About | Erhan Ant', 'Hakkımda | Erhan Ant'),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pagePadding(context),
          vertical: AppConstants.space3Xl,
        ),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimateList(
                  interval: 100.ms,
                  effects: [
                    FadeEffect(duration: 500.ms, curve: Curves.easeOut),
                    SlideEffect(
                      begin: const Offset(0, 0.05),
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    ),
                  ],
                  children: [
                    // --- Profile Photo ---
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Decorative accent border
                            Positioned.fill(
                              child: Transform.translate(
                                offset: const Offset(8, 8),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: accent.withValues(alpha: 0.6),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Photo
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: accent.withValues(alpha: 0.2),
                                      blurRadius: 28,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: const AssetImage(
                                    'assets/images/profile.jpeg',
                                  ),
                                  backgroundColor: Colors.grey.shade200,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppConstants.space2Xl),

                    Text(
                      localized('A Little About Me', 'Hakkımda'),
                      style: theme.textTheme.displayMedium,
                    ),

                    const SizedBox(height: AppConstants.spaceMd),

                    Text(
                      localized(
                        'I enjoy exploring technology, solving problems, and building practical projects. My interests include IT support, systems, data management, and modern application development. I like learning by building and turning ideas into useful digital experiences.',
                        'Teknolojiyi keşfetmeyi, problemleri çözmeyi ve pratik projeler geliştirmeyi seviyorum. İlgi alanlarım arasında IT destek, sistemler, veri yönetimi ve modern uygulama geliştirme bulunuyor. Üreterek öğrenmeyi ve fikirleri kullanışlı dijital deneyimlere dönüştürmeyi seviyorum.',
                      ),
                      style: theme.textTheme.bodyLarge,
                    ),

                    const SizedBox(height: AppConstants.space2Xl),

                    // --- Future Direction with gradient bg ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppConstants.spaceLg),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            accent.withValues(alpha: 0.08),
                            theme.colorScheme.surface,
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(AppConstants.radiusMd),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.18),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: accent.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.radiusSm,
                                  ),
                                ),
                                child: Icon(
                                  Icons.rocket_launch_outlined,
                                  size: 20,
                                  color: accent,
                                ),
                              ),
                              const SizedBox(width: AppConstants.spaceMd),
                              Text(
                                localized(
                                  'Future Direction',
                                  'Gelecekteki Yönüm',
                                ),
                                style: theme.textTheme.displaySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.spaceMd),
                          Text(
                            localized(
                              'I want to keep learning, building, and exploring different areas of technology while turning ideas into practical projects and meaningful digital experiences.',
                              'Öğrenmeye, üretmeye ve teknolojinin farklı alanlarını keşfetmeye devam ederken fikirleri pratik projelere ve anlamlı dijital deneyimlere dönüştürmek istiyorum.',
                            ),
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppConstants.space2Xl),

                    Text(
                      localized(
                        'Current Focus',
                        'Şu An Odaklandığım Alanlar',
                      ),
                      style: theme.textTheme.displaySmall,
                    ),

                    const SizedBox(height: AppConstants.spaceMd),

                    Wrap(
                      spacing: AppConstants.spaceSm,
                      runSpacing: AppConstants.spaceSm,
                      children: [
                        _FocusPill(
                          label: 'IT Support',
                          icon: Icons.support_agent_outlined,
                          color: accent,
                        ),
                        _FocusPill(
                          label: 'Systems',
                          icon: Icons.desktop_windows_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        _FocusPill(
                          label: 'SQL',
                          icon: Icons.storage_outlined,
                          color: theme.colorScheme.tertiary,
                        ),
                        _FocusPill(
                          label: 'Networking',
                          icon: Icons.lan_outlined,
                          color: accent,
                        ),
                        _FocusPill(
                          label: 'Flutter',
                          icon: Icons.flutter_dash,
                          color: theme.colorScheme.primary,
                        ),
                        _FocusPill(
                          label: localized('AI Tools', 'Yapay Zeka Araçları'),
                          icon: Icons.psychology_outlined,
                          color: theme.colorScheme.tertiary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusPill extends StatelessWidget {
  const _FocusPill({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceMd,
        vertical: AppConstants.spaceSm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
