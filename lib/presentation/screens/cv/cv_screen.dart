import 'package:flutter/material.dart';

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
                    localized('CV Summary', 'CV Ozeti'),
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
                  const SizedBox(height: AppConstants.space2Xl),
                  Text(
                    localized('Profile', 'Profil'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppConstants.spaceSm),
                  Text(
                    localized(
                      'Passionate about technology, software development, and practical problem solving. Interested in IT support, systems, data management, and modern application development, with a focus on learning, building, and turning ideas into useful digital experiences.',
                      'Teknoloji, yazılım geliştirme ve pratik problem çözmeye ilgi duyuyorum. IT destek, sistemler, veri yönetimi ve modern uygulama geliştirme alanlarına odaklanıyor; öğrenmeye, üretmeye ve fikirleri kullanışlı dijital deneyimlere dönüştürmeye önem veriyorum.',
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppConstants.space2Xl),
                  Text(
                    localized('Core Skills', 'Temel Yetkinlikler'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  const Wrap(
                    spacing: AppConstants.spaceSm,
                    runSpacing: AppConstants.spaceSm,
                    children: [
                      Chip(label: Text('IT Support')),
                      Chip(label: Text('Windows Systems')),
                      Chip(label: Text('Hardware Support')),
                      Chip(label: Text('SQL')),
                      Chip(label: Text('Networking')),
                      Chip(label: Text('Java')),
                      Chip(label: Text('MS Office')),
                    ],
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
                  Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(
                        AppConstants.spaceLg,
                      ),
                      leading: Icon(
                        Icons.verified_outlined,
                        color: theme.colorScheme.secondary,
                      ),
                      title: const Text(
                        'Google IT Support Professional Certificate',
                      ),
                      subtitle: const Text('Coursera'),
                    ),
                  ),
                  const SizedBox(height: AppConstants.space2Xl),
                  Text(
                    localized('Ongoing Learning', 'Devam Eden Egitimler'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  Wrap(
                    spacing: AppConstants.spaceSm,
                    runSpacing: AppConstants.spaceSm,
                    children: [
                      const Chip(label: Text('Siemens TIA Portal')),
                      const Chip(label: Text('Microsoft Data Analyst')),
                      const Chip(label: Text('Microsoft 365 Fundamentals')),
                      const Chip(label: Text('SQL Fundamentals')),
                      const Chip(label: Text('Flutter')),
                      const Chip(label: Text('Firebase')),
                      Chip(
                        label: Text(
                          localized('AI Tools', 'Yapay Zeka Araclari'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.space2Xl),
                  Text(
                    localized('Education', 'Egitim'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.school_outlined),
                          title: const Text('Passaic County Community College'),
                          subtitle: Text(
                            localized(
                              'Associate Degree in Computer Science, 2026',
                              'Bilgisayar Bilimleri On Lisans Derecesi, 2026',
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.account_balance_outlined),
                          title: const Text('Izmir Katip Celebi University'),
                          subtitle: Text(
                            localized(
                              'Bachelor\'s Degree in Business Administration, 2018',
                              'Isletme Lisans Programi, 2018',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.space2Xl),
                  Text(
                    localized('Experience', 'Deneyim'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(
                        AppConstants.spaceLg,
                      ),
                      leading: Icon(
                        Icons.inventory_2_outlined,
                        color: theme.colorScheme.secondary,
                      ),
                      title: const Text('Amazon Fulfillment Center'),
                      subtitle: Text(
                        localized(
                          'Warehouse Associate, 2024 - 2025. Supported daily operations, digital process tracking, inventory control, and shipping workflows.',
                          'Warehouse Associate, 2024 - 2025. Gunluk operasyonlar, dijital surec takibi, stok kontrolu ve sevkiyat is akislari icinde gorev aldim.',
                        ),
                      ),
                    ),
                  ),
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
                          Navigator.of(context).pushNamed(AppRoutes.contact);
                        },
                        icon: const Icon(Icons.forum_outlined),
                        label: Text(
                          localized('Contact Details', 'Iletisim Bilgileri'),
                        ),
                      ),
                    ],
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
