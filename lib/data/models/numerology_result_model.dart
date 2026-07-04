import 'package:numeroloji/shared/enums/calculation_type.dart';

class NumerologyResultModel {
  const NumerologyResultModel({
    required this.fullName,
    required this.birthDate,
    required this.calculationType,
    required this.lifePathNumber,
    required this.destinyNumber,
    required this.soulUrgeNumber,
    required this.personalityNumber,
  });

  final String fullName;
  final DateTime birthDate;
  final CalculationType calculationType;
  final NumerologyNumber lifePathNumber;
  final NumerologyNumber destinyNumber;
  final NumerologyNumber soulUrgeNumber;
  final NumerologyNumber personalityNumber;

  factory NumerologyResultModel.fromJson(Map<String, Object?> json) {
    return NumerologyResultModel(
      fullName: json['fullName'] as String? ?? '',
      birthDate: DateTime.tryParse(json['birthDate'] as String? ?? '') ??
          DateTime.now(),
      calculationType: CalculationType.values.firstWhere(
        (type) => type.name == json['calculationType'],
        orElse: () => CalculationType.all,
      ),
      lifePathNumber: NumerologyNumber.fromJson(
        Map<String, Object?>.from(json['lifePathNumber'] as Map? ?? {}),
      ),
      destinyNumber: NumerologyNumber.fromJson(
        Map<String, Object?>.from(json['destinyNumber'] as Map? ?? {}),
      ),
      soulUrgeNumber: NumerologyNumber.fromJson(
        Map<String, Object?>.from(json['soulUrgeNumber'] as Map? ?? {}),
      ),
      personalityNumber: NumerologyNumber.fromJson(
        Map<String, Object?>.from(json['personalityNumber'] as Map? ?? {}),
      ),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'fullName': fullName,
      'birthDate': birthDate.toIso8601String(),
      'calculationType': calculationType.name,
      'lifePathNumber': lifePathNumber.toJson(),
      'destinyNumber': destinyNumber.toJson(),
      'soulUrgeNumber': soulUrgeNumber.toJson(),
      'personalityNumber': personalityNumber.toJson(),
    };
  }
}

class NumerologyNumber {
  const NumerologyNumber({
    required this.value,
    required this.displayValue,
    required this.rawValue,
  });

  final int value;
  final String displayValue;
  final int rawValue;

  factory NumerologyNumber.fromJson(Map<String, Object?> json) {
    return NumerologyNumber(
      value: json['value'] as int? ?? 0,
      displayValue: json['displayValue'] as String? ?? '0',
      rawValue: json['rawValue'] as int? ?? 0,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'value': value,
      'displayValue': displayValue,
      'rawValue': rawValue,
    };
  }
}
