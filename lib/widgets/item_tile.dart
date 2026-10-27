import 'package:flutter/material.dart';

import '../models/item.dart';
import '../utils/format.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onLikeTap;

  const ItemTile({
    super.key,
    required this.item,
    this.onTap,
    this.onLongPress,
    this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Left: thumbnail + status badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: item.imageUrl.isEmpty
                        ? Container(color: Colors.grey[300])
                        : Image.network(item.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                if (item.status != ItemStatus.onSale)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor(item.status),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        statusLabel(item.status),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Middle: title / location · timeAgo / price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title),
                  Text(
                    '${item.location} · ${timeAgo(item.createdAt)}',
                    style: textTheme.labelSmall?.copyWith(color: Colors.grey),
                  ),
                  Text(
                    formatPrice(item.price),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Right, bottom-aligned: likes (tappable) and chats
            GestureDetector(
              onTap: onLikeTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                // No bottom padding, so it stays aligned with the chat count.
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                child: Row(
                  children: [
                    Icon(
                      item.isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text('${item.likeCount}'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey),
            Text('${item.chatCount}'),
          ],
        ),
      ),
    );
  }
}
