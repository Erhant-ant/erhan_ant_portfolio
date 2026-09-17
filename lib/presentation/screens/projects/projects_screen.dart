
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/layout/app_footer.dart';
import '../../widgets/layout/app_scaffold.dart';

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
        titleEn: 'Portfolios',
        titleTr: 'Portfolyolar',
        icon: Icons.web_outlined,
        color: theme.colorScheme.secondary,
        projects: [
          _Project(
            name: 'Portfolios',
            descriptionEn: 'My portfolio websites and projects.',
            descriptionTr: 'Portfolyo web sitelerim ve projelerim.',
            language: 'Dart',
            isPublic: true,
            url: 'https://github.com/Erhant-ant/Portfolios',
          ),
          _Project(
            name: 'erhan_ant_portfolio',
            descriptionEn: 'Personal portfolio v1 website.',
            descriptionTr: 'Kişisel portfolyo v1 web sitesi.',
            language: 'Dart',
            isPublic: true,
            url: 'https://github.com/Erhant-ant/erhan_ant_portfolio',
          ),
        ],
      ),
      _ProjectCategory(
        titleEn: 'Apps & Tools',
        titleTr: 'Uygulamalar & Araçlar',
        icon: Icons.build_outlined,
        color: theme.colorScheme.primary,
        projects: [
          _Project(
            name: 'SupportDesk',
            descriptionEn:
                'Bilingual IT support ticket tracker for small teams.',
            descriptionTr:
                'Küçük ekipler için iki dilli IT destek talep takipçisi.',
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
        titleEn: 'Games',
        titleTr: 'Oyunlar',
        icon: Icons.sports_esports_outlined,
        color: theme.colorScheme.tertiary,
        projects: [
          _Project(
            name: 'Games',
            descriptionEn: 'Games I\'ve developed.',
            descriptionTr: 'Geliştirdiğim oyunlar.',
            language: 'Dart',
            isPublic: true,
            url: 'https://github.com/Erhant-ant/Games',
          ),
        ],
      ),
      _ProjectCategory(
        titleEn: 'Learning & Research',
        titleTr: 'Eğitim & Araştırma',
        icon: Icons.school_outlined,
        color: const Color(0xFF8B5CF6),
        projects: [
          _Project(
            name: 'Learning-and-Research',
            descriptionEn:
                'My learning journeys and research projects.',
            descriptionTr:
                'Öğrenme yolculuklarım ve araştırma projelerim.',
            language: '',
            isPublic: true,
            url:
                'https://github.com/Erhant-ant/Learning-and-Research',
          ),
          _Project(
            name: 'Siemens TIA Portal',
            descriptionEn:
                'Hands-on PLC, Ladder Logic, HMI and industrial automation.',
            descriptionTr:
                'Uygulamalı PLC, Ladder Logic, HMI ve endüstriyel otomasyon.',
            language: '',
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
                      localized('Projects', 'Projeler'),
                      style: theme.textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Text(
                      localized(
                        'My open-source work, organized by category. Click to explore on GitHub.',
                        'Açık kaynak çalışmalarım, kategorilere ayrılmış. GitHub\'da keşfetmek için tıkla.',
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
                  // --- Category Cards ---
                  ...categories.asMap().entries.map((entry) {
                    final index = entry.key;
                    final category = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppConstants.space2Xl),
                      child: _CategorySection(
                        category: category,
                        onOpenLink: _openLink,
                      )
                          .animate()
                          .fadeIn(
                            duration: 600.ms,
                            delay: (200 + index * 150).ms,
                            curve: Curves.easeOut,
                          )
                          .slideY(
                            begin: 0.06,
                            duration: 600.ms,
                            delay: (200 + index * 150).ms,
                            curve: Curves.easeOut,
                          ),
                    );
                  }),
                  // --- GitHub CTA ---
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () => _openLink(
                          context, 'https://github.com/Erhant-ant'),
                      icon: const FaIcon(FontAwesomeIcons.github, size: 18),
                      label: Text(
                        localized(
                            'Open GitHub Profile', 'GitHub Profilimi Aç'),
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            category.color.withValues(alpha: isDark ? 0.08 : 0.05),
            theme.colorScheme.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: category.color.withValues(alpha: 0.18),
        ),
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
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(category.icon,
                      color: category.color, size: 24),
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
                      Text(
                        localized(
                          '${category.projects.length} ${category.projects.length == 1 ? "project" : "projects"}',
                          '${category.projects.length} proje',
                        ),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: category.color,
                          fontWeight: FontWeight.w600,
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
    final isDark = theme.brightness == Brightness.dark;

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
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(AppConstants.spaceLg),
          decoration: BoxDecoration(
            color: _isHovered
                ? color.withValues(alpha: isDark ? 0.10 : 0.06)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered
                  ? color.withValues(alpha: 0.5)
                  : theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.15),
                      blurRadius: 24,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          transform: _isHovered
              ? (Matrix4.identity()..translateByDouble(0.0, -2.0, 0.0, 0.0))
              : Matrix4.identity(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.project.isPublic
                          ? Icons.folder_open_outlined
                          : Icons.lock_outline,
                      color: color,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spaceSm),
                  Expanded(
                    child: Text(
                      widget.project.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
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
                        size: 16,
                        color: color,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppConstants.spaceSm),
              Text(
                widget.project.description,
                style: theme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.project.language.isNotEmpty) ...[
                const SizedBox(height: AppConstants.spaceSm),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.project.language,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
              if (!widget.project.isPublic) ...[
                const SizedBox(height: AppConstants.spaceSm),
                Row(
                  children: [
                    Icon(Icons.lock_outline,
                        size: 12,
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.4)),
                    const SizedBox(width: 4),
                    Text(
                      localized('Private', 'Gizli'),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.4),
                        fontStyle: FontStyle.italic,
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
