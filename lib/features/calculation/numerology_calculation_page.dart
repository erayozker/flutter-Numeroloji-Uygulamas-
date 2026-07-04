import 'package:flutter/material.dart';
import 'package:numeroloji/app/app_routes.dart';
import 'package:numeroloji/app/app_theme.dart';
import 'package:numeroloji/core/utils/numerology_calculator.dart';
import 'package:numeroloji/shared/enums/calculation_type.dart';

class NumerologyCalculationPage extends StatefulWidget {
  const NumerologyCalculationPage({super.key});

  @override
  State<NumerologyCalculationPage> createState() =>
      _NumerologyCalculationPageState();
}

class _NumerologyCalculationPageState extends State<NumerologyCalculationPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  DateTime? _selectedBirthDate;
  CalculationType _selectedType = CalculationType.all;

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime(now.year - 25, now.month),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Do\u011fum Tarihini Se\u00e7',
      cancelText: '\u0130ptal',
      confirmText: 'Se\u00e7',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppTheme.royalPurple,
              headerBackgroundColor: AppTheme.cardPurple,
              headerForegroundColor: AppTheme.moonWhite,
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFF241300);
                }
                return AppTheme.moonWhite;
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppTheme.gold;
                }
                return null;
              }),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null || !mounted) {
      return;
    }

    setState(() {
      _selectedBirthDate = pickedDate;
    });
  }

  void _calculate() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) {
      return;
    }

    if (_selectedBirthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('L\u00fctfen do\u011fum tarihini se\u00e7.'),
        ),
      );
      return;
    }

    final result = NumerologyCalculator.calculate(
      fullName: _fullNameController.text,
      birthDate: _selectedBirthDate!,
      calculationType: _selectedType,
    );

    Navigator.pushNamed(
      context,
      AppRoutes.result,
      arguments: result,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Numeroloji Hesapla')),
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
              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    constraints.maxWidth >= 720 ? 32 : 20,
                    18,
                    constraints.maxWidth >= 720 ? 32 : 20,
                    24,
                  ),
                  children: [
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 680),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bilgilerini Gir',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Do\u011fum tarihin ve isminle temel numeroloji say\u0131lar\u0131n hesaplan\u0131r.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppTheme.moonWhite.withValues(
                                      alpha: 0.72,
                                    ),
                                  ),
                            ),
                            const SizedBox(height: 22),
                            _InputPanel(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: _fullNameController,
                                    textInputAction: TextInputAction.done,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: const InputDecoration(
                                      labelText: 'Ad\u0131n Soyad\u0131n',
                                      hintText: 'Eray Y\u0131lmaz',
                                      prefixIcon: Icon(Icons.person_outline),
                                    ),
                                    validator: (value) {
                                      final trimmed = value?.trim() ?? '';
                                      if (trimmed.isEmpty) {
                                        return 'Ad soyad alan\u0131 bo\u015f b\u0131rak\u0131lamaz.';
                                      }
                                      if (trimmed.length < 2) {
                                        return 'L\u00fctfen ge\u00e7erli bir isim gir.';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  InkWell(
                                    onTap: _selectBirthDate,
                                    borderRadius: BorderRadius.circular(16),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        labelText: 'Do\u011fum Tarihin',
                                        prefixIcon: Icon(
                                          Icons.calendar_month_outlined,
                                        ),
                                      ),
                                      child: Text(
                                        _selectedBirthDate == null
                                            ? 'GG.AA.YYYY'
                                            : _formatDate(_selectedBirthDate!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: _selectedBirthDate == null
                                                  ? AppTheme.moonWhite
                                                      .withValues(alpha: 0.48)
                                                  : AppTheme.moonWhite,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                            _InputPanel(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hesaplama T\u00fcr\u00fc',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: CalculationType.values.map((type) {
                                      final isSelected = type == _selectedType;
                                      return ChoiceChip(
                                        label: Text(type.label),
                                        selected: isSelected,
                                        onSelected: (_) {
                                          setState(() {
                                            _selectedType = type;
                                          });
                                        },
                                        selectedColor: AppTheme.gold,
                                        backgroundColor:
                                            const Color(0xFF1A0D32),
                                        checkmarkColor:
                                            const Color(0xFF241300),
                                        labelStyle: TextStyle(
                                          color: isSelected
                                              ? const Color(0xFF241300)
                                              : AppTheme.moonWhite,
                                          fontWeight: isSelected
                                              ? FontWeight.w800
                                              : FontWeight.w600,
                                        ),
                                        side: BorderSide(
                                          color: isSelected
                                              ? AppTheme.gold
                                              : AppTheme.gold.withValues(
                                                  alpha: 0.2,
                                                ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 22),
                            FilledButton.icon(
                              onPressed: _calculate,
                              icon: const Icon(Icons.auto_awesome),
                              label: const Text('HESAPLA'),
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
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month.${date.year}';
  }
}

class _InputPanel extends StatelessWidget {
  const _InputPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
