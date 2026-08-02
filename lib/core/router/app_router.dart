import 'package:flutter/material.dart';

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

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomeScreen(),
        );

      case AppRoutes.about:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AboutScreen(),
        );

      case AppRoutes.projects:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ProjectsScreen(),
        );

      case AppRoutes.certificates:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const CertificatesScreen(),
        );

      case AppRoutes.cv:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const CvScreen(),
        );

      case AppRoutes.contact:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ContactScreen(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomeScreen(),
        );
    }
  }
}
