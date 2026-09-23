import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/about/about_screen.dart';
// Yeni Blog dosyamızı çağırıyoruz
import '../../presentation/screens/blog/blog_screen.dart'; 
import '../../presentation/screens/contact/contact_screen.dart';
import '../../presentation/screens/cv/cv_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/not_found/not_found_screen.dart';
import '../../presentation/screens/projects/projects_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const about = '/about';
  static const projects = '/projects';
  static const blog = '/blog'; // Artık certificates yerine blog var
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
        pageBuilder: (context, state) => _premiumTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.about,
        pageBuilder: (context, state) => _premiumTransitionPage(
          key: state.pageKey,
          child: const AboutScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.projects,
        pageBuilder: (context, state) => _premiumTransitionPage(
          key: state.pageKey,
          child: const ProjectsScreen(),
        ),
      ),
      // YENİ BLOG ROTASI
      GoRoute(
        path: AppRoutes.blog,
        pageBuilder: (context, state) => _premiumTransitionPage(
          key: state.pageKey,
          child: const BlogScreen(), 
        ),
      ),
      GoRoute(
        path: AppRoutes.cv,
        pageBuilder: (context, state) => _premiumTransitionPage(
          key: state.pageKey,
          child: const CvScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.contact,
        pageBuilder: (context, state) => _premiumTransitionPage(
          key: state.pageKey,
          child: const ContactScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static CustomTransitionPage<void> _premiumTransitionPage({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideTween = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
            
        final fadeTween = Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

        return SlideTransition(
          position: slideTween,
          child: FadeTransition(
            opacity: fadeTween,
            child: child,
          ),
        );
      },
    );
  }
}