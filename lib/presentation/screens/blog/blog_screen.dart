import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/layout/app_scaffold.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return AppScaffold(
      pageTitleBuilder: () => localized('Blog | Erhan Ant', 'Blog | Erhan Ant'),
      body: PageScrollWrapper(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pagePadding(context),
          vertical: AppConstants.space3Xl,
        ),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header ---
                  ...[
                    Text(
                      localized('Developer Notes', 'Geliştirici Notları'),
                      style: theme.textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Text(
                      localized(
                        'Insights, tutorials, and development logs on game creation, software engineering, and system automation. (Coming soon)',
                        'Oyun geliştirme, yazılım mühendisliği ve sistem otomasyonu üzerine incelemeler, rehberler ve geliştirme günlükleri. (Çok yakında)',
                      ),
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppConstants.space3Xl),
                  ]
                      .animate(interval: 100.ms)
                      .fadeIn(duration: 500.ms, curve: Curves.easeOut)
                      .slideY(begin: 0.05, duration: 500.ms, curve: Curves.easeOut),

                  // --- Blog Grid ---
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 768 ? 3 : (constraints.maxWidth > 500 ? 2 : 1);
                      final cardWidth = (constraints.maxWidth - (AppConstants.spaceLg * (crossAxisCount - 1))) / crossAxisCount;

                      return Wrap(
                        spacing: AppConstants.spaceLg,
                        runSpacing: AppConstants.spaceLg,
                        children: [
                          SizedBox(
                            width: cardWidth,
                            child: _BlogCard(
                              title: localized('Architecting a Large-Scale Game in C#', 'C# ile Büyük Ölçekli Bir Oyun Mimarlığı Kurmak'),
                              excerpt: localized(
                                'A deep dive into the logic, physics, and state management required to build a scalable game engine from scratch.',
                                'Ölçeklenebilir bir oyun motoru inşa etmek için gereken mantık, fizik ve durum yönetimine derinlemesine bir bakış.',
                              ),
                              date: 'Q3 2026',
                              category: 'Game Dev',
                              icon: Icons.sports_esports_rounded,
                              color: const Color(0xFF10B981),
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: _BlogCard(
                              title: localized('Building SupportDesk: IT Ticket Automation', 'SupportDesk: IT Talep Otomasyonu Geliştirmek'),
                              excerpt: localized(
                                'How I combined my IT Support experience with Flutter to create a bilingual, automated ticket management system.',
                                'İki dilli, otomatik bir talep yönetim sistemi oluşturmak için IT Destek deneyimimi Flutter ile nasıl birleştirdim.',
                              ),
                              date: 'Q3 2026',
                              category: 'Full-Stack',
                              icon: Icons.code_rounded,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: _BlogCard(
                              title: localized('Bridging the Gap: IT Systems & Coding', 'Köprüyü Kurmak: IT Sistemleri ve Kodlama'),
                              excerpt: localized(
                                'Why understanding hardware, networking, and PLCs makes you a better software engineer overall.',
                                'Donanım, ağ yapıları ve PLC\'leri anlamanın sizi neden genel olarak daha iyi bir yazılım mühendisi yaptığına dair düşünceler.',
                              ),
                              date: 'Q4 2026',
                              category: 'Systems',
                              icon: Icons.dns_rounded,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ]
                        .animate(interval: 150.ms)
                        .fadeIn(duration: 600.ms, delay: 300.ms, curve: Curves.easeOut)
                        .slideY(begin: 0.1, duration: 600.ms, delay: 300.ms, curve: Curves.easeOut),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlogCard extends StatefulWidget {
  const _BlogCard({
    required this.title,
    required this.excerpt,
    required this.date,
    required this.category,
    required this.icon,
    required this.color,
  });

  final String title;
  final String excerpt;
  final String date;
  final String category;
  final IconData icon;
  final Color color;

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF131B2A) : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? widget.color : theme.colorScheme.outline.withValues(alpha: 0.5),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.2),
                    blurRadius: 30,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        transform: Matrix4.translationValues(0, _isHovered ? -8.0 : 0.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder Image Area (Gradient with Icon)
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.color.withValues(alpha: 0.3),
                    widget.color.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: Center(
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: _isHovered ? 1.1 : 1.0,
                  child: Icon(widget.icon, size: 64, color: widget.color.withValues(alpha: 0.8)),
                ),
              ),
            ),
            
            // Content Area
            Padding(
              padding: const EdgeInsets.all(AppConstants.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                        ),
                        child: Text(
                          widget.category.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: widget.color,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Text(
                        widget.date,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  Text(
                    widget.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppConstants.spaceSm),
                  Text(
                    widget.excerpt,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppConstants.spaceLg),
                  Row(
                    children: [
                      Text(
                        localized('Coming Soon', 'Yakında'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: _isHovered ? widget.color : theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        transform: Matrix4.translationValues(_isHovered ? 6.0 : 0.0, 0, 0),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          color: _isHovered ? widget.color : theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}