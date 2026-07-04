import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:numeroloji/app/app_routes.dart';
import 'package:numeroloji/app/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 720;
            final horizontalPadding = isWide ? 32.0 : 20.0;
            final circleSize = (constraints.maxWidth * 0.58).clamp(180.0, 260.0);

            return DecoratedBox(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.28),
                  radius: 1.1,
                  colors: [
                    Color(0xFF2B1550),
                    AppTheme.deepPurple,
                    Color(0xFF080313),
                  ],
                ),
              ),
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  20,
                  horizontalPadding,
                  24,
                ),
                children: [
                  const _HomeHeader(),
                  SizedBox(height: isWide ? 28 : 22),
                  Center(
                    child: SizedBox.square(
                      dimension: circleSize,
                      child: const _MysticalNumberCircle(number: '7'),
                    ),
                  ),
                  SizedBox(height: isWide ? 30 : 24),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: Column(
                        children: [
                          _HomeActionCard(
                            icon: Icons.calculate_outlined,
                            title: 'Numeroloji Hesapla',
                            subtitle:
                                'Do\u011fum tarihi ve ismine g\u00f6re ki\u015fisel analizini yap.',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.calculation,
                              );
                            },
                          ),
                          _HomeActionCard(
                            icon: Icons.menu_book_outlined,
                            title: 'Say\u0131lar\u0131n Anlamlar\u0131',
                            subtitle:
                                '1\u2019den 9\u2019a kadar say\u0131 enerjilerini ke\u015ffet.',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.meanings);
                            },
                          ),
                          _HomeActionCard(
                            icon: Icons.auto_awesome_outlined,
                            title: 'G\u00fcnl\u00fck Numeroloji',
                            subtitle:
                                'Bug\u00fcn\u00fcn enerji numaras\u0131n\u0131 ve yorumunu oku.',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.daily);
                            },
                          ),
                          _HomeActionCard(
                            icon: Icons.history_outlined,
                            title: 'Ge\u00e7mi\u015f Sonu\u00e7lar',
                            subtitle:
                                '\u00d6nceki hesaplamalar\u0131n\u0131 g\u00f6r ve incele.',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.history);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              color: AppTheme.gold,
              size: 20,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                'NUMEROLOJ\u0130',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.gold,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.auto_awesome,
              color: AppTheme.gold,
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Say\u0131lar\u0131n rehberli\u011finde kendini ke\u015ffet.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.moonWhite.withValues(alpha: 0.82),
              ),
        ),
      ],
    );
  }
}

class _MysticalNumberCircle extends StatelessWidget {
  const _MysticalNumberCircle({required this.number});

  final String number;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MysticalCirclePainter(),
      child: Center(
        child: Text(
          number,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppTheme.softGold,
                fontSize: 78,
                fontWeight: FontWeight.w900,
                shadows: [
                  Shadow(
                    color: AppTheme.gold.withValues(alpha: 0.55),
                    blurRadius: 28,
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

class _MysticalCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final goldPaint = Paint()
      ..color = AppTheme.gold.withValues(alpha: 0.62)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    final softPaint = Paint()
      ..color = AppTheme.softGold.withValues(alpha: 0.26)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppTheme.gold.withValues(alpha: 0.22),
          AppTheme.gold.withValues(alpha: 0.04),
          Colors.transparent,
        ],
      ).createShader(Offset.zero & size);

    canvas.drawCircle(center, radius * 0.82, glowPaint);
    canvas.drawCircle(center, radius * 0.74, goldPaint);
    canvas.drawCircle(center, radius * 0.52, softPaint);
    canvas.drawCircle(center, radius * 0.28, softPaint);

    const points = 12;
    final orbitRadius = radius * 0.68;
    final innerRadius = radius * 0.38;
    final path = Path();

    for (var index = 0; index < points; index++) {
      final angle = (index / points) * 6.28318530718;
      final orbitPoint = Offset(
        center.dx + orbitRadius * math.cos(angle),
        center.dy + orbitRadius * math.sin(angle),
      );
      final innerPoint = Offset(
        center.dx + innerRadius * math.cos(angle + 1.57079632679),
        center.dy + innerRadius * math.sin(angle + 1.57079632679),
      );

      canvas.drawCircle(orbitPoint, 2.4, Paint()..color = AppTheme.gold);
      path
        ..moveTo(orbitPoint.dx, orbitPoint.dy)
        ..lineTo(innerPoint.dx, innerPoint.dy);
    }

    canvas.drawPath(path, softPaint);

    final crossPaint = Paint()
      ..color = AppTheme.gold.withValues(alpha: 0.36)
      ..strokeWidth = 0.8;
    canvas.drawLine(
      Offset(center.dx, radius * 0.08),
      Offset(center.dx, size.height - radius * 0.08),
      crossPaint,
    );
    canvas.drawLine(
      Offset(radius * 0.08, center.dy),
      Offset(size.width - radius * 0.08, center.dy),
      crossPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HomeActionCard extends StatelessWidget {
  const _HomeActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppTheme.cardPurple.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppTheme.gold.withValues(alpha: 0.22),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.gold.withValues(alpha: 0.12),
                  ),
                  child: Icon(icon, color: AppTheme.gold),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color:
                                  AppTheme.moonWhite.withValues(alpha: 0.72),
                              height: 1.25,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.gold.withValues(alpha: 0.14),
                    border: Border.all(
                      color: AppTheme.gold.withValues(alpha: 0.36),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppTheme.gold,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
