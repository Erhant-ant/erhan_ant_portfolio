import 'package:flutter/material.dart';
import '../../widgets/layout/app_scaffold.dart';
import 'sections/hero_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(),
          ],
        ),
      ),
    );
  }
}
