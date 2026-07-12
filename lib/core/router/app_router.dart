import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/about/about_screen.dart';
import '../../presentation/screens/projects/projects_screen.dart';
import '../../presentation/screens/certificates/certificates_screen.dart';
import '../../presentation/screens/blog/blog_screen.dart';
import '../../presentation/screens/cv/cv_screen.dart';
import '../../presentation/screens/contact/contact_screen.dart';
import '../../presentation/screens/privacy/privacy_screen.dart';
import '../../presentation/screens/not_found/not_found_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
      GoRoute(
          path: '/projects',
          builder: (context, state) => const ProjectsScreen()),
      GoRoute(
          path: '/certificates',
          builder: (context, state) => const CertificatesScreen()),
      GoRoute(path: '/blog', builder: (context, state) => const BlogScreen()),
      GoRoute(path: '/cv', builder: (context, state) => const CvScreen()),
      GoRoute(
          path: '/contact', builder: (context, state) => const ContactScreen()),
      GoRoute(
          path: '/privacy', builder: (context, state) => const PrivacyScreen()),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
