import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/item.dart';

// Bump times per item id, stored in SharedPreferences as JSON
// ({"<id>": "<ISO-8601 time>"}).
class BumpStore {
  static const _key = 'bumpedAt';

  Future<Map<String, DateTime>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(_key);
    if (text == null) return {};
    final map = jsonDecode(text) as Map<String, dynamic>;
    return map.map((id, time) => MapEntry(id, DateTime.parse(time as String)));
  }

  Future<void> bump(String id, DateTime time) async {
    final bumps = await load();
    bumps[id] = time;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(bumps.map((k, v) => MapEntry(k, v.toIso8601String()))),
    );
  }
}

// Bumped items first (most recent bump highest), then the rest in order.
List<Item> sortByBump(List<Item> items, Map<String, DateTime> bumps) {
  final bumped = items.where((i) => bumps.containsKey(i.id)).toList()
    ..sort((a, b) => bumps[b.id]!.compareTo(bumps[a.id]!));
  final rest = items.where((i) => !bumps.containsKey(i.id));
  return [...bumped, ...rest];
}
