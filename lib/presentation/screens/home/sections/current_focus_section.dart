import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_language.dart';

class CurrentFocusSection extends StatefulWidget {
  const CurrentFocusSection({super.key});

  @override
  State<CurrentFocusSection> createState() => _CurrentFocusSectionState();
}

class _CurrentFocusSectionState extends State<CurrentFocusSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entryController;
  int? _activeIndex;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final focusItems = _focusItems(theme);
    final activeColor = _activeIndex == null
        ? theme.colorScheme.secondary
        : focusItems[_activeIndex!].color;

    return AnimatedContainer(
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: _activeIndex == null ? Alignment.topLeft : Alignment.topRight,
          end: _activeIndex == null
              ? Alignment.bottomRight
              : Alignment.bottomLeft,
          colors: [
            theme.colorScheme.surface,
            activeColor.withValues(alpha: _activeIndex == null ? 0.08 : 0.16),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceLg,
        vertical: AppConstants.space3Xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            children: [
              Text(
                localized('Current Focus', 'Su Anki Odak'),
                style: theme.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spaceSm),
              Text(
                localized(
                  'Move across a focus area to explore what I am building and learning.',
                  'Uzerine gelerek urettigim ve ogrendigim alanlari kesfet.',
                ),
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.space2Xl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final useFilmStrip = constraints.maxWidth < 880;
                  final bubbleSize = useFilmStrip
                      ? math.min(268.0, constraints.maxWidth - 44)
                      : math.min(292.0, (constraints.maxWidth - 80) / 3);
                  final bubbles = List.generate(
                    focusItems.length,
                    (index) => _buildBubble(
                      item: focusItems[index],
                      index: index,
                      size: bubbleSize,
                      reduceMotion: reduceMotion,
                    ),
                  );

                  if (useFilmStrip) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(
                        left: AppConstants.spaceXs,
                        right: AppConstants.spaceLg,
                        bottom: AppConstants.spaceMd,
                      ),
                      child: Row(
                        children: [
                          for (final bubble in bubbles) ...[
                            bubble,
                            const SizedBox(width: AppConstants.spaceLg),
                          ],
                        ],
                      ),
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: bubbles,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBubble({
    required _FocusItem item,
    required int index,
    required double size,
    required bool reduceMotion,
  }) {
    final start = index * 0.13;
    final end = math.min(start + 0.64, 1.0);
    final curve = CurvedAnimation(
      parent: _entryController,
      curve: Interval(start, end, curve: Curves.easeOutBack),
    );

    return FadeTransition(
      opacity: reduceMotion
          ? const AlwaysStoppedAnimation<double>(1)
          : CurvedAnimation(
              parent: _entryController,
              curve: Interval(start, end),
            ),
      child: SlideTransition(
        position: reduceMotion
            ? const AlwaysStoppedAnimation<Offset>(Offset.zero)
            : Tween<Offset>(
                begin: const Offset(0, 0.16),
                end: Offset.zero,
              ).animate(curve),
        child: _FocusBubble(
          item: item,
          size: size,
          isActive: _activeIndex == index,
          isDimmed: _activeIndex != null && _activeIndex != index,
          onEnter: () => setState(() => _activeIndex = index),
          onExit: () => setState(() => _activeIndex = null),
        ),
      ),
    );
  }

  List<_FocusItem> _focusItems(ThemeData theme) {
    return [
      _FocusItem(
        icon: Icons.flutter_dash,
        title: 'Flutter',
        description: localized(
          'Building responsive interfaces for web and mobile.',
          'Web ve mobil icin responsive arayuzler gelistiriyorum.',
        ),
        color: theme.colorScheme.secondary,
      ),
      _FocusItem(
        icon: Icons.support_agent_outlined,
        title: localized('IT Support', 'IT Destek'),
        description: localized(
          'Strengthening practical skills in systems, networks, and support workflows.',
          'Sistemler, aglar ve destek is akislarinda pratik becerilerimi guclendiriyorum.',
        ),
        color: theme.colorScheme.primary,
      ),
      _FocusItem(
        icon: Icons.psychology_outlined,
        title: localized('AI Tools', 'Yapay Zeka Araclari'),
        description: localized(
          'Exploring useful AI tools and practical application ideas.',
          'Kullanilabilir yapay zeka araclarini ve pratik uygulama fikirlerini kesfediyorum.',
        ),
        color: theme.colorScheme.tertiary,
      ),
    ];
  }
}

class _FocusBubble extends StatelessWidget {
  const _FocusBubble({
    required this.item,
    required this.size,
    required this.isActive,
    required this.isDimmed,
    required this.onEnter,
    required this.onExit,
  });

  final _FocusItem item;
  final double size;
  final bool isActive;
  final bool isDimmed;
  final VoidCallback onEnter;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final duration = reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 260);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onEnter(),
      onExit: (_) => onExit(),
      child: GestureDetector(
        onTap: onEnter,
        child: Semantics(
          button: true,
          label: item.title,
          child: AnimatedOpacity(
            duration: duration,
            curve: Curves.easeOut,
            opacity: isDimmed ? 0.36 : 1,
            child: AnimatedScale(
              duration: duration,
              curve: Curves.easeOutBack,
              scale: isActive ? 1.06 : (isDimmed ? 0.94 : 1),
              child: SizedBox(
                width: size,
                height: size,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: isActive
                          ? const Alignment(-0.35, -0.45)
                          : Alignment.topLeft,
                      colors: [
                        item.color.withValues(alpha: isActive ? 0.26 : 0.14),
                        theme.colorScheme.surface,
                      ],
                    ),
                    border: Border.all(
                      color: item.color.withValues(
                        alpha: isActive ? 0.92 : 0.36,
                      ),
                      width: isActive ? 2.2 : 1,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: item.color.withValues(alpha: 0.30),
                              blurRadius: 32,
                              spreadRadius: 4,
                            ),
                          ]
                        : const [],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.spaceXl),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: duration,
                          width: isActive ? 58 : 50,
                          height: isActive ? 58 : 50,
                          decoration: BoxDecoration(
                            color: item.color.withValues(alpha: 0.16),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(item.icon, color: item.color, size: 28),
                        ),
                        const SizedBox(height: AppConstants.spaceLg),
                        Text(
                          item.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConstants.spaceSm),
                        Text(
                          item.description,
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppConstants.spaceMd),
                        AnimatedContainer(
                          duration: duration,
                          height: 4,
                          width: isActive ? 42 : 24,
                          decoration: BoxDecoration(
                            color: item.color,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FocusItem {
  const _FocusItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
}
