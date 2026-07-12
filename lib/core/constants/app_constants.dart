import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const double maxContentWidth = 1200;
  static const double headerHeight = 64;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;
  static const double space2Xl = 48;
  static const double space3Xl = 64;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusFull = 9999;
  static const double buttonHeight = 44;
  static const double cardPadding = 24;
  static const double heroPortraitMaxWidth = 350;
  static const double heroPortraitMaxWidthMobile = 280;

  static List<BoxShadow> cardShadow(BuildContext context) => [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
}
