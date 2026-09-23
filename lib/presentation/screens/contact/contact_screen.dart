import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final primary = theme.colorScheme.primary;

    return AppScaffold(
      pageTitleBuilder: () =>
          localized('Contact | Erhan Ant', 'İletişim | Erhan Ant'),
      body: PageScrollWrapper(
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
                      localized('Let\'s Build Together', 'Birlikte İnşa Edelim'),
                      style: theme.textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppConstants.spaceMd),
                    Text(
                      localized(
                        'Whether you have a game concept, a software project, or an IT infrastructure need, I am open to discussing new opportunities.',
                        'Bir oyun konseptiniz, yazılım projeniz veya IT altyapısı ihtiyacınız varsa, yeni fırsatları değerlendirmeye açığım.',
                      ),
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                    ),
                    const SizedBox(height: AppConstants.space3Xl),
                    
                    // Email Card
                    _ContactCard(
                      iconWidget: const Icon(Icons.email_rounded),
                      title: localized('Email', 'E-Posta'),
                      value: 'erhanant@example.com', // KENDİ MAİLİNİ YAZ
                      url: 'mailto:erhanant@example.com', // KENDİ MAİLİNİ YAZ
                      color: primary,
                    ),
                    const SizedBox(height: AppConstants.spaceLg),
                    _ContactCard(
                      iconWidget: const FaIcon(FontAwesomeIcons.github),
                      title: 'GitHub',
                      value: 'github.com/Erhant-ant',
                      url: 'https://github.com/Erhant-ant',
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(height: AppConstants.spaceLg),
                    _ContactCard(
                      iconWidget: const FaIcon(FontAwesomeIcons.linkedinIn),
                      title: 'LinkedIn',
                      value: 'linkedin.com/in/erhan-ant-328380359',
                      url: 'https://www.linkedin.com/in/erhan-ant-328380359',
                      color: const Color(0xFF0A66C2), // LinkedIn Blue
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
    required this.iconWidget,
    required this.title,
    required this.value,
    required this.url,
    required this.color,
  });

  final Widget iconWidget;
  final String title;
  final String value;
  final String url;
  final Color color;

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
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppConstants.durationNormal,
        curve: Curves.easeOutCubic, // Animasyon eğrisi daha pürüzsüz yapıldı
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF131B2A) : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? widget.color : theme.colorScheme.outline.withValues(alpha: 0.5),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.2),
                    blurRadius: 30,
                    spreadRadius: 2,
                    offset: const Offset(0, 4)
                  ),
                ]
              : [],
        ),
        // HATA BURADAYDI, DOĞRUSU:
        transform: Matrix4.translationValues(0, _isHovered ? -6.0 : 0.0, 0),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          leading: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: widget.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: widget.color.withValues(alpha: 0.3)),
            ),
            child: IconTheme(
              data: IconThemeData(color: widget.color, size: 24),
              child: widget.iconWidget,
            ),
          ),
          title: Text(widget.title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              widget.value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onTap: () => _openLink(context),
          trailing: IconButton(
            tooltip: localized('Copy', 'Kopyala'),
            icon: Icon(Icons.copy_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.value));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localized(
                      '${widget.title} copied to clipboard.',
                      '${widget.title} panoya kopyalandı.',
                    ),
                  ),
                  backgroundColor: widget.color,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}