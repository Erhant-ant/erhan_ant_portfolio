import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/layout/app_scaffold.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width > 1200
                ? (MediaQuery.of(context).size.width - 800) / 2
                : 24,
            vertical: AppConstants.space3Xl,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gizlilik Politikasi',
                    style: theme.textTheme.displayLarge),
                const SizedBox(height: AppConstants.space2Xl),
                Text(
                  'Son guncelleme: 14 Temmuz 2026',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppConstants.space2Xl),
                _buildSection(
                  context,
                  title: 'Veri Toplama',
                  content:
                      'Bu web sitesi ziyaretci bilgilerini toplamamaktadir. '
                      'Herhangi bir form, analiz veya izleme araci kullanilmamaktadir. '
                      'Sadece tema (aydinlik/karanlik) ve dil (Turkce/Ingilizce) '
                      'tercihleriniz tarayicinizin yerel depolama alaninda saklanir.',
                ),
                _buildSection(
                  context,
                  title: 'Cerezler (Cookies)',
                  content:
                      'Bu site cerez kullanmamaktadir. Tema ve dil tercihleri '
                      'SharedPreferences / localStorage ile cihazinizda yerel olarak '
                      'saklanir ve sunuculara gonderilmez.',
                ),
                _buildSection(
                  context,
                  title: 'Harici Baglantilar',
                  content: 'Sitemizde GitHub, LinkedIn ve e-posta baglantilari '
                      'bulunmaktadir. Bu baglantilara tikladiginizda ilgili '
                      'platformlarin kendi gizlilik politikalari gecerli olur.',
                ),
                _buildSection(
                  context,
                  title: 'Iletisim',
                  content: 'Gizlilik politikasi hakkinda sorulariniz icin '
                      'erhan@example.com adresinden bana ulasabilirsiniz.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required String content}) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.space2Xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.displaySmall),
          const SizedBox(height: AppConstants.spaceMd),
          Text(content, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
