import 'package:flutter/material.dart';
import 'package:numeroloji/features/daily/daily_numerology_page.dart';
import 'package:numeroloji/features/history/history_page.dart';
import 'package:numeroloji/features/home/home_page.dart';
import 'package:numeroloji/features/meanings/number_meanings_page.dart';
import 'package:numeroloji/features/settings/settings_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    NumberMeaningsPage(),
    DailyNumerologyPage(),
    SettingsPage(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history_rounded),
            label: 'Ge\u00e7mi\u015f',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: 'Rehber',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'G\u00fcnl\u00fck',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}
