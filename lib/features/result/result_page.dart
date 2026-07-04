import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:numeroloji/app/app_theme.dart';
import 'package:numeroloji/data/models/numerology_result_model.dart';
import 'package:numeroloji/data/repositories/history_repository.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final _historyRepository = HistoryRepository();
  bool _savedToHistory = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeResult = ModalRoute.of(context)?.settings.arguments;
    if (!_savedToHistory && routeResult is NumerologyResultModel) {
      _savedToHistory = true;
      _historyRepository.saveResult(routeResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeResult = ModalRoute.of(context)?.settings.arguments;

    if (routeResult is! NumerologyResultModel) {
      return Scaffold(
        appBar: AppBar(title: const Text('Sonu\u00e7lar\u0131n')),
        body: const Center(
          child: Text('Hen\u00fcz hesaplama sonucu bulunamad\u0131.'),
        ),
      );
    }

    final primaryNumber = routeResult.lifePathNumber;
    final resultCards = [
      _ResultCardData(
        title: 'Ya\u015fam Yolu',
        number: routeResult.lifePathNumber,
        icon: Icons.route_outlined,
      ),
      _ResultCardData(
        title: 'Kader Say\u0131s\u0131',
        number: routeResult.destinyNumber,
        icon: Icons.auto_awesome_outlined,
      ),
      _ResultCardData(
        title: 'Ruh Arzusu',
        number: routeResult.soulUrgeNumber,
        icon: Icons.favorite_border_rounded,
      ),
      _ResultCardData(
        title: 'Ki\u015filik Say\u0131s\u0131',
        number: routeResult.personalityNumber,
        icon: Icons.person_outline,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Sonu\u00e7lar\u0131n')),
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.34),
              radius: 1.15,
              colors: [
                Color(0xFF2B1550),
                AppTheme.deepPurple,
                Color(0xFF070310),
              ],
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth >= 720 ? 620.0 : 520.0;
              final circleSize = (constraints.maxWidth * 0.48).clamp(
                164.0,
                230.0,
              );

              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Column(
                        children: [
                          Text(
                            'Sonu\u00e7lar\u0131n',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Genel Bak\u0131\u015f',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppTheme.moonWhite.withValues(
                                    alpha: 0.78,
                                  ),
                                ),
                          ),
                          const SizedBox(height: 22),
                          SizedBox.square(
                            dimension: circleSize,
                            child: _MysticResultCircle(
                              number: primaryNumber.displayValue,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Text(
                            'Ya\u015fam Yolu Say\u0131n',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: AppTheme.gold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _lifePathDescription(
                              routeResult.fullName,
                              primaryNumber.value,
                            ),
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppTheme.moonWhite.withValues(
                                        alpha: 0.86,
                                      ),
                                    ),
                          ),
                          const SizedBox(height: 24),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: resultCards.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: constraints.maxWidth >= 520 ? 4 : 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio:
                                  constraints.maxWidth >= 520 ? 1.08 : 1.26,
                            ),
                            itemBuilder: (context, index) {
                              return _MiniResultCard(data: resultCards[index]);
                            },
                          ),
                          const SizedBox(height: 18),
                          FilledButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Detayl\u0131 yorum ekran\u0131 yak\u0131nda eklenecek.',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.auto_awesome),
                            label: const Text('DETAYLI YORUMU OKU'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _lifePathDescription(String fullName, int number) {
    final firstName = fullName.trim().split(RegExp(r'\s+')).firstOrNull;
    final prefix = firstName == null || firstName.isEmpty ? '' : '$firstName, ';
    final descriptions = {
      1: 'ba\u011f\u0131ms\u0131z, cesur ve ba\u015flat\u0131c\u0131 bir enerji ta\u015f\u0131yorsun. Yeni yollar a\u00e7mak ve liderlik etmek senin do\u011fal alan\u0131n.',
      2: 'uyumlu, sezgileri g\u00fc\u00e7l\u00fc ve ili\u015fkilerde denge kuran bir yap\u0131ya sahipsin. Sab\u0131r ve anlay\u0131\u015f seni parlat\u0131r.',
      3: 'yarat\u0131c\u0131, ifade g\u00fcc\u00fc y\u00fcksek ve sosyal bir enerjiye sahipsin. Duygular\u0131n\u0131 payla\u015ft\u0131k\u00e7a alan\u0131n geni\u015fler.',
      4: 'planl\u0131, g\u00fcvenilir ve emekle kal\u0131c\u0131 yap\u0131lar kuran bir enerjin var. Disiplin senin kap\u0131 anahtar\u0131n.',
      5: '\u00f6zg\u00fcr ruhlu, merakl\u0131 ve de\u011fi\u015fimle beslenen bir yoldas\u0131n. Esneklik sana yeni f\u0131rsatlar getirir.',
      6: 'koruyucu, sevgi dolu ve sorumluluk bilinci y\u00fcksek bir enerji ta\u015f\u0131yorsun. Kalbinle kurdu\u011fun ba\u011flar g\u00fc\u00e7l\u00fc.',
      7: 'analitik, sezgisel ve i\u00e7 d\u00fcnyas\u0131 derin bir yap\u0131ya sahipsin. Ger\u00e7e\u011fi arama iste\u011fin sana rehberlik eder.',
      8: 'hedef odakl\u0131, g\u00fc\u00e7l\u00fc ve maddi d\u00fcnyada etki olu\u015fturabilen bir enerjin var. Kararl\u0131l\u0131k seni ba\u015far\u0131ya ta\u015f\u0131r.',
      9: 'idealistsin; \u015fefkat, tamamlama ve kolektife katk\u0131 enerjisi ta\u015f\u0131yorsun. Deneyimlerini bilgeli\u011fe d\u00f6n\u00fc\u015ft\u00fcr\u00fcrs\u00fcn.',
    };

    return '$prefix${descriptions[number] ?? descriptions[7]}';
  }
}

class _MysticResultCircle extends StatelessWidget {
  const _MysticResultCircle({required this.number});

  final String number;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MysticResultCirclePainter(),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            number,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.softGold,
                  fontSize: 96,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      color: AppTheme.gold.withValues(alpha: 0.55),
                      blurRadius: 26,
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}

class _MysticResultCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppTheme.gold.withValues(alpha: 0.24),
          AppTheme.gold.withValues(alpha: 0.07),
          Colors.transparent,
        ],
      ).createShader(Offset.zero & size);
    final linePaint = Paint()
      ..color = AppTheme.gold.withValues(alpha: 0.42)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;
    final brightPaint = Paint()
      ..color = AppTheme.gold
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.95, glowPaint);
    canvas.drawCircle(center, radius * 0.78, linePaint);
    canvas.drawCircle(center, radius * 0.55, linePaint);
    canvas.drawCircle(center, radius * 0.32, linePaint);

    final geometryPath = Path();
    const pointCount = 8;
    final points = <Offset>[];
    for (var index = 0; index < pointCount; index++) {
      final angle = -math.pi / 2 + (index / pointCount) * math.pi * 2;
      points.add(
        Offset(
          center.dx + math.cos(angle) * radius * 0.72,
          center.dy + math.sin(angle) * radius * 0.72,
        ),
      );
    }

    for (var index = 0; index < points.length; index++) {
      final current = points[index];
      final next = points[(index + 2) % points.length];
      geometryPath
        ..moveTo(current.dx, current.dy)
        ..lineTo(next.dx, next.dy);
      canvas.drawCircle(current, 2.4, brightPaint);
    }

    canvas.drawPath(geometryPath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MiniResultCard extends StatelessWidget {
  const _MiniResultCard({required this.data});

  final _ResultCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardPurple.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.gold.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data.icon, color: AppTheme.gold, size: 20),
          const SizedBox(height: 7),
          Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            data.number.displayValue,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.gold,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }
}

class _ResultCardData {
  const _ResultCardData({
    required this.title,
    required this.number,
    required this.icon,
  });

  final String title;
  final NumerologyNumber number;
  final IconData icon;
}
