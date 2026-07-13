import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/layout/app_scaffold.dart';
import 'sections/hero_section.dart';
import 'sections/current_focus_section.dart';
import 'sections/about_preview_section.dart';
import 'sections/featured_projects_section.dart';
import 'sections/certificates_preview_section.dart';
import 'sections/latest_articles_section.dart';
import 'sections/contact_preview_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(),
            CurrentFocusSection(),
            AboutPreviewSection(),
            FeaturedProjectsSection(),
            CertificatesPreviewSection(),
            LatestArticlesSection(),
            ContactPreviewSection(),
          ],
        ),
      ),
    );
  }
}
