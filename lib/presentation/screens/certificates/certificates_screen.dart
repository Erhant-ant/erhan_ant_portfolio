import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/layout/app_scaffold.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      pageTitleBuilder: () =>
          localized('Learning | Erhan Ant', 'Egitimler | Erhan Ant'),
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
                children: [
                  Text(
                    localized(
                      'Certificates and Learning',
                      'Sertifikalar ve Egitimler',
                    ),
                    style: theme.textTheme.displayLarge,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  Text(
                    localized(
                      'Completed certifications and the technical subjects I am currently developing.',
                      'Tamamladigim sertifikalar ve su anda gelistirdigim teknik alanlar.',
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppConstants.space2Xl),
                  Text(
                    localized(
                      'Completed Certification',
                      'Tamamlanan Sertifika',
                    ),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  _LearningCard(
                    icon: Icons.verified_outlined,
                    title: 'Google IT Support Professional Certificate',
                    platform: 'Coursera',
                    description: localized(
                      'Completed professional certificate covering IT support fundamentals, troubleshooting, operating systems, networking, and system administration.',
                      'IT destek temelleri, sorun giderme, isletim sistemleri, aglar ve sistem yonetimini kapsayan profesyonel sertifika.',
                    ),
                    status: localized('Completed', 'Tamamlandi'),
                    statusIcon: Icons.check_circle_outline,
                  ),
                  const SizedBox(height: AppConstants.space2Xl),
                  Text(
                    localized('Ongoing Learning', 'Devam Eden Egitimler'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  _LearningCard(
                    icon: Icons.memory_outlined,
                    title: 'Siemens PLC and TIA Portal Essentials',
                    platform: 'Coursera',
                    description: localized(
                      'Learning basic PLC programming and industrial automation workflows with Siemens TIA Portal.',
                      'Siemens TIA Portal ile temel PLC programlama ve endustriyel otomasyon is akislari ogreniyorum.',
                    ),
                    status: localized('In progress', 'Devam ediyor'),
                    statusIcon: Icons.autorenew,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  _LearningCard(
                    icon: Icons.bar_chart_outlined,
                    title: 'Microsoft Data Analyst',
                    platform: 'Microsoft',
                    description: localized(
                      'Developing foundational skills in data analysis, reporting, and data-driven decision making.',
                      'Veri analizi, raporlama ve veri odakli karar verme konusunda temel beceriler gelistiriyorum.',
                    ),
                    status: localized('In progress', 'Devam ediyor'),
                    statusIcon: Icons.autorenew,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  _LearningCard(
                    icon: Icons.business_center_outlined,
                    title: 'Microsoft 365 Fundamentals',
                    platform: 'Microsoft',
                    description: localized(
                      'Learning core Microsoft 365 services and workplace productivity tools.',
                      'Temel Microsoft 365 servisleri ve is yeri verimlilik araclari uzerine calisiyorum.',
                    ),
                    status: localized('In progress', 'Devam ediyor'),
                    statusIcon: Icons.autorenew,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  _LearningCard(
                    icon: Icons.storage_outlined,
                    title: 'SQL Fundamentals',
                    platform: 'BTK Akademi',
                    description: localized(
                      'Building practical knowledge of SQL queries and relational database fundamentals.',
                      'SQL sorgulari ve iliskisel veritabani temelleri konusunda pratik bilgi gelistiriyorum.',
                    ),
                    status: localized('In progress', 'Devam ediyor'),
                    statusIcon: Icons.autorenew,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  _LearningCard(
                    icon: Icons.flutter_dash,
                    title: localized(
                      'Flutter Development',
                      'Flutter Uygulama Gelistirme',
                    ),
                    platform: localized(
                      'Personal projects',
                      'Kisisel projeler',
                    ),
                    description: localized(
                      'Building responsive Flutter web applications through hands-on portfolio projects.',
                      'Portfolyo projeleriyle responsive Flutter web uygulamalari gelistiriyorum.',
                    ),
                    status: localized('Active learning', 'Aktif calisiyorum'),
                    statusIcon: Icons.autorenew,
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

class _LearningCard extends StatelessWidget {
  const _LearningCard({
    required this.icon,
    required this.title,
    required this.platform,
    required this.description,
    required this.status,
    required this.statusIcon,
  });

  final IconData icon;
  final String title;
  final String platform;
  final String description;
  final String status;
  final IconData statusIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: theme.colorScheme.secondary),
            const SizedBox(height: AppConstants.spaceLg),
            Text(title, style: theme.textTheme.displaySmall),
            const SizedBox(height: AppConstants.spaceXs),
            Text(
              platform,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppConstants.spaceMd),
            Text(description, style: theme.textTheme.bodyLarge),
            const SizedBox(height: AppConstants.spaceLg),
            Chip(avatar: Icon(statusIcon, size: 18), label: Text(status)),
          ],
        ),
      ),
    );
  }
}
