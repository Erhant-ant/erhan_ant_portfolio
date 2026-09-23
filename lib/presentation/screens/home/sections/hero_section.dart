import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_language.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/seo_service.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  Offset _mouseOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    // Sayfa açıldığında SEO Metasını dinamik güncelliyoruz
    
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final heroMinHeight = MediaQuery.sizeOf(context).height - AppConstants.headerHeight;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        Responsive.pagePadding(context),
        AppConstants.spaceLg,
        Responsive.pagePadding(context),
        AppConstants.space3Xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          // Fare hareketlerini algılayan kapsayıcı
          child: MouseRegion(
            onHover: (event) {
              if (!isMobile) {
                setState(() {
                  // Ekran merkezine göre farenin X ve Y sapmasını hesaplıyoruz
                  final size = MediaQuery.sizeOf(context);
                  final dx = (event.position.dx - (size.width / 2)) / 50; 
                  final dy = (event.position.dy - (size.height / 2)) / 50;
                  _mouseOffset = Offset(dx, dy);
                });
              }
            },
            onExit: (_) {
              setState(() => _mouseOffset = Offset.zero); // Çıkınca sıfırla
            },
            child: _HeroFrame(
              minHeight: isMobile ? null : heroMinHeight - AppConstants.spaceLg,
              isMobile: isMobile,
              mouseOffset: _mouseOffset,
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroFrame extends StatelessWidget {
  const _HeroFrame({
    required this.minHeight, 
    required this.isMobile,
    required this.mouseOffset,
  });

  final double? minHeight;
  final bool isMobile;
  final Offset mouseOffset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final accent = theme.colorScheme.secondary;
    
    final frameBackground = isDark ? const Color(0xFF0F1523) : const Color(0xFFF1F5F9);

    return Container(
      constraints: BoxConstraints(minHeight: minHeight ?? 0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: frameBackground,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
        boxShadow: isDark ? [
          BoxShadow(color: primary.withValues(alpha: 0.05), blurRadius: 40, spreadRadius: 5)
        ] : [],
      ),
      child: Stack(
        children: [
          // PARALLAX ETKİSİ 1: Arka plan orbları fareye ters yönde hareket eder
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            top: -120 - (mouseOffset.dy * 1.5),
            right: -90 - (mouseOffset.dx * 1.5),
            child: _AccentOrb(color: primary, size: 350)
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 4.seconds),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            bottom: -160 + (mouseOffset.dy * 2),
            left: -110 + (mouseOffset.dx * 2),
            child: _AccentOrb(color: accent, size: 300)
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .scale(begin: const Offset(1, 1), end: const Offset(1.08, 1.08), duration: 5.seconds),
          ),
          
          Positioned(
            top: 28,
            right: 32,
            child: Text(
              'EA / ${DateTime.now().year}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isMobile ? AppConstants.spaceLg : 56),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _HeroContent(),
                      const SizedBox(height: AppConstants.space2Xl),
                      Center(child: SizedBox(width: 290, child: _ProfilePanel(mouseOffset: mouseOffset))),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(flex: 12, child: _HeroContent()),
                      const SizedBox(width: AppConstants.space3Xl),
                      Expanded(flex: 9, child: _ProfilePanel(mouseOffset: mouseOffset)),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(
          icon: Icons.code_rounded,
          label: localized('Software & Game Developer', 'Yazılım ve Oyun Geliştirici'),
        ),
        const SizedBox(height: AppConstants.spaceLg),
        Text(
          localized('Building digital worlds & robust systems.', 'Dijital dünyalar ve güçlü sistemler inşa ediyorum.'),
          style: theme.textTheme.displayMedium?.copyWith(
            fontSize: Responsive.isMobile(context) ? 36 : 48,
            fontWeight: FontWeight.w800,
            height: 1.05,
            letterSpacing: -1.2,
          ),
        ),
        const SizedBox(height: AppConstants.spaceMd),
        Text.rich(
          TextSpan(
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 28,
            ),
            children: [
              const TextSpan(text: 'EANT Studio'),
              TextSpan(text: '.', style: TextStyle(color: accent)),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spaceLg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            localized(
              'I am a versatile developer bridging the gap between game development, full-stack software, and IT infrastructure. From crafting immersive games to automating complex systems, I build with passion and precision.',
              'Oyun geliştirme, full-stack yazılım ve IT altyapısı arasında köprü kuran çok yönlü bir geliştiriciyim. Sürükleyici oyunlar tasarlamaktan sistem otomasyonlarına kadar her detayı tutkuyla üretiyorum.',
            ),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.78),
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spaceXl),
        Wrap(
          spacing: AppConstants.spaceSm,
          runSpacing: AppConstants.spaceSm,
          children: [
            _SkillPill(label: 'Game Development', color: theme.colorScheme.primary),
            _SkillPill(label: 'Full Stack App', color: accent),
            _SkillPill(label: 'IT & Automation', color: theme.colorScheme.tertiary ?? Colors.teal),
          ],
        ),
        const SizedBox(height: AppConstants.spaceXl),
        Wrap(
          spacing: AppConstants.spaceMd,
          runSpacing: AppConstants.spaceSm,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                context.go(AppRoutes.projects);
              },
              icon: const Icon(Icons.rocket_launch_rounded),
              label: Text(localized('Explore Projects', 'Projeleri Keşfet')),
            ),
            OutlinedButton.icon(
              onPressed: () {
                context.go(AppRoutes.about);
              },
              icon: const Icon(Icons.person_outline),
              label: Text(localized('About Me', 'Hakkımda')),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spaceLg),
        TextButton.icon(
          onPressed: () {
            context.go(AppRoutes.cv);
          },
          icon: const Icon(Icons.description_rounded),
          label: Text(localized('View full CV', 'Tüm özgeçmişimi incele')),
        ),
      ],
    );
  }
}

// ( _SectionLabel, _SkillPill, _AccentOrb sınıfları değişmediği için alanı şişirmemek adına aynı kalacak, onları eklemeye devam et)

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: primary),
          const SizedBox(width: 8),
          Text(label.toUpperCase(), style: theme.textTheme.bodySmall?.copyWith(color: primary, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
        ],
      ),
    );
  }
}

