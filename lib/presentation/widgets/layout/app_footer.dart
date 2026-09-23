import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
// Yeni logomuzu aynı klasördeki app_scaffold dosyasından çekiyoruz
import 'app_scaffold.dart' show BrandLogo; 

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
    final primary = theme.colorScheme.primary;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF070A10) : theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: primary.withValues(alpha: 0.15),
            width: 1,
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
              top: 48,
              bottom: 32,
            ),
            child: Column(
              children: [
                // YENİ DEVASA EANT STUDIO LOGOMUZ 
                // Footer'da metni açık bırakıyoruz ki kapsül devasa görünsün
                const BrandLogo(fontSize: 32, showText: true),
                
                const SizedBox(height: AppConstants.spaceLg),
                Text(
                  localized(
                    'Building systems, games, and applications.',
                    'Sistemler, oyunlar ve uygulamalar geliştiriyor.',
                  ),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppConstants.spaceLg),
                Text(
                  localized(
                    'Building systems, games, and applications.',
                    'Sistemler, oyunlar ve uygulamalar geliştiriyor.',
                  ),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppConstants.spaceLg),

                // Social icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialIconButton(
                      iconWidget: const FaIcon(FontAwesomeIcons.github, size: 20),
                      tooltip: 'GitHub',
                      onTap: () => _openLink(
                          context, 'https://github.com/Erhant-ant'),
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(width: AppConstants.spaceMd),
                    _SocialIconButton(
                      iconWidget: const FaIcon(FontAwesomeIcons.linkedinIn, size: 20),
                      tooltip: 'LinkedIn',
                      onTap: () => _openLink(context,
                          'https://www.linkedin.com/in/erhan-ant-328380359'),
                      color: const Color(0xFF0A66C2),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spaceLg),

                // Separator
                Container(
                  width: 100,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primary.withValues(alpha: 0),
                        primary.withValues(alpha: 0.5),
                        primary.withValues(alpha: 0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                const SizedBox(height: AppConstants.spaceLg),

                // Nav links
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppConstants.spaceMd,
                  runSpacing: AppConstants.spaceXs,
                  children: [
                    _FooterLink(label: localized('Home', 'Ana Sayfa'), route: '/'),
                    _FooterLink(label: localized('About', 'Hakkımda'), route: '/about'),
                    _FooterLink(label: localized('Projects', 'Projeler'), route: '/projects'),
                    const _FooterLink(label: 'Blog', route: '/blog'),
                    const _FooterLink(label: 'CV', route: '/cv'),
                    _FooterLink(label: localized('Contact', 'İletişim'), route: '/contact'),
                  ],
                ),
                const SizedBox(height: AppConstants.space2Xl),

                // Copyright
                // Copyright
                Text(
                  '© ${DateTime.now().year} EANT Studio. ${localized('All rights reserved.', 'Tüm hakları saklıdır.')}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface
                        .withValues(alpha: 0.4),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
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
    final theme = Theme.of(context);
    
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.color.withValues(alpha: 0.15)
                  : theme.colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered
                    ? widget.color.withValues(alpha: 0.5)
                    : theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
              boxShadow: _isHovered ? [BoxShadow(color: widget.color.withValues(alpha: 0.2), blurRadius: 10)] : [],
            ),
            child: Center(
              child: IconTheme(
                data: IconThemeData(
                  size: 20,
                  color: _isHovered
                      ? widget.color
                      : theme.colorScheme.onSurface.withValues(alpha: 0.7),
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
    final theme = Theme.of(context);
    
    return TextButton(
      onPressed: () => context.go(route),
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.7),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceSm,
          vertical: AppConstants.spaceXs,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}