import 'package:flutter/material.dart';
import 'package:numeroloji/app/app_routes.dart';
import 'package:numeroloji/app/app_theme.dart';
import 'package:numeroloji/app/main_navigation.dart';
import 'package:numeroloji/features/calculation/numerology_calculation_page.dart';
import 'package:numeroloji/features/daily/daily_numerology_page.dart';
import 'package:numeroloji/features/history/history_page.dart';
import 'package:numeroloji/features/meanings/number_meanings_page.dart';
import 'package:numeroloji/features/result/result_page.dart';
import 'package:numeroloji/features/settings/settings_page.dart';

class NumerologyApp extends StatelessWidget {
  const NumerologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numeroloji',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const MainNavigation(),
        AppRoutes.calculation: (_) => const NumerologyCalculationPage(),
        AppRoutes.result: (_) => const ResultPage(),
        AppRoutes.meanings: (_) => const NumberMeaningsPage(),
        AppRoutes.daily: (_) => const DailyNumerologyPage(),
        AppRoutes.history: (_) => const HistoryPage(),
        AppRoutes.settings: (_) => const SettingsPage(),
      },
    );
  }
}