class _SkillPill extends StatelessWidget {
  const _SkillPill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMd, vertical: AppConstants.spaceSm),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), border: Border.all(color: color.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(AppConstants.radiusFull)),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w700)),
    );
  }
}

class _AccentOrb extends StatelessWidget {
  const _AccentOrb({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color.withValues(alpha: 0.25), color.withValues(alpha: 0)]),
      ),
    );
  }
}

class _ProfilePanel extends StatelessWidget {
  const _ProfilePanel({required this.mouseOffset});
  final Offset mouseOffset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    // PARALLAX ETKİSİ 2: Kapsül fare ile aynı yönde, resim biraz daha yavaş hareket eder (3D Katman Hissi)
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(mouseOffset.dx * 1.2, mouseOffset.dy * 1.2, 0),
      child: AspectRatio(
        aspectRatio: 0.82,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: accent.withValues(alpha: 0.4), width: 2),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(color: accent.withValues(alpha: 0.15), blurRadius: 30, spreadRadius: 2)
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  // GÜNCELLEME: WEBP OPTİMİZASYONU
                  child: Image.asset(
                    'assets/images/profile.webp', // Lütfen dosyanı webp formatına çevir!
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    semanticLabel: 'Portrait of Erhan Ant',
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: theme.colorScheme.surface, child: Icon(Icons.person_outline, size: 72, color: accent));
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -18,
              left: -18,
              // Bu badge (etiket) fareye biraz daha agresif tepki vererek derinlik hissini artırır
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.translationValues(mouseOffset.dx * 2.5, mouseOffset.dy * 2.5, 0),
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMd, vertical: AppConstants.spaceSm),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppConstants.radiusLg),
                  border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.terminal_rounded, size: 20, color: accent),
                    const SizedBox(width: AppConstants.spaceSm),
                    Text(localized('Building in public', 'Üreterek gelişiyor'), style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}