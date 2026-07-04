import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numeroloji/app/app_theme.dart';

class DailyNumerologyPage extends StatelessWidget {
  const DailyNumerologyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dailyNumber = _calculateDailyNumber(today);
    final dailyReading = _DailyReading.byNumber(dailyNumber);
    final shareText =
        'Bug\u00fcn\u00fcn numeroloji say\u0131s\u0131: $dailyNumber\n'
        '${dailyReading.comment}';

    return Scaffold(
      appBar: AppBar(title: const Text('G\u00fcnl\u00fck Numeroloji')),
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.35),
              radius: 1.2,
              colors: [
                Color(0xFF2B1550),
                AppTheme.deepPurple,
                Color(0xFF070310),
              ],
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView(
                padding: EdgeInsets.fromLTRB(
                  constraints.maxWidth >= 720 ? 32 : 20,
                  16,
                  constraints.maxWidth >= 720 ? 32 : 20,
                  28,
                ),
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: Column(
                        children: [
                          _DateHeader(date: today),
                          const SizedBox(height: 18),
                          _DailyNumberCard(number: dailyNumber),
                          const SizedBox(height: 14),
                          _ContentPanel(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'G\u00fcn\u00fcn Yorumu',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  dailyReading.comment,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppTheme.moonWhite.withValues(
                                          alpha: 0.84,
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          _ContentPanel(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\u00d6neriler',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 10),
                                for (final suggestion
                                    in dailyReading.suggestions) ...[
                                  _SuggestionTile(text: suggestion),
                                  const SizedBox(height: 8),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          FilledButton.icon(
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(text: shareText),
                              );
                              if (!context.mounted) {
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'G\u00fcnl\u00fck yorum panoya kopyaland\u0131.',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.share_outlined),
                            label: const Text('PAYLA\u015e'),
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

  int _calculateDailyNumber(DateTime date) {
    final digits = '${date.day}${date.month}${date.year}'.split('');
    final total = digits.fold<int>(0, (sum, digit) => sum + int.parse(digit));
    return _reduceToSingleDigit(total);
  }

  int _reduceToSingleDigit(int value) {
    var reduced = value;
    while (reduced > 9) {
      reduced = reduced
          .toString()
          .split('')
          .fold<int>(0, (sum, digit) => sum + int.parse(digit));
    }
    return reduced;
  }
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _formatDate(date),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.gold,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Bug\u00fcn\u00fcn Numeroloji Say\u0131s\u0131',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.moonWhite.withValues(alpha: 0.72),
              ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month.${date.year}';
  }
}

class _DailyNumberCard extends StatelessWidget {
  const _DailyNumberCard({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: AppTheme.cardPurple.withValues(alpha: 0.74),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppTheme.gold.withValues(alpha: 0.24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.gold.withValues(alpha: 0.08),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned.fill(child: _DailyOrbit()),
          Text(
            '$number',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.softGold,
                  fontSize: 92,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      color: AppTheme.gold.withValues(alpha: 0.5),
                      blurRadius: 26,
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}

class _DailyOrbit extends StatelessWidget {
  const _DailyOrbit();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DailyOrbitPainter(),
    );
  }
}

class _DailyOrbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.34;
    final linePaint = Paint()
      ..color = AppTheme.gold.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final dotPaint = Paint()
      ..color = AppTheme.gold.withValues(alpha: 0.84)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, linePaint);
    canvas.drawCircle(center, radius * 0.68, linePaint);
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      linePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      linePaint,
    );

    canvas.drawCircle(Offset(center.dx - radius, center.dy), 2.6, dotPaint);
    canvas.drawCircle(Offset(center.dx + radius, center.dy), 2.6, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ContentPanel extends StatelessWidget {
  const _ContentPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardPurple.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.gold.withValues(alpha: 0.18),
        ),
      ),
      child: child,
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Icon(
            Icons.auto_awesome,
            color: AppTheme.gold,
            size: 15,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.moonWhite.withValues(alpha: 0.82),
                ),
          ),
        ),
      ],
    );
  }
}

class _DailyReading {
  const _DailyReading({
    required this.comment,
    required this.suggestions,
  });

  final String comment;
  final List<String> suggestions;

  static _DailyReading byNumber(int number) {
    return _readings[number] ?? _readings[1]!;
  }

