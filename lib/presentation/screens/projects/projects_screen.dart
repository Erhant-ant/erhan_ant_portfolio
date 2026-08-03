import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            localized('The link could not be opened.', 'Baglanti acilamadi.'),
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
          'Kucuk ve orta olcekli kurumlar icin iki dilli IT destek talep yonetim uygulamasi. Ticket olusturma, oncelikler, durum akislari, teknisyen notlari, arama ve operasyon paneli sunar.',
        ),
        'caseStudy': {
          'problem': localized(
            'IT requests can be lost across chat messages, email, phone calls, and informal conversations.',
            'IT talepleri sohbet mesajlari, e-posta, telefon gorusmeleri ve kayit disi konusmalar arasinda kaybolabilir.',
          ),
          'solution': localized(
            'SupportDesk records each request in one place so the team can prioritize, track, and resolve work clearly.',
            'SupportDesk, her talebi tek yerde kaydederek ekibin isleri onceliklendirmesini, takip etmesini ve net bicimde cozumlemesini saglar.',
          ),
          'features': [
            localized(
              'Ticket creation with priority, category, department, and device details',
              'Oncelik, kategori, departman ve cihaz bilgileriyle ticket olusturma',
            ),
            localized(
              'Status workflow from open to resolved and closed',
              'Aciktan cozuldu ve kapandi durumuna uzanan is akisi',
            ),
            localized(
              'Technician notes, search, and a dashboard for operational visibility',
              'Teknisyen notlari, arama ve operasyon gorunurlugu icin dashboard',
            ),
          ],
        },
        'tags': ['Flutter', 'Dart', 'State Management', 'Web'],
        'url': 'https://github.com/Erhant-ant/it_support_ticket_tracker',
      },
      {
        'title': localized('Personal Portfolio', 'Kisisel Portfolyo'),
        'description': localized(
          'A responsive Flutter web portfolio that presents my background, skills, and learning progress.',
          'Gecmisimi, yetkinliklerimi ve gelisim surecimi sunan responsive Flutter web portfolyosu.',
        ),
        'tags': ['Flutter', 'Web'],
      },
      {
        'title': localized('Tip Calculator', 'Bahsis Hesaplayici'),
        'description': localized(
          'A simple Python command-line application that calculates a tip amount and total bill.',
          'Bahsis tutarini ve toplam hesabi hesaplayan basit bir Python komut satiri uygulamasi.',
        ),
        'tags': ['Python', 'CLI'],
        'url': 'https://github.com/Erhant-ant/tip-calculator',
      },
    ];

    return AppScaffold(
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
                children: [
                  Text(
                    localized('Projects', 'Projeler'),
                    style: theme.textTheme.displayLarge,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  Text(
                    localized(
                      'Portfolio work and practical projects from my software learning journey.',
                      'Yazilim ogrenme surecimde gelistirdigim portfolyo ve pratik projeler.',
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
                      localized('Open GitHub Profile', 'GitHub Profilimi Ac'),
                    ),
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
                  label: localized('Business Problem', 'Is Problemi'),
                ),
                const SizedBox(height: AppConstants.spaceXs),
                Text(
                  caseStudy['problem'] as String,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppConstants.spaceLg),
                _CaseStudyLabel(label: localized('Solution', 'Cozum')),
                const SizedBox(height: AppConstants.spaceXs),
                Text(
                  caseStudy['solution'] as String,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppConstants.spaceLg),
                _CaseStudyLabel(
                  label: localized('Key Features', 'Temel Ozellikler'),
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
                    localized('View on GitHub', 'GitHub\'da Goruntule'),
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
