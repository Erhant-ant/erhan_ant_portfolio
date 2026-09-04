import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/about/about_screen.dart';
import '../../presentation/screens/certificates/certificates_screen.dart';
import '../../presentation/screens/contact/contact_screen.dart';
import '../../presentation/screens/cv/cv_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/projects/projects_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const about = '/about';
  static const projects = '/projects';
  static const certificates = '/certificates';
  static const cv = '/cv';
  static const contact = '/contact';
}

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.about,
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: AppRoutes.projects,
        builder: (context, state) => const ProjectsScreen(),
      ),
      GoRoute(
        path: AppRoutes.certificates,
        builder: (context, state) => const CertificatesScreen(),
      ),
      GoRoute(
        path: AppRoutes.cv,
        builder: (context, state) => const CvScreen(),
      ),
      GoRoute(
        path: AppRoutes.contact,
        builder: (context, state) => const ContactScreen(),
      ),
    ],
    errorBuilder: (context, state) => const HomeScreen(),
  );
}
