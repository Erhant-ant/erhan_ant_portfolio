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
                    localized('Career Goal', 'Kariyer Hedefi'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppConstants.spaceMd),
                  Text(
                    localized(
                      'I want to grow in IT support, systems, data management, and software development while building practical projects and gaining experience with modern technologies.',
                      'IT destek, sistemler, veri yönetimi ve yazılım geliştirme alanlarında kendimi geliştirirken pratik projeler üretmek ve modern teknolojilerle deneyim kazanmak istiyorum.',
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
                      'I enjoy exploring technology, solving problems, and building practical projects. My interests include IT support, systems, data management, and modern application development, with a focus on learning, creating, and exploring new technologies.',
                      'Teknolojiyi keşfetmeyi, problemleri çözmeyi ve pratik projeler geliştirmeyi seviyorum. İlgi alanlarım arasında IT destek, sistemler, veri yönetimi ve modern uygulama geliştirme bulunuyor. Öğrenmeye, üretmeye ve yeni teknolojileri keşfetmeye odaklanıyorum.',
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
