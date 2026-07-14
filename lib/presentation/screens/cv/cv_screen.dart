import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/layout/app_scaffold.dart';

class CvScreen extends StatelessWidget {
  const CvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width > 1200
                ? (MediaQuery.of(context).size.width - 900) / 2
                : 24,
            vertical: AppConstants.space3Xl,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ozgecmis', style: theme.textTheme.displayLarge),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('PDF Indir'),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.space2Xl),

                // Iletisim Bilgileri
                _buildSection(
                  context,
                  title: 'Iletisim',
                  items: [
                    'E-posta: erhan@example.com',
                    'LinkedIn: linkedin.com/in/erhanant',
                    'GitHub: github.com/erhanant',
                    'Konum: Turkiye',
                  ],
                ),

                // Egitim
                _buildSection(
                  context,
                  title: 'Egitim',
                  items: [
                    'Bilgisayar Muhendisligi',
                    'Universite: [Universite Adi]',
                    'Baslangic: 2022 - Beklenen Mezuniyet: 2026',
                  ],
                ),

                // Beceriler
                _buildSection(
                  context,
                  title: 'Teknik Beceriler',
                  items: [
                    'Flutter / Dart - Orta Seviye',
                    'Firebase (Auth, Firestore, Hosting) - Orta Seviye',
                    'Git / GitHub - Orta Seviye',
                    'Python - Temel',
                    'SQL - Orta',
                  ],
                ),

                // Projeler
                _buildSection(
                  context,
                  title: 'Projeler',
                  items: [
                    'Kisisel Portfolyo Web Sitesi - Flutter Web',
                    'Hot Chicken Uygulamasi - Flutter + Firebase',
                    'Restoran Chatbot Platformu - Flutter + AI',
                  ],
                ),

                // Sertifikalar
                _buildSection(
                  context,
                  title: 'Sertifikalar',
                  items: [
                    'Flutter ile Mobil Uygulama Gelistirme - [Platform]',
                    'Firebase Temelleri - [Platform]',
                    'Git ve GitHub - [Platform]',
                  ],
                ),

                // Diller
                _buildSection(
                  context,
                  title: 'Diller',
                  items: [
                    'Turkce - Ana dil',
                    'Ingilizce - Profesyonel Seviye (C1)',
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<String> items}) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.space2Xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.displaySmall),
          const SizedBox(height: AppConstants.spaceMd),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.spaceSm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(width: AppConstants.spaceMd),
                    Expanded(
                      child: Text(item, style: theme.textTheme.bodyLarge),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
