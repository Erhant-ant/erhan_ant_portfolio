import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/layout/app_scaffold.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width > 1200
                ? (MediaQuery.of(context).size.width - 600) / 2
                : 24,
            vertical: AppConstants.space3Xl,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Iletisim', style: theme.textTheme.displayLarge),
                const SizedBox(height: AppConstants.spaceLg),
                Text(
                  'Bir proje fikriniz mi var, is birligi mi yapmak istiyorsunuz, '
                  'ya da sadece merhaba demek mi istiyorsunuz? '
                  'Asagidaki kanallardan bana ulasabilirsiniz.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.space3Xl),

                // Email
                _buildContactCard(
                  context,
                  icon: Icons.email,
                  title: 'E-posta',
                  value: 'erhan@example.com',
                  onTap: () => launchUrl(Uri.parse('mailto:erhan@example.com')),
                ),

                // LinkedIn
                _buildContactCard(
                  context,
                  icon: Icons.business,
                  title: 'LinkedIn',
                  value: 'linkedin.com/in/erhanant',
                  onTap: () => launchUrl(Uri.parse(
                      'https://www.linkedin.com/in/erhan-ant-328380359/')),
                ),

                // GitHub
                _buildContactCard(
                  context,
                  icon: Icons.code,
                  title: 'GitHub',
                  value: 'github.com/erhanant',
                  onTap: () =>
                      launchUrl(Uri.parse('https://github.com/Erhant-ant')),
                ),

                const SizedBox(height: AppConstants.space2Xl),

                // Not
                Container(
                  padding: const EdgeInsets.all(AppConstants.spaceMd),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info,
                          size: 20, color: theme.colorScheme.secondary),
                      const SizedBox(width: AppConstants.spaceMd),
                      Expanded(
                        child: Text(
                          'Yeni firsatlara ve is birliklerine her zaman acigim. '
                          'Bir mesaj uzağinizdayim.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spaceMd),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.secondary),
        title: Text(title, style: theme.textTheme.displaySmall),
        subtitle: Text(value, style: theme.textTheme.bodyMedium),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.5),
        ),
        onTap: onTap,
      ),
    );
  }
}
