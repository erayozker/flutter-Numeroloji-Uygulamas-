import 'package:numeroloji/data/models/numerology_result_model.dart';
import 'package:numeroloji/shared/enums/calculation_type.dart';

abstract final class NumerologyCalculator {
  static const Set<String> _vowels = {
    'A',
    'E',
    'I',
    'O',
    'U',
  };

  static const Map<String, int> _letterValues = {
    'A': 1,
    'J': 1,
    'S': 1,
    'B': 2,
    'K': 2,
    'T': 2,
    'C': 3,
    'L': 3,
    'U': 3,
    'D': 4,
    'M': 4,
    'V': 4,
    'E': 5,
    'N': 5,
    'W': 5,
    'F': 6,
    'O': 6,
    'X': 6,
    'G': 7,
    'P': 7,
    'Y': 7,
    'H': 8,
    'Q': 8,
    'Z': 8,
    'I': 9,
    'R': 9,
  };

  static NumerologyResultModel calculate({
    required String fullName,
    required DateTime birthDate,
    required CalculationType calculationType,
  }) {
    return NumerologyResultModel(
      fullName: fullName.trim(),
      birthDate: birthDate,
      calculationType: calculationType,
      lifePathNumber: calculateLifePathNumber(birthDate),
      destinyNumber: calculateNameNumber(fullName),
      soulUrgeNumber: calculateNameNumber(fullName, onlyVowels: true),
      personalityNumber: calculateNameNumber(fullName, onlyConsonants: true),
    );
  }

  static NumerologyNumber calculateLifePathNumber(DateTime birthDate) {
    final digits = [
      ...birthDate.day.toString().split(''),
      ...birthDate.month.toString().split(''),
      ...birthDate.year.toString().split(''),
    ];

    final total = digits.fold<int>(0, (sum, digit) => sum + int.parse(digit));
    return _reduce(total);
  }

  static NumerologyNumber calculateNameNumber(
    String name, {
    bool onlyVowels = false,
    bool onlyConsonants = false,
  }) {
    final normalizedLetters = _normalizeTurkishText(name).split('');
    var total = 0;

    for (final letter in normalizedLetters) {
      final value = _letterValues[letter];
      if (value == null) {
        continue;
      }

      final isVowel = _vowels.contains(letter);
      if (onlyVowels && !isVowel) {
        continue;
      }
      if (onlyConsonants && isVowel) {
        continue;
      }

      total += value;
    }

    return _reduce(total);
  }

  static String _normalizeTurkishText(String value) {
    return value
        .toUpperCase()
        .replaceAll('\u00c7', 'C')
        .replaceAll('\u011e', 'G')
        .replaceAll('\u0130', 'I')
        .replaceAll('\u00d6', 'O')
        .replaceAll('\u015e', 'S')
        .replaceAll('\u00dc', 'U');
  }

  static NumerologyNumber _reduce(int rawValue) {
    if (rawValue == 0) {
      return const NumerologyNumber(
        value: 0,
        displayValue: '0',
        rawValue: 0,
      );
    }

    var reduced = rawValue;
    while (reduced > 9 && reduced != 11 && reduced != 22) {
      reduced = reduced
          .toString()
          .split('')
          .fold<int>(0, (sum, digit) => sum + int.parse(digit));
    }

    if (reduced == 11 || reduced == 22) {
      final finalValue = reduced
          .toString()
          .split('')
          .fold<int>(0, (sum, digit) => sum + int.parse(digit));
      return NumerologyNumber(
        value: finalValue,
        displayValue: '$reduced/$finalValue',
        rawValue: rawValue,
      );
    }

    return NumerologyNumber(
      value: reduced,
      displayValue: '$reduced',
      rawValue: rawValue,
    );
  }
}
