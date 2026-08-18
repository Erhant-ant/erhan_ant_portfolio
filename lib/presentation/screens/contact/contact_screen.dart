import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/layout/app_scaffold.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      pageTitleBuilder: () =>
          localized('Contact | Erhan Ant', 'Iletisim | Erhan Ant'),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pagePadding(context),
          vertical: AppConstants.space3Xl,
        ),
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localized('Contact', 'Iletisim'),
                  style: theme.textTheme.displayLarge,
                ),
                const SizedBox(height: AppConstants.spaceMd),
                Text(
                  localized(
                    'Use my profiles to follow my work or connect professionally.',
                    'Calismalarimi takip etmek veya profesyonel olarak baglanti kurmak icin profil bilgilerimi kullanabilirsin.',
                  ),
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: AppConstants.space2Xl),
                const _ContactCard(
                  icon: Icons.code,
                  title: 'GitHub',
                  value: 'github.com/Erhant-ant',
                  url: 'https://github.com/Erhant-ant',
                ),
                const SizedBox(height: AppConstants.spaceMd),
                const _ContactCard(
                  icon: Icons.business_center_outlined,
                  title: 'LinkedIn',
                  value: 'linkedin.com/in/erhan-ant-328380359',
                  url: 'https://www.linkedin.com/in/erhan-ant-328380359',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.url,
  });

  final IconData icon;
  final String title;
  final String value;
  final String url;

  Future<void> _openLink(BuildContext context) async {
    final opened = await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localized(
              '$title could not be opened.',
              '$title baglantisi acilamadi.',
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppConstants.spaceLg),
        leading: Icon(icon, size: 28, color: theme.colorScheme.secondary),
        title: Text(title, style: theme.textTheme.displaySmall),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppConstants.spaceXs),
          child: Text(value),
        ),
        onTap: () => _openLink(context),
        trailing: IconButton(
          tooltip: localized('Copy', 'Kopyala'),
          icon: const Icon(Icons.copy_outlined),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  localized(
                    '$title link copied.',
                    '$title baglantisi kopyalandi.',
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
