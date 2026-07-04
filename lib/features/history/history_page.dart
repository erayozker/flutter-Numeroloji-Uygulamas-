import 'package:flutter/material.dart';
import 'package:numeroloji/app/app_theme.dart';
import 'package:numeroloji/data/models/history_item_model.dart';
import 'package:numeroloji/data/repositories/history_repository.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _historyRepository = HistoryRepository();
  late Future<List<HistoryItemModel>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = _historyRepository.getHistory();
  }

  void _refreshHistory() {
    setState(() {
      _historyFuture = _historyRepository.getHistory();
    });
  }

  Future<void> _deleteItem(HistoryItemModel item) async {
    await _historyRepository.deleteItem(item.id);
    if (!mounted) {
      return;
    }
    _refreshHistory();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sonu\u00e7 ge\u00e7mi\u015ften silindi.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ge\u00e7mi\u015f Sonu\u00e7lar')),
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
          child: FutureBuilder<List<HistoryItemModel>>(
            future: _historyFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: AppTheme.gold),
                );
              }

              final historyItems = snapshot.data ?? [];
              if (historyItems.isEmpty) {
                return const _EmptyHistoryView();
              }

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                itemCount: historyItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = historyItems[index];
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: _HistoryCard(
                        item: item,
                        onDelete: () => _deleteItem(item),
                      ),
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

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.item,
    required this.onDelete,
  });

  final HistoryItemModel item;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final result = item.result;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardPurple.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.gold.withValues(alpha: 0.22),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.gold.withValues(alpha: 0.12),
              border: Border.all(
                color: AppTheme.gold.withValues(alpha: 0.32),
              ),
            ),
            child: Text(
              result.lifePathNumber.displayValue,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.gold,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Ya\u015fam Yolu: ${result.lifePathNumber.displayValue}  |  '
                  'Kader: ${result.destinyNumber.displayValue}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.moonWhite.withValues(alpha: 0.74),
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(item.savedAt),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.gold.withValues(alpha: 0.86),
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            tooltip: 'Sil',
            icon: const Icon(Icons.delete_outline, color: AppTheme.gold),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day.$month.${date.year} $hour:$minute';
  }
}

class _EmptyHistoryView extends StatelessWidget {
  const _EmptyHistoryView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.history_rounded,
              color: AppTheme.gold.withValues(alpha: 0.86),
              size: 52,
            ),
            const SizedBox(height: 14),
            Text(
              'Hen\u00fcz kay\u0131t yok',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Numeroloji hesaplamalar\u0131n tamamland\u0131\u011f\u0131nda burada listelenecek.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.moonWhite.withValues(alpha: 0.72),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
