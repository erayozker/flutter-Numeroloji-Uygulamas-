import 'package:numeroloji/data/models/numerology_result_model.dart';

class HistoryItemModel {
  const HistoryItemModel({
    required this.id,
    required this.savedAt,
    required this.result,
  });

  final String id;
  final DateTime savedAt;
  final NumerologyResultModel result;

  factory HistoryItemModel.fromJson(Map<String, Object?> json) {
    return HistoryItemModel(
      id: json['id'] as String? ?? '',
      savedAt: DateTime.tryParse(json['savedAt'] as String? ?? '') ??
          DateTime.now(),
      result: NumerologyResultModel.fromJson(
        Map<String, Object?>.from(json['result'] as Map? ?? {}),
      ),
    );
  }

  factory HistoryItemModel.fromResult(
    NumerologyResultModel result, {
    DateTime? savedAt,
  }) {
    final createdAt = savedAt ?? DateTime.now();
    return HistoryItemModel(
      id: '${createdAt.microsecondsSinceEpoch}',
      savedAt: createdAt,
      result: result,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'savedAt': savedAt.toIso8601String(),
      'result': result.toJson(),
    };
  }
}
