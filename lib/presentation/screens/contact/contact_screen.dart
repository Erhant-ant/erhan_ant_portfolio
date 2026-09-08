import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/utils/responsive.dart';
import '../../widgets/layout/app_scaffold.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      pageTitleBuilder: () =>
          localized('Contact | Erhan Ant', 'İletişim | Erhan Ant'),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pagePadding(context),
          vertical: AppConstants.space3Xl,
        ),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimateList(
                  interval: 100.ms,
                  effects: [
                    FadeEffect(duration: 500.ms, curve: Curves.easeOut),
                    SlideEffect(
                      begin: const Offset(0, 0.05),
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    ),
                  ],
                  children: [
                    Text(
                      localized('Contact', 'İletişim'),
                      style: theme.textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Text(
                      localized(
                        'Use my profiles to follow my work or connect professionally.',
                        'Çalışmalarımı takip etmek veya profesyonel olarak bağlantı kurmak için profil bilgilerimi kullanabilirsin.',
                      ),
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppConstants.space2Xl),
                    const _ContactCard(
                      icon: Icons.code,
                      title: 'GitHub',
                      value: 'github.com/Erhant-ant',
                      url: 'https://github.com/Erhant-ant',
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    const _ContactCard(
                      icon: Icons.business_center_outlined,
                      title: 'LinkedIn',
                      value: 'linkedin.com/in/erhan-ant-328380359',
                      url: 'https://www.linkedin.com/in/erhan-ant-328380359',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.url,
  });

  final IconData icon;
  final String title;
  final String value;
  final String url;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  Future<void> _openLink(BuildContext context) async {
    final opened = await launchUrl(
      Uri.parse(widget.url),
      webOnlyWindowName: '_blank',
    );

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localized(
              '${widget.title} could not be opened.',
              '${widget.title} bağlantısı açılamadı.',
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppConstants.durationNormal,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: _isHovered ? accent.withValues(alpha: 0.6) : theme.colorScheme.outline,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.12),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(AppConstants.spaceLg),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(widget.icon, size: 28, color: accent),
          ),
          title: Text(widget.title, style: theme.textTheme.displaySmall),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: AppConstants.spaceXs),
            child: Text(widget.value),
          ),
          onTap: () => _openLink(context),
          trailing: IconButton(
            tooltip: localized('Copy', 'Kopyala'),
            icon: const Icon(Icons.copy_outlined),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.value));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localized(
                      '${widget.title} link copied.',
                      '${widget.title} bağlantısı kopyalandı.',
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
