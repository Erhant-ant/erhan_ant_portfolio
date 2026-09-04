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
        'tags': ['Flutter', 'Dart', 'State Management', 'Web'],
        'url': 'https://github.com/Erhant-ant/it_support_ticket_tracker',
      },
      {
        'title': localized('Personal Portfolio', 'Kişisel Portfolyo'),
        'description': localized(
          'A responsive Flutter web portfolio that presents my background, skills, and learning progress.',
          'Teknik projelerimi ve devam eden IT eğitimlerimi modern, akıcı bir arayüzle sunan, duyarlı (responsive) kişisel web sitem.',
        ),
        'tags': ['Flutter', 'Web'],
      },
      {
        'title': localized('Tip Calculator', 'Bahşiş Hesaplayıcı'),
        'description': localized(
          'A simple Python command-line application that calculates a tip amount and total bill.',
          'Yemek hesaplarını bölüştürmeyi ve bahşiş hesaplamayı kolaylaştıran, temiz ve kullanıcı dostu arayüze sahip pratik mobil uygulama.',
        ),
        'tags': ['Python', 'CLI'],
        'url': 'https://github.com/Erhant-ant/tip-calculator',
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

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.onOpenLink});

  final Map<String, Object> project;
  final Future<void> Function(BuildContext context, String url) onOpenLink;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final caseStudy = project['caseStudy'] as Map<String, Object>?;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spaceMd),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spaceLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.folder_open,
                color: theme.colorScheme.secondary,
                size: 32,
              ),
              const SizedBox(height: AppConstants.spaceMd),
              Text(
                project['title'] as String,
                style: theme.textTheme.displaySmall,
              ),
              const SizedBox(height: AppConstants.spaceSm),
              Text(
                project['description'] as String,
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
                          color: theme.colorScheme.secondary,
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
                children: (project['tags'] as List<String>)
                    .map((tag) => Chip(label: Text(tag)))
                    .toList(),
              ),
              if (project['url'] != null) ...[
                const SizedBox(height: AppConstants.spaceLg),
                OutlinedButton.icon(
                  onPressed: () =>
                      onOpenLink(context, project['url'] as String),
                  icon: const Icon(Icons.open_in_new),
                  label: Text(
                    localized('View on GitHub', 'GitHub\'da Görüntüle'),
                  ),
                ),
              ],
            ],
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
