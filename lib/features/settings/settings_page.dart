import 'package:flutter/material.dart';
import 'package:numeroloji/app/app_theme.dart';
import 'package:numeroloji/data/repositories/history_repository.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _clearData(BuildContext context) async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.royalPurple,
          title: const Text('Verileri Temizle'),
          content: const Text(
            'T\u00fcm ge\u00e7mi\u015f hesaplama kay\u0131tlar\u0131 silinecek.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('\u0130ptal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Temizle'),
            ),
          ],
        );
      },
    );

    if (shouldClear != true || !context.mounted) {
      return;
    }

    await HistoryRepository().clearHistory();
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('T\u00fcm lokal veriler temizlendi.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
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
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            children: [
              _SettingsSection(
                children: [
                  SwitchListTile(
                    value: true,
                    onChanged: null,
                    activeThumbColor: AppTheme.gold,
                    title: const Text('Dark mode'),
                    subtitle: Text(
                      'Koyu mor ve alt\u0131n sar\u0131s\u0131 tema sabit a\u00e7\u0131k.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.moonWhite.withValues(alpha: 0.72),
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _SettingsSection(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: AppTheme.gold,
                    ),
                    title: const Text('Hakk\u0131nda'),
                    subtitle: Text(
                      'Numeroloji; do\u011fum tarihi ve isim enerjisine g\u00f6re ki\u015fisel say\u0131 yorumlar\u0131 sunar.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.moonWhite.withValues(alpha: 0.72),
                          ),
                    ),
                  ),
                  const Divider(color: Color(0x33F5C85A), height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.new_releases_outlined,
                      color: AppTheme.gold,
                    ),
                    title: const Text('Uygulama Versiyonu'),
                    subtitle: Text(
                      '1.0.0+1',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.moonWhite.withValues(alpha: 0.72),
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _SettingsSection(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: AppTheme.gold,
                    ),
                    title: const Text('Verileri Temizle'),
                    subtitle: Text(
                      'Kaydedilen ge\u00e7mi\u015f sonu\u00e7lar\u0131 sil.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.moonWhite.withValues(alpha: 0.72),
                          ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppTheme.gold,
                    ),
                    onTap: () => _clearData(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 680),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.cardPurple.withValues(alpha: 0.76),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppTheme.gold.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}
