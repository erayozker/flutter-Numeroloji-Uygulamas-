import 'package:flutter/material.dart';
import 'package:numeroloji/app/app_theme.dart';

class NumberMeaningsPage extends StatelessWidget {
  const NumberMeaningsPage({super.key});

  static const List<_NumberMeaning> _meanings = [
    _NumberMeaning(
      number: '1',
      title: 'Liderlik ve Ba\u015flang\u0131\u00e7lar',
      description:
          'Ba\u011f\u0131ms\u0131z, cesur ve yarat\u0131c\u0131 bir enerji temsil eder.',
    ),
    _NumberMeaning(
      number: '2',
      title: 'Uyum ve \u0130\u015fbirli\u011fi',
      description:
          'Duygusal denge, sezgi, ortakl\u0131k ve uyum aray\u0131\u015f\u0131n\u0131 simgeler.',
    ),
    _NumberMeaning(
      number: '3',
      title: 'Yarat\u0131c\u0131l\u0131k ve \u0130fade',
      description:
          'Sanatsal ifade, ileti\u015fim, ne\u015fe ve sosyal enerjiyi anlat\u0131r.',
    ),
    _NumberMeaning(
      number: '4',
      title: 'D\u00fczen ve G\u00fcven',
      description:
          'Disiplinli, planl\u0131, \u00e7al\u0131\u015fkan ve pratik bir yap\u0131y\u0131 temsil eder.',
    ),
    _NumberMeaning(
      number: '5',
      title: '\u00d6zg\u00fcrl\u00fck ve De\u011fi\u015fim',
      description:
          'Macera, hareket, merak ve yeniliklere a\u00e7\u0131k olma enerjisidir.',
    ),
    _NumberMeaning(
      number: '6',
      title: 'Sorumluluk ve Aile',
      description:
          'Sevgi, koruma, \u015fefkat, aidiyet ve sorumluluk bilincini simgeler.',
    ),
    _NumberMeaning(
      number: '7',
      title: 'Analiz ve Zeka',
      description:
          'Sezgi, ara\u015ft\u0131rma, i\u00e7e d\u00f6n\u00fckl\u00fck ve ruhsal derinlik verir.',
    ),
    _NumberMeaning(
      number: '8',
      title: 'G\u00fc\u00e7 ve Ba\u015far\u0131',
      description:
          'Maddi d\u00fcnya, hedef, otorite, kararl\u0131l\u0131k ve y\u00f6netim enerjisidir.',
    ),
    _NumberMeaning(
      number: '9',
      title: 'Bilgelik ve Tamamlama',
      description:
          'Evrensel sevgi, \u015fefkat, hizmet, tamamlanma ve olgunluk anlam\u0131 ta\u015f\u0131r.',
    ),
    _NumberMeaning(
      number: '11',
      title: 'Sezgi ve \u0130lham',
      description:
          'Y\u00fcksek fark\u0131ndal\u0131k, ruhsal rehberlik ve ilham verici vizyon say\u0131s\u0131d\u0131r.',
    ),
    _NumberMeaning(
      number: '22',
      title: 'Usta Kurucu',
      description:
          'B\u00fcy\u00fck hayalleri somutla\u015ft\u0131rma, sistem kurma ve kal\u0131c\u0131 etki enerjisidir.',
    ),
    _NumberMeaning(
      number: '33',
      title: 'Usta \u00d6\u011fretmen',
      description:
          '\u015eefkat, hizmet, \u015fifa, fedakarl\u0131k ve kolektif bilince katk\u0131y\u0131 temsil eder.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Say\u0131lar\u0131n Anlamlar\u0131')),
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1B0D35),
                AppTheme.deepPurple,
                Color(0xFF090414),
              ],
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  constraints.maxWidth >= 720 ? 32 : 20,
                  16,
                  constraints.maxWidth >= 720 ? 32 : 20,
                  28,
                ),
                itemCount: _meanings.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: _MeaningCard(meaning: _meanings[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MeaningCard extends StatelessWidget {
  const _MeaningCard({required this.meaning});

  final _NumberMeaning meaning;

  @override
  Widget build(BuildContext context) {
    final isMasterNumber = meaning.number.length > 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardPurple.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.gold.withValues(alpha: isMasterNumber ? 0.42 : 0.22),
          width: isMasterNumber ? 1.25 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.gold.withValues(alpha: isMasterNumber ? 0.08 : 0.04),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 66,
            child: Text(
              meaning.number,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppTheme.gold,
                    fontSize: isMasterNumber ? 38 : 48,
                    fontWeight: FontWeight.w900,
                    shadows: [
                      Shadow(
                        color: AppTheme.gold.withValues(alpha: 0.32),
                        blurRadius: 16,
                      ),
                    ],
                  ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meaning.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  meaning.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.moonWhite.withValues(alpha: 0.78),
                        height: 1.32,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            isMasterNumber ? Icons.auto_awesome : Icons.circle_outlined,
            color: AppTheme.gold.withValues(alpha: 0.74),
            size: isMasterNumber ? 22 : 16,
          ),
        ],
      ),
    );
  }
}

class _NumberMeaning {
  const _NumberMeaning({
    required this.number,
    required this.title,
    required this.description,
  });

  final String number;
  final String title;
  final String description;
}
