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
    final primary = theme.colorScheme.primary;
    final accent = theme.colorScheme.secondary;

    return AppScaffold(
      pageTitleBuilder: () =>
          localized('About | Erhan Ant', 'Hakkımda | Erhan Ant'),
      body: PageScrollWrapper(
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
                    // --- Profile Photo with Glowing Tech Effect ---
                    Center(
                      child: SizedBox(
                        width: 220,
                        height: 220,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            // Animated Glow Behind
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: accent.withValues(alpha: 0.3),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                             .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 2.seconds),

                            // Photo
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.colorScheme.surface,
                                  width: 4,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/profile.webp',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppConstants.space2Xl),

                    Text(
                      localized('The Developer Journey', 'Geliştirici Serüvenim'),
                      style: theme.textTheme.displayMedium,
                    ),

                    const SizedBox(height: AppConstants.spaceMd),

                    Text(
                      localized(
                        'I am an active developer passionate about crafting immersive digital experiences and robust systems. Currently, I am heavily focused on developing a large-scale game, which allows me to blend creativity with complex logic. \n\nBeyond game development, my strong background in IT support, systems, and automation empowers me to understand the complete lifecycle of software—from writing the code to maintaining the infrastructure it runs on. I believe in learning by building and turning ambitious ideas into reality.',
                        'Sürükleyici dijital deneyimler ve güçlü sistemler tasarlama tutkusuna sahip aktif bir geliştiriciyim. Şu sıralar, yaratıcılığımı karmaşık mantıkla harmanlamama olanak tanıyan büyük ölçekli bir oyun geliştirmeye odaklanmış durumdayım. \n\nOyun geliştirmenin ötesinde; IT destek, sistemler ve otomasyon konusundaki güçlü altyapım, kod yazmaktan uygulamanın çalışacağı altyapıyı yönetmeye kadar yazılımın tüm yaşam döngüsüne hakim olmamı sağlıyor. Üreterek öğrenmeye ve iddialı fikirleri gerçeğe dönüştürmeye inanıyorum.',
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
                            primary.withValues(alpha: 0.1),
                            theme.colorScheme.surface,
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(AppConstants.radiusLg),
                        border: Border.all(
                          color: primary.withValues(alpha: 0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withValues(alpha: 0.05),
                            blurRadius: 20,
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: primary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.radiusSm,
                                  ),
                                ),
                                child: Icon(
                                  Icons.rocket_launch_rounded,
                                  size: 24,
                                  color: primary,
                                ),
                              ),
                              const SizedBox(width: AppConstants.spaceMd),
                              Text(
                                localized(
                                  'Current Mission & Future',
                                  'Şu Anki Görevim ve Gelecek',
                                ),
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.spaceMd),
                          Text(
                            localized(
                              'My primary goal is to successfully launch the major game project I am working on. Alongside this, I aim to keep expanding my full-stack web and IT automation skills to build independent, scalable technology products.',
                              'Birincil hedefim, şu an üzerinde çalıştığım büyük oyun projesini başarıyla piyasaya sürmek. Bunun yanı sıra, bağımsız ve ölçeklenebilir teknoloji ürünleri geliştirmek için full-stack web ve IT otomasyon becerilerimi genişletmeye devam etmeyi hedefliyorum.',
                            ),
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppConstants.space2Xl),

                    Text(
                      localized(
                        'Technical Arsenal',
                        'Teknik Cephanelik',
                      ),
                      style: theme.textTheme.displaySmall,
                    ),

                    const SizedBox(height: AppConstants.spaceMd),

                    Wrap(
                      spacing: AppConstants.spaceSm,
                      runSpacing: AppConstants.spaceSm,
                      children: [
                        _FocusPill(
                          label: 'Game Development',
                          icon: Icons.sports_esports_rounded,
                          color: const Color(0xFF10B981), // Yeşil
                        ),
                        _FocusPill(
                          label: 'Full-Stack Web',
                          icon: Icons.code_rounded,
                          color: primary,
                        ),
                        _FocusPill(
                          label: 'Systems & IT Support',
                          icon: Icons.dns_rounded,
                          color: accent,
                        ),
                        _FocusPill(
                          label: 'SQL & Data',
                          icon: Icons.storage_rounded,
                          color: theme.colorScheme.tertiary,
                        ),
                        _FocusPill(
                          label: 'Networking',
                          icon: Icons.lan_rounded,
                          color: primary,
                        ),
                        _FocusPill(
                          label: localized('AI Tools', 'Yapay Zeka Araçları'),
                          icon: Icons.psychology_outlined,
                          color: accent,
                        ),
                        _FocusPill(
                          label: localized('Automation', 'Otomasyon'),
                          icon: Icons.auto_mode_outlined,
                          color: const Color(0xFFF59E0B), // Sarı
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
        color: color.withValues(alpha: 0.12),
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