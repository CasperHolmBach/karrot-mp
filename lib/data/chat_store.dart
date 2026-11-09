import 'dart:convert';
import 'dart:io';

import '../models/message.dart';
import 'item_store.dart';

// chat_<itemId>.json: a JSON list of Message.toJson objects.
class ChatStore {
  Future<File> _file(String itemId) async =>
      File('${(await dataDirectory()).path}/chat_$itemId.json');

  Future<List<Message>> load(String itemId) async {
    final file = await _file(itemId);
    if (!await file.exists()) return [];
    final text = await file.readAsString();
    if (text.trim().isEmpty) return [];
    final list = jsonDecode(text) as List;
    return list
        .map((j) => Message.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(String itemId, List<Message> messages) async {
    final file = await _file(itemId);
    await file.writeAsString(
      jsonEncode(messages.map((m) => m.toJson()).toList()),
    );
  }
}
