import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInSection extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const FadeInSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return _FadeInWrapper(
      delay: delay,
      child: child,
    );
  }
}

class _FadeInWrapper extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _FadeInWrapper({required this.child, required this.delay});

  @override
  State<_FadeInWrapper> createState() => _FadeInWrapperState();
}

class _FadeInWrapperState extends State<_FadeInWrapper> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.child.hashCode),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05 && !_visible) {
          Future.delayed(widget.delay, () {
            if (mounted) setState(() => _visible = true);
          });
        }
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: _visible ? 1.0 : 0.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
