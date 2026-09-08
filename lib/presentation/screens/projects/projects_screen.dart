import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/layout/app_scaffold.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  Future<void> _openLink(BuildContext context, String url) async {
    final opened = await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localized('The link could not be opened.', 'Bağlantı açılamadı.'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final projects = [
      {
        'title': 'SupportDesk',
        'description': localized(
          'A bilingual IT support ticket management application for small and medium-sized organizations. It supports ticket creation, priorities, status workflows, technician notes, search, and an operational dashboard.',
          'Talep yaşam döngüsünü merkeze alan iki dilli (İngilizce/Türkçe) bir yönetim paneli. Kullanıcılar kolayca talep oluştururken, yöneticiler durum, öncelik ve atamaları net bir arayüzden takip edebiliyor.',
        ),
        'caseStudy': {
          'problem': localized(
            'IT requests can be lost across chat messages, email, phone calls, and informal conversations.',
            'Dağınık destek taleplerini, cihaz ve sistem kurulumlarını takip etmek için basit, şeffaf bir yöntem eksikliği. E-postalar ve fiziksel notlar iş akışlarını yavaşlatıyor.',
          ),
          'solution': localized(
            'SupportDesk records each request in one place so the team can prioritize, track, and resolve work clearly.',
            'SupportDesk, her talebi tek yerde kaydederek ekibin işleri önceliklendirmesini, takip etmesini ve net biçimde çözümlemesini sağlar.',
          ),
          'features': [
            localized(
              'Ticket creation with priority, category, department, and device details',
              'Özel IT Destek Panosu: Açık/Kapalı talep ayrımı, hızlı durum güncellemeleri.',
            ),
            localized(
              'Status workflow from open to resolved and closed',
              'Açıktan çözüldü ve kapandı durumuna uzanan iş akışı',
            ),
            localized(
              'Technician notes, search, and a dashboard for operational visibility',
              'Teknisyen notları, arama ve operasyon görünürlüğü için dashboard',
            ),
          ],
        },
        'icon': Icons.support_agent_outlined,
        'tags': ['Flutter', 'Dart', 'State Management', 'Web'],
        'url': 'https://github.com/Erhant-ant/it_support_ticket_tracker',
      },
      {
        'title': localized('Personal Portfolio', 'Kişisel Portfolyo'),
        'description': localized(
          'A responsive Flutter web portfolio that presents my background, skills, and learning progress.',
          'Teknik projelerimi ve devam eden IT eğitimlerimi modern, akıcı bir arayüzle sunan, duyarlı (responsive) kişisel web sitem.',
        ),
        'icon': Icons.web_outlined,
        'tags': ['Flutter', 'Web'],
      },
      {
        'title': localized(
          'Student Learning Tools',
          'Öğrenci Eğitim Araçları',
        ),
        'description': localized(
          'Custom-built educational applications designed for students to support their coursework and learning goals. These tools focus on interactive practice, clear visual feedback, and making study sessions more effective.',
          'Öğrencilerin ders çalışmalarını ve öğrenme hedeflerini desteklemek için özel olarak geliştirilen eğitim uygulamaları. Bu araçlar interaktif pratik, net görsel geri bildirim ve çalışma seanslarını daha verimli hale getirmeye odaklanıyor.',
        ),
        'caseStudy': {
          'problem': localized(
            'Students often struggle with repetitive study tasks and lack engaging, personalized tools to reinforce what they learn in class.',
            'Öğrenciler tekrarlayan çalışma görevlerinde zorlanıyor ve derste öğrendiklerini pekiştirmek için ilgi çekici, kişiselleştirilmiş araçlardan yoksun kalıyor.',
          ),
          'solution': localized(
            'I build focused, easy-to-use study applications tailored to individual student needs, turning routine practice into a more interactive experience.',
            'Bireysel öğrenci ihtiyaçlarına göre odaklanmış, kullanımı kolay çalışma uygulamaları geliştirerek rutin pratiği daha interaktif bir deneyime dönüştürüyorum.',
          ),
          'features': [
            localized(
              'Interactive exercises tailored to specific subjects and learning levels',
              'Belirli konulara ve öğrenme seviyelerine göre uyarlanmış interaktif alıştırmalar',
            ),
            localized(
              'Visual feedback and progress tracking to keep students motivated',
              'Öğrencileri motive etmek için görsel geri bildirim ve ilerleme takibi',
            ),
            localized(
              'Clean, distraction-free interfaces designed for focused study',
              'Odaklanmış çalışma için tasarlanmış sade, dikkat dağıtmayan arayüzler',
            ),
          ],
        },
        'icon': Icons.school_outlined,
        'tags': ['Flutter', 'Education', 'Private'],
      },
    ];

    return AppScaffold(
      pageTitleBuilder: () =>
          localized('Projects | Erhan Ant', 'Projeler | Erhan Ant'),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pagePadding(context),
          vertical: AppConstants.space3Xl,
        ),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimateList(
                  interval: 100.ms,
                  effects: [
                    FadeEffect(duration: 500.ms, curve: Curves.easeOut),
                    SlideEffect(begin: const Offset(0, 0.05), duration: 500.ms, curve: Curves.easeOut),
                  ],
                  children: [
                    Text(
                      localized('Projects', 'Projeler'),
                      style: theme.textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Text(
                      localized(
                        'Portfolio work and practical projects from my software learning journey.',
                        'Yazılım öğrenme sürecimde geliştirdiğim portfolyo ve pratik projeler.',
                      ),
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppConstants.space2Xl),
                    ...projects.map(
                      (project) =>
                          _ProjectCard(project: project, onOpenLink: _openLink),
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    OutlinedButton.icon(
                      onPressed: () =>
                          _openLink(context, 'https://github.com/Erhant-ant'),
                      icon: const Icon(Icons.code),
                      label: Text(
                        localized('Open GitHub Profile', 'GitHub Profilimi Aç'),
                      ),
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

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project, required this.onOpenLink});

  final Map<String, Object> project;
  final Future<void> Function(BuildContext context, String url) onOpenLink;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;
    final caseStudy = widget.project['caseStudy'] as Map<String, Object>?;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spaceMd),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: AppConstants.durationNormal,
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            border: Border.all(
              color: _isHovered
                  ? accent.withValues(alpha: 0.5)
                  : theme.colorScheme.outline,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.10),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  (widget.project['icon'] as IconData?) ?? Icons.folder_open,
                  color: accent,
                  size: 32,
                ),
                const SizedBox(height: AppConstants.spaceMd),
                Text(
                  widget.project['title'] as String,
                  style: theme.textTheme.displaySmall,
                ),
                const SizedBox(height: AppConstants.spaceSm),
                Text(
                  widget.project['description'] as String,
                  style: theme.textTheme.bodyLarge,
                ),
                if (caseStudy != null) ...[
                  const SizedBox(height: AppConstants.spaceXl),
                  _CaseStudyLabel(
                    label: localized('Business Problem', 'İş Problemi'),
                  ),
                  const SizedBox(height: AppConstants.spaceXs),
                  Text(
                    caseStudy['problem'] as String,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppConstants.spaceLg),
                  _CaseStudyLabel(label: localized('Solution', 'Çözüm')),
                  const SizedBox(height: AppConstants.spaceXs),
                  Text(
                    caseStudy['solution'] as String,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppConstants.spaceLg),
                  _CaseStudyLabel(
                    label: localized('Key Features', 'Temel Özellikler'),
                  ),
                  const SizedBox(height: AppConstants.spaceSm),
                  ...((caseStudy['features'] as List<String>).map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppConstants.spaceSm,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 18,
                            color: accent,
                          ),
                          const SizedBox(width: AppConstants.spaceSm),
                          Expanded(
                            child: Text(
                              feature,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
                const SizedBox(height: AppConstants.spaceLg),
                Wrap(
                  spacing: AppConstants.spaceSm,
                  runSpacing: AppConstants.spaceSm,
                  children: (widget.project['tags'] as List<String>)
                      .map((tag) => Chip(label: Text(tag)))
                      .toList(),
                ),
                if (widget.project['url'] != null) ...[
                  const SizedBox(height: AppConstants.spaceLg),
                  OutlinedButton.icon(
                    onPressed: () => widget.onOpenLink(
                      context,
                      widget.project['url'] as String,
                    ),
                    icon: const Icon(Icons.open_in_new),
                    label: Text(
                      localized('View on GitHub', 'GitHub\'da Görüntüle'),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: AppConstants.spaceLg),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 16,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        localized('Private repository', 'Özel depo'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
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
      ),
    );
  }
}

class _CaseStudyLabel extends StatelessWidget {
  const _CaseStudyLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
