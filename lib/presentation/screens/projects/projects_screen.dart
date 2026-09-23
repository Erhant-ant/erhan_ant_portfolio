import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/layout/app_scaffold.dart';
import '../../widgets/layout/scroll_reveal.dart';

// --- Data Model ---

class _Project {
  const _Project({
    required this.name,
    required this.descriptionEn,
    required this.descriptionTr,
    required this.language,
    required this.isPublic,
    this.url,
  });

  final String name;
  final String descriptionEn;
  final String descriptionTr;
  final String language;
  final bool isPublic;
  final String? url;

  String get description => localized(descriptionEn, descriptionTr);
}

class _ProjectCategory {
  const _ProjectCategory({
    required this.titleEn,
    required this.titleTr,
    required this.icon,
    required this.color,
    required this.projects,
  });

  final String titleEn;
  final String titleTr;
  final IconData icon;
  final Color color;
  final List<_Project> projects;

  String get title => localized(titleEn, titleTr);
}

// --- Screen ---

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  Future<void> _openLink(BuildContext context, String url) async {
    final opened =
        await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localized(
                'The link could not be opened.', 'Bağlantı açılamadı.'),
          ),
        ),
      );
    }
  }

  List<_ProjectCategory> _categories(ThemeData theme) {
    return [
      _ProjectCategory(
        titleEn: 'Games',
        titleTr: 'Oyunlar',
        icon: Icons.sports_esports_rounded,
        color: const Color(0xFF10B981), // Emerald Green
        projects: [
          _Project(
            name: 'Games',
            descriptionEn: 'Major game projects and prototypes I am developing.',
            descriptionTr: 'Geliştirmekte olduğum büyük oyun projeleri ve prototipler.',
            language: 'C# / Unity / Dart',
            isPublic: true,
            url: 'https://github.com/Erhant-ant/Games',
          ),
        ],
      ),
      _ProjectCategory(
        titleEn: 'Apps & Tools',
        titleTr: 'Uygulamalar & Araçlar',
        icon: Icons.code_rounded,
        color: theme.colorScheme.primary, // Mavi
        projects: [
          _Project(
            name: 'SupportDesk',
            descriptionEn:
                'Bilingual IT support ticket tracker for teams.',
            descriptionTr:
                'Ekipler için iki dilli IT destek talep takipçisi.',
            language: 'Dart',
            isPublic: true,
            url:
                'https://github.com/Erhant-ant/it_support_ticket_tracker',
          ),
          _Project(
            name: 'Apps-and-Tools',
            descriptionEn: 'Useful applications and tools I\'ve built.',
            descriptionTr:
                'Geliştirdiğim kullanışlı uygulamalar ve araçlar.',
            language: 'Dart',
            isPublic: true,
            url: 'https://github.com/Erhant-ant/Apps-and-Tools',
          ),
          _Project(
            name: 'ercan_ant',
            descriptionEn: 'Personal utility project.',
            descriptionTr: 'Kişisel yardımcı araç projesi.',
            language: 'Dart',
            isPublic: true,
            url: 'https://github.com/Erhant-ant/ercan_ant',
          ),
          _Project(
            name: 'Sınav Koçum Pro',
            descriptionEn:
                'An exam coaching and study companion application.',
            descriptionTr: 'Sınav koçluğu ve çalışma rehberi uygulaması.',
            language: 'Dart',
            isPublic: true,
            url: 'https://github.com/Erhant-ant/sinav_kocum_pro',
          ),
        ],
      ),
      _ProjectCategory(
        titleEn: 'Portfolios',
        titleTr: 'Portfolyolar',
        icon: Icons.web_rounded,
        color: theme.colorScheme.secondary, // Mor
        projects: [
          _Project(
            name: 'Portfolios',
            descriptionEn: 'My portfolio websites and web projects.',
            descriptionTr: 'Portfolyo web sitelerim ve web projelerim.',
            language: 'Dart',
            isPublic: true,
            url: 'https://github.com/Erhant-ant/Portfolios',
          ),
          _Project(
            name: 'erhan_ant_portfolio',
            descriptionEn: 'Personal portfolio v1 & v2 website.',
            descriptionTr: 'Kişisel portfolyo v1 & v2 web sitesi.',
            language: 'Dart',
            isPublic: true,
            url: 'https://github.com/Erhant-ant/erhan_ant_portfolio',
          ),
        ],
      ),
      _ProjectCategory(
        titleEn: 'IT & Automation',
        titleTr: 'IT & Otomasyon',
        icon: Icons.dns_rounded,
        color: const Color(0xFFF59E0B), // Sarı
        projects: [
          _Project(
            name: 'Learning-and-Research',
            descriptionEn:
                'Research on systems, architecture, and network protocols.',
            descriptionTr:
                'Sistemler, mimari ve ağ protokolleri üzerine araştırmalar.',
            language: 'Various',
            isPublic: true,
            url:
                'https://github.com/Erhant-ant/Learning-and-Research',
          ),
          _Project(
            name: 'Siemens TIA Portal',
            descriptionEn:
                'Hands-on PLC, Ladder Logic, and industrial automation scripts.',
            descriptionTr:
                'Uygulamalı PLC, Ladder Logic ve endüstriyel otomasyon scriptleri.',
            language: 'SCL',
            isPublic: true,
            url:
                'https://github.com/Erhant-ant/siemens-s7-1200-tia-portal-essentials',
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories = _categories(theme);

    return AppScaffold(
      pageTitleBuilder: () =>
          localized('Projects | Erhan Ant', 'Projeler | Erhan Ant'),
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
                      localized('Projects & Labs', 'Projeler ve Laboratuvar'),
                      style: theme.textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Text(
                      localized(
                        'From immersive games to full-stack applications and IT automation scripts. Click to explore source codes.',
                        'Sürükleyici oyunlardan full-stack uygulamalara ve IT otomasyonlarına kadar. Kaynak kodları için tıkla.',
                      ),
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppConstants.space2Xl),
                  ]
                      .animate(interval: 100.ms)
                      .fadeIn(duration: 500.ms, curve: Curves.easeOut)
                      .slideY(
                          begin: 0.05,
                          duration: 500.ms,
                          curve: Curves.easeOut),
                  // Kodu ProjectsScreen içindeki listeleme bölümünde şu şekilde değiştir:

                  // --- Category Cards ---
                  ...categories.asMap().entries.map((entry) {
                    final category = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppConstants.space2Xl),
                      // İŞTE BÜYÜ: Artık kullanıcı aşağı kaydırdıkça kartlar tek tek belirecek!
                      child: ScrollReveal(
                        child: _CategorySection(
                          category: category,
                          onOpenLink: _openLink,
                        ),
                      ),
                    );
                  }),
                  // --- GitHub CTA ---
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () => _openLink(
                          context, 'https://github.com/Erhant-ant'),
                      icon: const FaIcon(FontAwesomeIcons.github, size: 20),
                      label: Text(
                        localized(
                            'Explore All Repositories', 'Tüm Repoları İncele'),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(
                          duration: 500.ms,
                          delay: 800.ms,
                          curve: Curves.easeOut)
                      .slideY(
                          begin: 0.05,
                          duration: 500.ms,
                          delay: 800.ms,
                          curve: Curves.easeOut),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Category Section ---

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.category,
    required this.onOpenLink,
  });

  final _ProjectCategory category;
  final Future<void> Function(BuildContext context, String url) onOpenLink;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131B2A) : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: category.color.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: category.color.withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.all(
            isMobile ? AppConstants.spaceLg : AppConstants.space2Xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Header
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: category.color.withValues(alpha: 0.3))
                  ),
                  child: Icon(category.icon,
                      color: category.color, size: 28),
                ),
                const SizedBox(width: AppConstants.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        localized(
                          '${category.projects.length} ${category.projects.length == 1 ? "project" : "projects"}',
                          '${category.projects.length} proje',
                        ),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: category.color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spaceLg),

            // Project Cards Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount =
                    constraints.maxWidth > 600 ? 2 : 1;
                return Wrap(
                  spacing: AppConstants.spaceMd,
                  runSpacing: AppConstants.spaceMd,
                  children: category.projects.map((project) {
                    final cardWidth = crossAxisCount == 2
                        ? (constraints.maxWidth -
                                AppConstants.spaceMd) /
                            2
                        : constraints.maxWidth;
                    return SizedBox(
                      width: cardWidth,
                      child: _ProjectCard(
                        project: project,
                        categoryColor: category.color,
                        onOpenLink: onOpenLink,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- Project Card ---

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.project,
    required this.categoryColor,
    required this.onOpenLink,
  });

  final _Project project;
  final Color categoryColor;
  final Future<void> Function(BuildContext context, String url) onOpenLink;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = widget.categoryColor;

    return MouseRegion(
      cursor: widget.project.isPublic && widget.project.url != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.project.isPublic && widget.project.url != null
            ? () => widget.onOpenLink(context, widget.project.url!)
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(AppConstants.spaceLg),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? color
                  : theme.colorScheme.outline.withValues(alpha: 0.5),
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.25),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          // HATA BURADAYDI, DOĞRUSU (Matrix4.translationValues) ŞEKLİNDEDİR:
          transform: Matrix4.translationValues(0, _isHovered ? -6.0 : 0.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.project.isPublic
                          ? Icons.folder_open_rounded
                          : Icons.lock_outline,
                      color: color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spaceSm),
                  Expanded(
                    child: Text(
                      widget.project.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.project.isPublic &&
                      widget.project.url != null)
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _isHovered ? 1.0 : 0.3,
                      child: Icon(
                        Icons.arrow_outward,
                        size: 18,
                        color: color,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppConstants.spaceMd),
              Text(
                widget.project.description,
                style: theme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.project.language.isNotEmpty) ...[
                const SizedBox(height: AppConstants.spaceLg),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.project.language,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.7),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}