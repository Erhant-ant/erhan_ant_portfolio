import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/layout/app_scaffold.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: const AssetImage(
                        'assets/images/profile.jpeg',
                      ),
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(height: AppConstants.space2Xl),
                  Text(
                    localized('Hello, I am Erhan.', 'Merhaba, ben Erhan.'),
                    style: theme.textTheme.displayLarge,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  Text(
                    localized(
                      'I am a Computer Science graduate with a background in Business Administration, U.S. education, and operations experience. I am building practical skills in IT support, systems, data management, and modern application development.',
                      'Bilgisayar Bilimleri mezunuyum. Isletme altyapimi ABD egitim ve operasyon deneyimimle birlestirerek IT destek, sistemler, veri yonetimi ve modern uygulama gelistirme alanlarinda pratik beceriler gelistiriyorum.',
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppConstants.space2Xl),
                  Text(
                    localized('Current Focus', 'Su An Odaklandigim Alanlar'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  Wrap(
                    spacing: AppConstants.spaceSm,
                    runSpacing: AppConstants.spaceSm,
                    children: [
                      const Chip(label: Text('IT Support')),
                      const Chip(label: Text('Systems')),
                      const Chip(label: Text('SQL')),
                      const Chip(label: Text('Networking')),
                      const Chip(label: Text('Flutter')),
                      Chip(
                        label: Text(
                          localized('AI Tools', 'Yapay Zeka Araclari'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.space2Xl),
                  Text(
                    localized('Career Goal', 'Kariyer Hedefi'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  Text(
                    localized(
                      'To contribute in IT support, systems support, operations support, and data management roles while continuing to build software projects.',
                      'Yazilim projeleri gelistirmeye devam ederken IT destek, sistem destek, operasyon destek ve veri yonetimi rollerinde katki sunmayi hedefliyorum.',
                    ),
                    style: theme.textTheme.bodyLarge,
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
