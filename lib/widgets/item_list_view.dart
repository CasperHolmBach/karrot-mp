import 'package:flutter/material.dart';

import '../models/item.dart';
import 'item_tile.dart';

class ItemListView extends StatelessWidget {
  final List<Item> items;

  const ItemListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ItemTile(item: items[index]),
    );
  }
}
