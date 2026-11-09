import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/item.dart';

// Runs a save without waiting for it. A storage error is logged instead of
// crashing the screen (e.g. when storage isn't available).
void saveInBackground(Future<void> save) {
  save.catchError((Object e) => debugPrint('Save failed: $e'));
}

// Android: the Downloads folder (as the spec requires).
// Other platforms (e.g. the iOS simulator) have no Downloads folder,
// so the app's own documents folder is used instead.
Future<Directory> dataDirectory() async {
  if (Platform.isAndroid) return Directory('/storage/emulated/0/Download');
  return getApplicationDocumentsDirectory();
}

// On Android, ask for access to the Downloads folder before loading.
// Android 11+: "All files access" (opens the system setting the first time).
// Android 10 and older: the regular storage permission.
Future<void> requestStorageAccess() async {
  if (!Platform.isAndroid) return;
  if (await Permission.manageExternalStorage.request().isGranted) return;
  await Permission.storage.request();
}

// items.json: a JSON list of Item.toJson objects.
class ItemStore {
  final File? file; // lets tests use their own file

  ItemStore({this.file});

  Future<File> _getFile() async =>
      file ?? File('${(await dataDirectory()).path}/items.json');

  Future<List<Item>> load() async {
    final file = await _getFile();
    if (!await file.exists()) return [];
    final text = await file.readAsString();
    if (text.trim().isEmpty) return [];
    final list = jsonDecode(text) as List;
    return list.map((j) => Item.fromJson(j as Map<String, dynamic>)).toList();
  }

  Future<void> save(List<Item> items) async {
    final file = await _getFile();
    await file.writeAsString(jsonEncode(items.map((i) => i.toJson()).toList()));
  }

  // New items go first, matching the feed (newest on top).
  Future<void> add(Item item) async {
    final items = await load();
    items.insert(0, item);
    await save(items);
  }

  Future<void> remove(String id) async {
    final items = await load();
    items.removeWhere((i) => i.id == id);
    await save(items);
  }
}
