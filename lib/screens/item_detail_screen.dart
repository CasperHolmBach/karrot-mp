import 'package:flutter/material.dart';

import '../models/item.dart';
import '../utils/format.dart';
import 'chat_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  final Item item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  void _toggleLike() {
    setState(() => widget.item.isLiked = !widget.item.isLiked);
  }

  void _openChat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatScreen(item: widget.item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top: item image, full width
            SizedBox(
              width: double.infinity,
              height: 300,
              child: item.imageUrl.isEmpty
                  ? Container(color: Colors.grey[300])
                  : Image.network(item.imageUrl, fit: BoxFit.cover),
            ),

            // Seller row
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(backgroundColor: Colors.grey),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Danggeun',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(item.location, style: textTheme.labelSmall),
                      ],
                    ),
                  ),
                  const Text(
                    '36.5°C',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Body
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.category} · ${timeAgo(item.createdAt)}',
                    style: textTheme.labelSmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(item.description, style: textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),

      // Fixed bottom bar: ♡ | price | Chat
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    item.isLiked ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: _toggleLike,
                ),
                const SizedBox(height: 24, child: VerticalDivider(width: 16)),
                Text(
                  formatPrice(item.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                ElevatedButton(onPressed: _openChat, child: const Text('Chat')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
