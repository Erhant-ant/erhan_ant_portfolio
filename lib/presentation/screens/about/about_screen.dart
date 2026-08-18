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
      pageTitleBuilder: () =>
          localized('About | Erhan Ant', 'Hakkimda | Erhan Ant'),
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
                    localized('A Little About Me', 'Hakkımda'),
                    style: theme.textTheme.displayMedium,
                  ),

                  const SizedBox(height: AppConstants.spaceMd),

                  Text(
                    localized(
                      'I enjoy exploring technology, solving problems, and building practical projects. My interests include IT support, systems, data management, and modern application development. I like learning by building and turning ideas into useful digital experiences.',
                      'Teknolojiyi keşfetmeyi, problemleri çözmeyi ve pratik projeler geliştirmeyi seviyorum. İlgi alanlarım arasında IT destek, sistemler, veri yönetimi ve modern uygulama geliştirme bulunuyor. Üreterek öğrenmeyi ve fikirleri kullanışlı dijital deneyimlere dönüştürmeyi seviyorum.',
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),

                  const SizedBox(height: AppConstants.space2Xl),

                  Text(
                    localized('Future Direction', 'Gelecekteki Yönüm'),
                    style: theme.textTheme.displaySmall,
                  ),

                  const SizedBox(height: AppConstants.spaceMd),

                  Text(
                    localized(
                      'I want to keep learning, building, and exploring different areas of technology while turning ideas into practical projects and meaningful digital experiences.',
                      'Öğrenmeye, üretmeye ve teknolojinin farklı alanlarını keşfetmeye devam ederken fikirleri pratik projelere ve anlamlı dijital deneyimlere dönüştürmek istiyorum.',
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),

                  const SizedBox(height: AppConstants.space2Xl),

                  Text(
                    localized('Current Focus', 'Şu An Odaklandığım Alanlar'),
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
                          localized('AI Tools', 'Yapay Zeka Araçları'),
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
