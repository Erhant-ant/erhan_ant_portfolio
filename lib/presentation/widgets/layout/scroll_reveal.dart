import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final double beginOffset;

  const ScrollReveal({
    super.key, 
    required this.child,
    this.beginOffset = 0.15, // Ekranda aşağıdan yukarı kayma mesafesi
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _isVisible = false;
  late final Key _key;

  @override
  void initState() {
    super.initState();
    _key = UniqueKey(); // Her element için benzersiz bir takipçi anahtarı
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      // Eleman ekranın %10'u kadar göründüğünde animasyonu tetikle
      onVisibilityChanged: (info) {
        if (!_isVisible && info.visibleFraction > 0.1) {
          setState(() => _isVisible = true);
        }
      },
      child: widget.child.animate(
        target: _isVisible ? 1.0 : 0.0, // Görünürse 1 yap, değilse 0'da bekle
      ).fadeIn(
        duration: const Duration(milliseconds: 600), 
        curve: Curves.easeOut,
      ).slideY(
        begin: widget.beginOffset, 
        end: 0, 
        duration: const Duration(milliseconds: 600), 
        curve: Curves.easeOut,
      ),
    );
  }
}