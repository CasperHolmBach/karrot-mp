import 'package:shared_preferences/shared_preferences.dart';

// Liked item ids, stored in SharedPreferences as a list of strings.
class LikeStore {
  static const _key = 'likedIds';

  Future<Set<String>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_key) ?? []).toSet();
  }

  Future<void> save(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, ids.toList());
  }

  // Returns whether the item is liked after the toggle.
  Future<bool> toggle(String id) async {
    final ids = await load();
    final liked = ids.add(id);
    if (!liked) ids.remove(id);
    await save(ids);
    return liked;
  }
}
