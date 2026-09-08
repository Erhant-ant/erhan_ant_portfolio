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
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.about,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const AboutScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.projects,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const ProjectsScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.certificates,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const CertificatesScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.cv,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const CvScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.contact,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const ContactScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => const HomeScreen(),
  );

  static CustomTransitionPage<void> _fadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }
}
