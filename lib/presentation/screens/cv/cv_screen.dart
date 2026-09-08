import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/cv_downloader.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/layout/app_scaffold.dart';

class CvScreen extends StatelessWidget {
  const CvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      pageTitleBuilder: () => 'CV | Erhan Ant',
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pagePadding(context),
          vertical: AppConstants.space3Xl,
        ),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimateList(
                  interval: 80.ms,
                  effects: [
                    FadeEffect(duration: 500.ms, curve: Curves.easeOut),
                    SlideEffect(
                      begin: const Offset(0, 0.05),
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    ),
                  ],
                  children: [
                    // --- Header ---
                    Text(
                      localized('CV Summary', 'CV Özeti'),
                      style: theme.textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Text(
                      localized(
                        'Erhan Ant - IT & Software',
                        'Erhan Ant - IT & Yazılım',
                      ),
                      style: theme.textTheme.displaySmall,
                    ),

                    // --- Profile ---
                    const SizedBox(height: AppConstants.space2Xl),
                    _SectionHeader(
                      icon: Icons.person_outline,
                      title: localized('Profile', 'Profil'),
                    ),
                    const SizedBox(height: AppConstants.spaceSm),
                    Text(
                      localized(
                        'Passionate about technology, software development, and practical problem solving. Interested in IT support, systems, data management, and modern application development, with a focus on learning, building, and turning ideas into useful digital experiences.',
                        'Teknoloji, yazılım geliştirme ve pratik problem çözmeye ilgi duyuyorum. IT destek, sistemler, veri yönetimi ve modern uygulama geliştirme alanlarına odaklanıyor; öğrenmeye, üretmeye ve fikirleri kullanışlı dijital deneyimlere dönüştürmeye önem veriyorum.',
                      ),
                      style: theme.textTheme.bodyLarge,
                    ),

                    // --- Core Skills ---
                    const SizedBox(height: AppConstants.space2Xl),
                    _SectionHeader(
                      icon: Icons.auto_awesome_outlined,
                      title: localized('Core Skills', 'Temel Yetkinlikler'),
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Wrap(
                      spacing: AppConstants.spaceSm,
                      runSpacing: AppConstants.spaceSm,
                      children: [
                        _SkillPill(
                          label: 'IT Support',
                          icon: Icons.support_agent_outlined,
                          color: theme.colorScheme.secondary,
                        ),
                        _SkillPill(
                          label: 'Windows Systems',
                          icon: Icons.desktop_windows_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        _SkillPill(
                          label: 'Hardware Support',
                          icon: Icons.memory_outlined,
                          color: theme.colorScheme.tertiary,
                        ),
                        _SkillPill(
                          label: 'SQL',
                          icon: Icons.storage_outlined,
                          color: theme.colorScheme.secondary,
                        ),
                        _SkillPill(
                          label: 'Networking',
                          icon: Icons.lan_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        _SkillPill(
                          label: 'Java',
                          icon: Icons.code_outlined,
                          color: theme.colorScheme.tertiary,
                        ),
                        _SkillPill(
                          label: 'MS Office',
                          icon: Icons.business_center_outlined,
                          color: theme.colorScheme.secondary,
                        ),
                      ],
                    ),

                    // --- Completed Certification ---
                    const SizedBox(height: AppConstants.space2Xl),
                    _SectionHeader(
                      icon: Icons.verified_outlined,
                      title: localized(
                        'Completed Certification',
                        'Tamamlanan Sertifika',
                      ),
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    _TimelineCard(
                      icon: Icons.verified_outlined,
                      accentColor: theme.colorScheme.secondary,
                      title:
                          'Google IT Support Professional Certificate',
                      subtitle: 'Coursera',
                      badge: localized('Completed', 'Tamamlandı'),
                    ),

                    // --- Ongoing Learning ---
                    const SizedBox(height: AppConstants.space2Xl),
                    _SectionHeader(
                      icon: Icons.school_outlined,
                      title: localized(
                        'Ongoing Learning',
                        'Devam Eden Eğitimler',
                      ),
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Wrap(
                      spacing: AppConstants.spaceSm,
                      runSpacing: AppConstants.spaceSm,
                      children: [
                        _SkillPill(
                          label: 'Siemens TIA Portal',
                          icon: Icons.precision_manufacturing_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        _SkillPill(
                          label: 'Microsoft Data Analyst',
                          icon: Icons.bar_chart_outlined,
                          color: theme.colorScheme.secondary,
                        ),
                        _SkillPill(
                          label: 'Microsoft 365 Fundamentals',
                          icon: Icons.cloud_outlined,
                          color: theme.colorScheme.tertiary,
                        ),
                        _SkillPill(
                          label: 'SQL Fundamentals',
                          icon: Icons.storage_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        _SkillPill(
                          label: 'Flutter',
                          icon: Icons.flutter_dash,
                          color: theme.colorScheme.secondary,
                        ),
                        _SkillPill(
                          label: 'Firebase',
                          icon: Icons.local_fire_department_outlined,
                          color: theme.colorScheme.tertiary,
                        ),
                        _SkillPill(
                          label: localized('AI Tools', 'Yapay Zeka Araçları'),
                          icon: Icons.psychology_outlined,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),

                    // --- Education ---
                    const SizedBox(height: AppConstants.space2Xl),
                    _SectionHeader(
                      icon: Icons.account_balance_outlined,
                      title: localized('Education', 'Eğitim'),
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    _TimelineCard(
                      icon: Icons.school_outlined,
                      accentColor: theme.colorScheme.primary,
                      title: 'Passaic County Community College',
                      subtitle: localized(
                        'Associate Degree in Computer Science, Ongoing',
                        'Bilgisayar Bilimleri Ön Lisans Derecesi, Devam ',
                      ),
                    ),
                    const SizedBox(height: AppConstants.spaceSm),
                    _TimelineCard(
                      icon: Icons.account_balance_outlined,
                      accentColor: theme.colorScheme.tertiary,
                      title: 'Izmir Katip Celebi University',
                      subtitle: localized(
                        'Bachelor\'s Degree in Business Administration, 2018',
                        'İşletme Lisans Programı, 2018',
                      ),
                    ),

                    // --- Experience ---
                    const SizedBox(height: AppConstants.space2Xl),
                    _SectionHeader(
                      icon: Icons.work_outline,
                      title: localized('Experience', 'Deneyim'),
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    _TimelineCard(
                      icon: Icons.inventory_2_outlined,
                      accentColor: theme.colorScheme.secondary,
                      title: 'Amazon Fulfillment Center',
                      subtitle: localized(
                        'Warehouse Associate, 2024 - 2025. Supported daily operations, digital process tracking, inventory control, and shipping workflows.',
                        'Warehouse Associate, 2024 - 2025. Günlük operasyonlar, dijital süreç takibi, stok kontrolü ve sevkiyat iş akışları içinde görev aldım.',
                      ),
                    ),

                    // --- Action Buttons ---
                    const SizedBox(height: AppConstants.space2Xl),
                    Wrap(
                      spacing: AppConstants.spaceMd,
                      runSpacing: AppConstants.spaceSm,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => downloadCvFile(),
                          icon: const Icon(Icons.download_outlined),
                          label: Text(
                            localized('Download CV PDF', 'CV PDF Indir'),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            context.go(AppRoutes.contact);
                          },
                          icon: const Icon(Icons.forum_outlined),
                          label: Text(
                            localized('Contact Details', 'İletişim Bilgileri'),
                          ),
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

/// Section header with an icon and colored title line
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
          ),
          child: Icon(icon, size: 20, color: accent),
        ),
        const SizedBox(width: AppConstants.spaceMd),
        Text(title, style: theme.textTheme.displaySmall),
        const SizedBox(width: AppConstants.spaceMd),
        Expanded(
          child: Container(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

/// Styled skill pill with icon
class _SkillPill extends StatelessWidget {
  const _SkillPill({
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

/// Timeline-style card with accent left border
class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.icon,
    required this.accentColor,
    required this.title,
    required this.subtitle,
    this.badge,
  });

  final IconData icon;
  final Color accentColor;
  final String title;
  final String subtitle;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Accent left bar
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppConstants.radiusMd),
                  bottomLeft: Radius.circular(AppConstants.radiusMd),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spaceLg),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 20, color: accentColor),
                    ),
                    const SizedBox(width: AppConstants.spaceMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spaceXs),
                          Text(
                            subtitle,
                            style: theme.textTheme.bodyMedium,
                          ),
                          if (badge != null) ...[
                            const SizedBox(height: AppConstants.spaceSm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.spaceSm,
                                vertical: AppConstants.spaceXs,
                              ),
                              decoration: BoxDecoration(
                                color: accentColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusFull,
                                ),
                              ),
                              child: Text(
                                badge!,
                                style:
                                    theme.textTheme.labelSmall?.copyWith(
                                      color: accentColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
