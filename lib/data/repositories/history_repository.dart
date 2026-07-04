import 'dart:convert';

import 'package:numeroloji/data/models/history_item_model.dart';
import 'package:numeroloji/data/models/numerology_result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepository {
  static const _storageKey = 'numerology_history_items';

  Future<List<HistoryItemModel>> getHistory() async {
    final preferences = await SharedPreferences.getInstance();
    final rawItems = preferences.getStringList(_storageKey) ?? [];

    return rawItems
        .map((item) {
          final decoded = jsonDecode(item);
          if (decoded is! Map) {
            return null;
          }
          return HistoryItemModel.fromJson(Map<String, Object?>.from(decoded));
        })
        .whereType<HistoryItemModel>()
        .toList()
      ..sort((first, second) => second.savedAt.compareTo(first.savedAt));
  }

  Future<void> saveResult(NumerologyResultModel result) async {
    final preferences = await SharedPreferences.getInstance();
    final history = await getHistory();
    final item = HistoryItemModel.fromResult(result);
    final updatedHistory = [item, ...history].take(30).toList();

    await preferences.setStringList(
      _storageKey,
      updatedHistory.map((entry) => jsonEncode(entry.toJson())).toList(),
    );
  }

  Future<void> deleteItem(String id) async {
    final preferences = await SharedPreferences.getInstance();
    final history = await getHistory();
    final updatedHistory = history.where((item) => item.id != id).toList();

    await preferences.setStringList(
      _storageKey,
      updatedHistory.map((entry) => jsonEncode(entry.toJson())).toList(),
    );
  }

  Future<void> clearHistory() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_storageKey);
  }
}