  static const Map<int, _DailyReading> _readings = {
    1: _DailyReading(
      comment:
          'Bug\u00fcn yeni ba\u015flang\u0131\u00e7lar, cesur kararlar ve ki\u015fisel inisiyatif i\u00e7in destekleyici bir enerji ta\u015f\u0131yor.',
      suggestions: [
        'Erteledi\u011fin bir konu i\u00e7in ilk ad\u0131m\u0131 at.',
        'Kendi fikrini net ve sakin \u015fekilde ifade et.',
        'G\u00fcn\u00fcn\u00fc tek bir ana hedefe odakla.',
      ],
    ),
    2: _DailyReading(
      comment:
          'Bug\u00fcn uyum, sab\u0131r ve ili\u015fkilerde denge kurma temas\u0131 \u00f6ne \u00e7\u0131k\u0131yor.',
      suggestions: [
        'Dinlemeye ve ortak karar almaya alan a\u00e7.',
        'Aceleden uzak dur, ritmini yumu\u015fat.',
        'Sezgilerinin verdi\u011fi ince i\u015faretleri fark et.',
      ],
    ),
    3: _DailyReading(
      comment:
          'Bug\u00fcn ifade, yarat\u0131c\u0131l\u0131k ve sosyal ak\u0131\u015f a\u00e7\u0131s\u0131ndan canl\u0131 bir enerji var.',
      suggestions: [
        'Yarat\u0131c\u0131 bir fikri not al veya payla\u015f.',
        'Kendini daha renkli ve a\u00e7\u0131k ifade et.',
        'Moralini y\u00fckselten insanlarla temas kur.',
      ],
    ),
    4: _DailyReading(
      comment:
          'Bug\u00fcn planlama, d\u00fczen kurma ve sorumluluklar\u0131 tamamlama i\u00e7in g\u00fc\u00e7l\u00fc bir zemin sunuyor.',
      suggestions: [
        'Da\u011f\u0131n\u0131k bir alan\u0131 veya listeyi toparla.',
        'Uzun vadeli hedefin i\u00e7in pratik bir ad\u0131m at.',
        'S\u00f6z verdi\u011fin bir i\u015fi tamamla.',
      ],
    ),
    5: _DailyReading(
      comment:
          'Bug\u00fcn de\u011fi\u015fim, hareket ve yeni deneyimlere a\u00e7\u0131k olma enerjisi ta\u015f\u0131yor.',
      suggestions: [
        'Rutinini k\u00fc\u00e7\u00fck ama ferahlat\u0131c\u0131 bir \u015fekilde de\u011fi\u015ftir.',
        'Yeni bir fikir veya f\u0131rsat\u0131 ara\u015ft\u0131r.',
        'Esnek kal, beklenmedik geli\u015fmelere alan a\u00e7.',
      ],
    ),
    6: _DailyReading(
      comment:
          'Bug\u00fcn sevgi, aile, destek ve sorumluluk bilinci daha belirgin hissedilebilir.',
      suggestions: [
        'Yak\u0131n oldu\u011fun biriyle samimi bir temas kur.',
        'Ev veya ki\u015fisel alan\u0131n\u0131 g\u00fczelle\u015ftir.',
        'Kendine de \u015fefkat g\u00f6stermeyi unutma.',
      ],
    ),
    7: _DailyReading(
      comment:
          'Bug\u00fcn i\u00e7e d\u00f6nme, analiz etme ve sezgilerini dinleme i\u00e7in derin bir enerji var.',
      suggestions: [
        'K\u0131sa bir sessizlik veya meditasyon molas\u0131 ver.',
        'Ara\u015ft\u0131rma isteyen bir konuya odaklan.',
        'Cevab\u0131 d\u0131\u015far\u0131da de\u011fil, i\u00e7 sesinde ara.',
      ],
    ),
    8: _DailyReading(
      comment:
          'Bug\u00fcn hedeflere odaklanmak, planlar\u0131 somutla\u015ft\u0131rmak ve maddi konularda netle\u015fmek i\u00e7in g\u00fc\u00e7l\u00fc bir enerji var.',
      suggestions: [
        'Finansal konularda dikkatli ve net karar al.',
        'Kendine g\u00fcven ve pes etmeden ilerle.',
        'Yeni f\u0131rsatlara a\u00e7\u0131k ol.',
      ],
    ),
    9: _DailyReading(
      comment:
          'Bug\u00fcn tamamlanma, b\u0131rakma ve daha geni\u015f bir bak\u0131\u015f a\u00e7\u0131s\u0131 kazanma enerjisi ta\u015f\u0131yor.',
      suggestions: [
        'Art\u0131k sana hizmet etmeyen bir y\u00fck\u00fc b\u0131rak.',
        'Birine destek olarak g\u00fcn\u00fcn enerjisini y\u00fckselt.',
        'Ge\u00e7mi\u015ften gelen bir dersi fark et.',
      ],
    ),
  };
}
