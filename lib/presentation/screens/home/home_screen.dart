import 'package:flutter/material.dart';

import '../../widgets/layout/app_footer.dart';
import '../../widgets/layout/app_scaffold.dart';
import 'sections/contact_preview_section.dart';
import 'sections/current_focus_section.dart';
import 'sections/featured_project_section.dart';
import 'sections/hero_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitleBuilder: () => 'Erhan Ant | Flutter & IT Portfolio',
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroSection(),
            const CurrentFocusSection(),
            const FeaturedProjectSection(),
            const ContactPreviewSection(),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
