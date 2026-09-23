import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_language.dart';
import '../../../../core/utils/responsive.dart';

class CurrentFocusSection extends StatefulWidget {
  const CurrentFocusSection({super.key});

  @override
  State<CurrentFocusSection> createState() => _CurrentFocusSectionState();
}

class _CurrentFocusSectionState extends State<CurrentFocusSection> {
  // Yörüngenin dönüş açısını tutar. 0 = Ön, pi/2 = Sağ, pi = Arka, -pi/2 = Sol
  double _targetAngle = 0.0;
  Timer? _timer;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // 5 Saniyede bir otomatik sağdan sola dönüş
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted && !_isHovering) {
        setState(() {
          _targetAngle -= math.pi / 2;
        });
      }
    });
  }

  // Tıklama yapıldığında süreyi sıfırlar
  void _resetTimer() {
    if (!_isHovering) {
      _startTimer();
    }
  }

  // Sağ oka tıklandığında sağdaki gezegeni öne getirir
  void _rotateRight() {
    setState(() {
      _targetAngle -= math.pi / 2;
    });
    _resetTimer();
  }

  // Sol oka tıklandığında soldaki gezegeni öne getirir
  void _rotateLeft() {
    setState(() {
      _targetAngle += math.pi / 2;
    });
    _resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final items = _focusItems(theme);
    final isMobile = Responsive.isMobile(context);

    // Dinamik Yörünge Boyutları (Ekrandan taşmaması için)
    final screenWidth = MediaQuery.sizeOf(context).width;
    // Oklar ve boşluklar için alanı hesaplıyoruz
    final availableWidth = math.max(280.0, screenWidth - (isMobile ? 120.0 : 200.0)); 
    final radiusX = availableWidth / 2;
    final radiusY = isMobile ? 70.0 : 120.0;
    
    // Merkezdeki büyük kürenin boyutu
    final baseItemSize = isMobile ? 240.0 : 300.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0B0F19) : theme.colorScheme.surface,
      ),
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          // --- Header ---
          Text(
            localized('Core Expertise', 'Temel Odak Noktalarım'),
            style: theme.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, curve: Curves.easeOut),
          
          const SizedBox(height: AppConstants.spaceSm),
          
          Text(
            localized(
              'Explore my orbit of active development and engineering focuses.',
              'Geliştirdiğim teknolojileri ve mühendislik yörüngemi keşfedin.',
            ),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 100.ms, duration: 600.ms).slideY(begin: 0.2, curve: Curves.easeOut),
          
          const SizedBox(height: 64),

          // --- 3D YÖRÜNGE (ORBIT) ALANI ---
          MouseRegion(
            onEnter: (_) {
              setState(() => _isHovering = true);
              _timer?.cancel(); // Fare gelince otopilot durur
            },
            onExit: (_) {
              setState(() => _isHovering = false);
              _startTimer(); // Fare çıkınca otopilot devam eder
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sol Ok
                _OrbitNavButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: _rotateLeft,
                  color: primary,
                ),
                
                // Merkezdeki Yörünge Sistemi
                Expanded(
                  child: SizedBox(
                    height: baseItemSize + (radiusY * 2), // Sistemin toplam yüksekliği
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(end: _targetAngle),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOutCubic,
                      builder: (context, animatedAngle, child) {
                        
                        // 1. Öğelerin pozisyonlarını ve derinliklerini hesaplıyoruz
                        List<Map<String, dynamic>> orbitData = [];
                        
                        for (int i = 0; i < items.length; i++) {
                          // Matematik: Her bir öğe arasında 90 derece (pi/2) var.
                          double baseAngle = i * math.pi / 2;
                          double currentAngle = baseAngle + animatedAngle;

                          double cosA = math.cos(currentAngle); // Derinlik ve Y ekseni
                          double sinA = math.sin(currentAngle); // X ekseni

                          // Pozisyonlar
                          double x = sinA * radiusX;
                          double y = cosA * radiusY;

                          // Ölçek ve Görünürlük (Öndeyken büyük ve net, arkadayken küçük ve silik)
                          // cosA: 1 (Ön) ile -1 (Arka) arasında değişir.
                          double scale = 0.65 + ((cosA + 1) / 2) * 0.35; 
                          double opacity = 0.3 + ((cosA + 1) / 2) * 0.7; 
                          bool isFront = cosA > 0.8;

                          orbitData.add({
                            'item': items[i],
                            'x': x,
                            'y': y,
                            'scale': scale,
                            'opacity': opacity,
                            'z': cosA, // Z-index için sıralama referansı
                            'isFront': isFront,
                          });
                        }

                        // Arkadaki öğelerin altta, öndekilerin üstte çizilmesi için Z değerine göre sıralıyoruz
                        orbitData.sort((a, b) => (a['z'] as double).compareTo(b['z'] as double));

                        // 2. Çizim (Stack)
                        return Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            // Yörünge Çizgisi (Arkaplan Elipsi)
                            Positioned(
                              child: Container(
                                width: radiusX * 2,
                                height: radiusY * 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.elliptical(radiusX * 2, radiusY * 2)),
                                  border: Border.all(
                                    color: primary.withValues(alpha: 0.15),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary.withValues(alpha: 0.05),
                                      blurRadius: 30,
                                      spreadRadius: 10,
                                    )
                                  ]
                                ),
                              ),
                            ),
                            
                            // Gezegenler (Küreler)
                            ...orbitData.map((data) {
                              return Transform.translate(
                                offset: Offset(data['x'] as double, data['y'] as double),
                                child: Transform.scale(
                                  scale: data['scale'] as double,
                                  child: Opacity(
                                    opacity: data['opacity'] as double,
                                    child: _FocusBubble(
                                      item: data['item'] as _FocusItem,
                                      isActive: data['isFront'] as bool,
                                      size: baseItemSize,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                
                // Sağ Ok
                _OrbitNavButton(
                  icon: Icons.chevron_right_rounded,
                  onTap: _rotateRight,
                  color: primary,
                ),
              ],
            ),
          ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
        ],
      ),
    );
  }

  List<_FocusItem> _focusItems(ThemeData theme) {
    return [
      _FocusItem(
        icon: Icons.sports_esports_rounded,
        title: localized('Game Dev', 'Oyun Geliştirme'),
        description: localized(
          'Crafting immersive game mechanics, systems, and large-scale interactive digital worlds.',
          'Sürükleyici oyun mekanikleri, sistemler ve büyük ölçekli interaktif dünyalar tasarlıyorum.',
        ),
        color: const Color(0xFF10B981), // Emerald
      ),
      _FocusItem(
        icon: Icons.code_rounded,
        title: localized('App & Web', 'Uygulama & Web'),
        description: localized(
          'Building modern, full-stack, and responsive applications for web and mobile platforms.',
          'Web ve mobil için modern, full-stack ve responsive uygulamalar geliştiriyorum.',
        ),
        color: theme.colorScheme.primary, // Blue
      ),
      _FocusItem(
        icon: Icons.dns_rounded,
        title: localized('IT & Systems', 'IT & Sistemler'),
        description: localized(
          'Ensuring robust infrastructure, networking, and support for seamless digital operations.',
          'Kesintisiz dijital operasyonlar için güçlü altyapı, ağ ve sistem desteği sağlıyorum.',
        ),
        color: theme.colorScheme.secondary, // Purple
      ),
      _FocusItem(
        icon: Icons.smart_toy_rounded,
        title: localized('Automation', 'Otomasyon & AI'),
        description: localized(
          'Writing scripts and integrating AI tools to automate workflows and maximize efficiency.',
          'İş akışlarını otomatize etmek ve verimliliği artırmak için scriptler ve yapay zeka araçları kullanıyorum.',
        ),
        color: const Color(0xFFF59E0B), // Amber
      ),
    ];
  }
}

