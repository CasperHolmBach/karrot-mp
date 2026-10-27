import 'package:flutter/material.dart';

import '../models/item.dart';
import '../screens/item_detail_screen.dart';
import 'item_tile.dart';

class ItemListView extends StatelessWidget {
  final List<Item> items;
  final void Function(Item item)? onItemTap;
  final void Function(Item item)? onItemLongPress;
  final void Function(Item item)? onLikeTap;

  const ItemListView({
    super.key,
    required this.items,
    this.onItemTap,
    this.onItemLongPress,
    this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemTile(
          item: item,
          // Without a handler, a tap still opens the detail screen.
          onTap: onItemTap != null
              ? () => onItemTap!(item)
              : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ItemDetailScreen(item: item),
                  ),
                ),
          onLongPress: () => onItemLongPress?.call(item),
          onLikeTap: () => onLikeTap?.call(item),
        );
      },
    );
  }
}
