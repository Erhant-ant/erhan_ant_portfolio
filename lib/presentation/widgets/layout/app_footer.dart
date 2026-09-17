import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  Future<void> _openLink(BuildContext context, String url) async {
    final opened =
        await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localized(
                'The link could not be opened.', 'Bağlantı açılamadı.'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accent = theme.colorScheme.secondary;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: AppConstants.space3Xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.surface,
            isDark
                ? const Color(0xFF0D1014)
                : const Color(0xFFEFF1F4),
          ],
        ),
        border: Border(
          top: BorderSide(
            color: accent.withValues(alpha: 0.15),
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppConstants.spaceLg,
              right: AppConstants.spaceLg,
              top: AppConstants.spaceLg,
              bottom: AppConstants.spaceXl,
            ),
            child: Column(
              children: [
                // Logo mark
                Text(
                  'EA',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: accent,
                  ),
                ),
                const SizedBox(height: AppConstants.spaceSm),
                Text(
                  localized(
                    'Learning, building, and growing.',
                    'Öğreniyor, üretiyor, gelişiyor.',
                  ),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: AppConstants.spaceLg),

                // Social icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialIconButton(
                      iconWidget: FaIcon(FontAwesomeIcons.github, size: 18),
                      tooltip: 'GitHub',
                      onTap: () => _openLink(
                          context, 'https://github.com/Erhant-ant'),
                      color: accent,
                    ),
                    const SizedBox(width: AppConstants.spaceMd),
                    _SocialIconButton(
                      iconWidget: FaIcon(FontAwesomeIcons.linkedinIn, size: 18),
                      tooltip: 'LinkedIn',
                      onTap: () => _openLink(context,
                          'https://www.linkedin.com/in/erhan-ant-328380359'),
                      color: accent,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spaceLg),

                // Separator
                Container(
                  width: 60,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accent.withValues(alpha: 0),
                        accent.withValues(alpha: 0.5),
                        accent.withValues(alpha: 0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                const SizedBox(height: AppConstants.spaceLg),

                // Nav links
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppConstants.spaceSm,
                  runSpacing: AppConstants.spaceXs,
                  children: [
                    _FooterLink(
                        label: localized('Home', 'Ana Sayfa'),
                        route: '/'),
                    _FooterLink(
                        label: localized('About', 'Hakkımda'),
                        route: '/about'),
                    _FooterLink(
                        label: localized('Projects', 'Projeler'),
                        route: '/projects'),
                    _FooterLink(
                        label:
                            localized('Learning', 'Eğitimler'),
                        route: '/certificates'),
                    const _FooterLink(label: 'CV', route: '/cv'),
                    _FooterLink(
                        label:
                            localized('Contact', 'İletişim'),
                        route: '/contact'),
                  ],
                ),
                const SizedBox(height: AppConstants.spaceLg),

                // Copyright
                Text(
                  '© 2026 Erhan Ant. ${localized('All rights reserved.', 'Tüm hakları saklıdır.')}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface
                        .withValues(alpha: 0.45),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  const _SocialIconButton({
    required this.iconWidget,
    required this.tooltip,
    required this.onTap,
    required this.color,
  });

  final Widget iconWidget;
  final String tooltip;
  final VoidCallback onTap;
  final Color color;

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Tooltip(
          message: widget.tooltip,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.color.withValues(alpha: 0.14)
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered
                    ? widget.color.withValues(alpha: 0.5)
                    : widget.color.withValues(alpha: 0.2),
              ),
            ),
            child: Center(
              child: IconTheme(
                data: IconThemeData(
                  size: 18,
                  color: _isHovered
                      ? widget.color
                      : widget.color.withValues(alpha: 0.6),
                ),
                child: widget.iconWidget,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.route});

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go(route),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceSm,
          vertical: AppConstants.spaceXs,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