// --- Sol/Sağ Navigasyon Butonları ---
class _OrbitNavButton extends StatefulWidget {
  const _OrbitNavButton({required this.icon, required this.onTap, required this.color});

  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  State<_OrbitNavButton> createState() => _OrbitNavButtonState();
}

class _OrbitNavButtonState extends State<_OrbitNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isMobile ? 48 : 64,
          height: isMobile ? 48 : 64,
          margin: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 24),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            color: _isHovered 
                ? widget.color.withValues(alpha: 0.2) 
                : (isDark ? const Color(0xFF131B2A) : theme.colorScheme.surface),
            border: Border.all(
              color: _isHovered 
                  ? widget.color 
                  : theme.colorScheme.outline.withValues(alpha: 0.5),
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: _isHovered
                ? [BoxShadow(color: widget.color.withValues(alpha: 0.3), blurRadius: 20)]
                : [],
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? widget.color : theme.colorScheme.onSurface,
            size: isMobile ? 28 : 36,
          ),
        ),
      ),
    );
  }
}

// --- Yörüngedeki Küreler (Gezegenler) ---
class _FocusBubble extends StatelessWidget {
  const _FocusBubble({
    required this.item,
    required this.isActive,
    required this.size,
  });

  final _FocusItem item;
  final bool isActive;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const duration = Duration(milliseconds: 500);

    return Container(
      width: size, 
      height: size, 
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Senin istediğin o harika ışıklandırma ve görsel efektler burada
        gradient: RadialGradient(
          center: const Alignment(-0.2, -0.3),
          radius: 1.2,
          colors: [
            item.color.withValues(alpha: isActive ? 0.3 : 0.08),
            isDark ? const Color(0xFF0F1523) : theme.colorScheme.surface,
          ],
        ),
        border: Border.all(
          color: isActive 
              ? item.color 
              : theme.colorScheme.outline.withValues(alpha: 0.3),
          width: isActive ? 3 : 1.5,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: item.color.withValues(alpha: 0.35),
                  blurRadius: 50,
                  spreadRadius: 5,
                ),
              ]
            : const [],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spaceLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // İkon her zaman görünür
            AnimatedContainer(
              duration: duration,
              width: isActive ? 72 : 56,
              height: isActive ? 72 : 56,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                boxShadow: isActive ? [
                   BoxShadow(color: item.color.withValues(alpha: 0.4), blurRadius: 20)
                ] : [],
              ),
              child: Icon(item.icon, color: item.color, size: isActive ? 36 : 28),
            ),
            
            // Sadece öndeyken görünen metinler
            AnimatedOpacity(
              duration: duration,
              opacity: isActive ? 1.0 : 0.0,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    item.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.description,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  AnimatedContainer(
                    duration: duration,
                    height: 4,
                    width: 48,
                    decoration: BoxDecoration(
                      color: item.color,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ],
              ),
            ),
          ],
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