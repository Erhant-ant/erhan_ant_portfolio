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

  // İleride PDF butonunu açmak istersen burayı "true" yapman yeterli.
  static const bool _showPdfButton = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final accent = theme.colorScheme.secondary;
    final emerald = const Color(0xFF10B981);
    final amber = const Color(0xFFF59E0B);

    return AppScaffold(
      pageTitleBuilder: () => 'CV | Erhan Ant',
      body: PageScrollWrapper(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pagePadding(context),
          vertical: AppConstants.space3Xl,
        ),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900), // CV için biraz daha geniş alan
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
                      localized('Curriculum Vitae', 'Özgeçmiş'),
                      style: theme.textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Text(
                      localized(
                        'Erhan Ant - Software & Game Developer',
                        'Erhan Ant - Yazılım ve Oyun Geliştirici',
                      ),
                      style: theme.textTheme.displaySmall?.copyWith(color: primary),
                    ),

                    // --- Profile ---
                    const SizedBox(height: AppConstants.space3Xl),
                    _SectionHeader(
                      icon: Icons.person_outline,
                      title: localized('Profile Summary', 'Profil Özeti'),
                      color: primary,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Text(
                      localized(
                        'A dedicated developer with a unique blend of skills spanning game development, full-stack software, and IT infrastructure. I thrive on building complex systems—whether it’s architecting game logic, writing web apps, or managing and automating networks. Always learning, building, and pushing technical boundaries.',
                        'Oyun geliştirme, full-stack yazılım ve IT altyapısını kapsayan benzersiz bir beceri setine sahip kendini adamış bir geliştirici. İster oyun mantığı tasarlamak, ister web uygulamaları yazmak ya da ağları yönetip otomatize etmek olsun, karmaşık sistemler kurmayı seviyorum. Sürekli öğreniyor, üretiyor ve teknik sınırlarımı zorluyorum.',
                      ),
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                    ),

                    // --- Core Skills ---
                    const SizedBox(height: AppConstants.space3Xl),
                    _SectionHeader(
                      icon: Icons.auto_awesome_rounded,
                      title: localized('Core Expertise', 'Temel Yetkinlikler'),
                      color: accent,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Wrap(
                      spacing: AppConstants.spaceSm,
                      runSpacing: AppConstants.spaceSm,
                      children: [
                        _SkillPill(
                          label: 'Game Development',
                          icon: Icons.sports_esports_rounded,
                          color: emerald,
                        ),
                        _SkillPill(
                          label: 'Full-Stack Apps',
                          icon: Icons.code_rounded,
                          color: accent,
                        ),
                        _SkillPill(
                          label: 'IT Support & Systems',
                          icon: Icons.dns_rounded,
                          color: primary,
                        ),
                        _SkillPill(
                          label: 'SQL & Data',
                          icon: Icons.storage_rounded,
                          color: theme.colorScheme.tertiary,
                        ),
                        _SkillPill(
                          label: 'Hardware & Network',
                          icon: Icons.lan_rounded,
                          color: primary,
                        ),
                        _SkillPill(
                          label: localized('Automation', 'Otomasyon'),
                          icon: Icons.auto_mode_rounded,
                          color: amber,
                        ),
                      ],
                    ),

                    // --- Experience ---
                    const SizedBox(height: AppConstants.space3Xl),
                    _SectionHeader(
                      icon: Icons.work_outline,
                      title: localized('Professional Experience', 'Profesyonel Deneyim'),
                      color: primary,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    _TimelineCard(
                      icon: Icons.inventory_2_rounded,
                      accentColor: primary,
                      title: 'Amazon Fulfillment Center',
                      subtitle: localized(
                        'Warehouse Associate, 2024 - 2025.\nSupported daily operations, digital process tracking, inventory control, and shipping workflows with precision.',
                        'Warehouse Associate, 2024 - 2025.\nGünlük operasyonlar, dijital süreç takibi, stok kontrolü ve sevkiyat iş akışlarında hassasiyetle görev aldım.',
                      ),
                    ),

                    // --- Education & Certifications (Combined & Upgraded) ---
                    const SizedBox(height: AppConstants.space3Xl),
                    _SectionHeader(
                      icon: Icons.account_balance_rounded,
                      title: localized('Education & Certifications', 'Eğitim & Sertifikalar'),
                      color: emerald,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    _TimelineCard(
                      icon: Icons.school_rounded,
                      accentColor: primary,
                      title: 'Passaic County Community College',
                      subtitle: localized(
                        'Associate Degree in Computer Science, Ongoing',
                        'Bilgisayar Bilimleri Ön Lisans Derecesi, Devam Ediyor',
                      ),
                      badge: localized('Academic', 'Akademik'),
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    _TimelineCard(
                      icon: Icons.security_rounded,
                      accentColor: emerald,
                      title: 'Google IT Support Professional Certificate',
                      subtitle: localized(
                        'Coursera. Covers IT support fundamentals, troubleshooting, operating systems, networking, and system administration.',
                        'Coursera. IT destek temelleri, sorun giderme, işletim sistemleri, ağlar ve sistem yönetimini kapsar.',
                      ),
                      badge: localized('Completed', 'Tamamlandı'),
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    _TimelineCard(
                      icon: Icons.account_balance_rounded,
                      accentColor: theme.colorScheme.tertiary,
                      title: 'Izmir Katip Celebi University',
                      subtitle: localized(
                        'Bachelor\'s Degree in Business Administration, 2018',
                        'İşletme Lisans Programı, 2018',
                      ),
                      badge: localized('Academic', 'Akademik'),
                    ),

                    // --- Ongoing Learning & Research ---
                    const SizedBox(height: AppConstants.space3Xl),
                    _SectionHeader(
                      icon: Icons.autorenew_rounded,
                      title: localized('Ongoing Research & Learning', 'Devam Eden Araştırmalar'),
                      color: amber,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    _TimelineCard(
                      icon: Icons.precision_manufacturing_rounded,
                      accentColor: amber,
                      title: 'Siemens PLC and TIA Portal Essentials',
                      subtitle: localized(
                        'Coursera. Learning basic PLC programming and industrial automation workflows.',
                        'Coursera. Temel PLC programlama ve endüstriyel otomasyon iş akışları öğrenimi.',
                      ),
                      badge: localized('In Progress', 'Devam Ediyor'),
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    _TimelineCard(
                      icon: Icons.insights_rounded,
                      accentColor: theme.colorScheme.tertiary,
                      title: 'Microsoft Data Analyst & 365 Fundamentals',
                      subtitle: localized(
                        'Microsoft. Developing foundational skills in data analysis, reporting, and core workspace tools.',
                        'Microsoft. Veri analizi, raporlama ve temel iş yeri araçlarında yetkinlik geliştirimi.',
                      ),
                      badge: localized('In Progress', 'Devam Ediyor'),
                    ),

                    // --- Action Buttons ---
                    const SizedBox(height: AppConstants.space3Xl),
                    Wrap(
                      spacing: AppConstants.spaceMd,
                      runSpacing: AppConstants.spaceSm,
                      children: [
                        if (_showPdfButton)
                          ElevatedButton.icon(
                            onPressed: () => downloadCvFile(),
                            icon: const Icon(Icons.download_rounded),
                            label: Text(
                              localized('Download CV PDF', 'CV PDF Indir'),
                            ),
                          ),
                        OutlinedButton.icon(
                          onPressed: () {
                            context.go(AppRoutes.contact);
                          },
                          icon: const Icon(Icons.forum_rounded),
                          label: Text(
                            localized('Contact Me', 'Benimle İletişime Geç'),
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
  const _SectionHeader({required this.icon, required this.title, required this.color});

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, size: 22, color: color),
        ),
        const SizedBox(width: AppConstants.spaceMd),
        Text(title, style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(width: AppConstants.spaceMd),
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.5), color.withValues(alpha: 0)]
              )
            ),
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
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
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
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131B2A) : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Glowing Accent left bar
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(color: accentColor.withValues(alpha: 0.5), blurRadius: 8)
                ]
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spaceLg),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                      ),
                      child: Icon(icon, size: 24, color: accentColor),
                    ),
                    const SizedBox(width: AppConstants.spaceMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            subtitle,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                              height: 1.5,
                            ),
                          ),
                          if (badge != null) ...[
                            const SizedBox(height: AppConstants.spaceMd),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: accentColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusFull,
                                ),
                                border: Border.all(color: accentColor.withValues(alpha: 0.3))
                              ),
                              child: Text(
                                badge!,
                                style:
                                    theme.textTheme.labelSmall?.copyWith(
                                      color: accentColor,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
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