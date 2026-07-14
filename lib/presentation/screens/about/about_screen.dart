import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/layout/app_scaffold.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                Text('Hakkimda', style: theme.textTheme.displayLarge),
                const SizedBox(height: AppConstants.space2Xl),

                // Hikaye
                _buildSection(
                  context,
                  title: 'Hikayem',
                  content: 'Bilgisayar muhendisligi ogrencisi olarak teknoloji '
                      'dunyasinda kendimi gelistiriyorum. Yazilim gelistirme '
                      'sureclerini ogrenmek ve gercek projeler uretmek benim '
                      'icin en onemli oncelik. Flutter ve modern web teknolojileri '
                      'uzerine calisiyor, acik kaynak projelere katki sagliyorum.',
                ),

                // Egitim
                _buildSection(
                  context,
                  title: 'Egitim',
                  content: 'Bilgisayar Muhendisligi bolumunde egitimime devam '
                      'ediyorum. Akademik calismalarimin yani sira pratik '
                      'deneyim kazanmak icin kisisel projeler gelistiriyorum. '
                      'Universite hayatim boyunca yazilim kulubu ve cesitli '
                      'teknik etkinliklere katilarak kendimi gelistiriyorum.',
                ),

                // Su Anki Odak
                _buildSection(
                  context,
                  title: 'Su Anki Odagim',
                  content: 'Flutter ile cross-platform uygulama gelistirme, '
                      'Firebase ekosistemi ve modern web teknolojileri uzerine '
                      'calisiyorum. Ayni zamanda yapay zeka ve LLM entegrasyonlari '
                      'hakkinda kendimi gelistiriyorum. Amacim, full-stack '
                      'yetkinlikler kazanmak ve gercek dunya problemlerine '
                      'cozumler uretmek.',
                ),

                // Ilgi Alanlari
                _buildSection(
                  context,
                  title: 'Ilgi Alanlarim',
                  content: 'Acik kaynak yazilim, kullanici deneyimi tasarimi, '
                      've surdurulebilir kod yazma pratikleri beni en cok '
                      'ilgilendiren konular arasinda. Temiz kod, test yazimi '
                      've mimari tasarim konularinda kendimi surekli gelistiriyorum.',
                ),

                // Kisisel
                _buildSection(
                  context,
                  title: 'Kisisel',
                  content: 'Yazilim disinda fotografcilik, muzik ve seyahat '
                      'ile ilgileniyorum. Yeni yerler kesfetmeyi ve farkli '
                      'kulturleri ogrenmeyi seviyorum. Bos zamanlarimda teknik '
                      'blog yazilari okuyor ve yeni teknolojileri deniyorum.',
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
