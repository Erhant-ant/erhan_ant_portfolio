import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      pageTitleBuilder: () => 'Erhan Ant | Software & IT Portfolio',
      body: PageScrollWrapper(
        children: [
            ...AnimateList(
              interval: 150.ms,
              effects: [
                FadeEffect(duration: 600.ms, curve: Curves.easeOut),
                SlideEffect(begin: const Offset(0, 0.1), duration: 600.ms, curve: Curves.easeOut),
              ],
              children: const [
                HeroSection(),
                CurrentFocusSection(),
                FeaturedProjectSection(),
                ContactPreviewSection(),
              ],
            ),
        ],
      ),
    );
  }
}
