import 'package:flutter/material.dart';

enum ItemStatus { onSale, reserved, sold }

class Item {
  final String id;
  final String title;
  final int price; // 0 == Free
  final String description;
  final String location;
  final String category;
  final String imageUrl;
  final int likeCount;
  final int chatCount;
  final DateTime createdAt;
  ItemStatus status;
  bool isLiked;

  Item({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.createdAt,
    this.description = '',
    this.category = 'etc',
    this.imageUrl = '',
    this.likeCount = 0,
    this.chatCount = 0,
    this.status = ItemStatus.onSale,
    this.isLiked = false,
  });

  // status is stored by name, createdAt as ISO-8601.
  factory Item.fromJson(Map<String, dynamic> j) {
    return Item(
      id: j['id'] as String,
      title: j['title'] as String,
      price: (j['price'] as num).toInt(),
      location: j['location'] as String,
      createdAt: DateTime.parse(j['createdAt'] as String),
      description: j['description'] as String? ?? '',
      category: j['category'] as String? ?? 'etc',
      imageUrl: j['imageUrl'] as String? ?? '',
      likeCount: (j['likeCount'] as num?)?.toInt() ?? 0,
      chatCount: (j['chatCount'] as num?)?.toInt() ?? 0,
      status: ItemStatus.values.byName(j['status'] as String? ?? 'onSale'),
      isLiked: j['isLiked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'location': location,
      'category': category,
      'imageUrl': imageUrl,
      'likeCount': likeCount,
      'chatCount': chatCount,
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
      'isLiked': isLiked,
    };
  }
}

String statusLabel(ItemStatus s) {
  switch (s) {
    case ItemStatus.onSale:
      return 'For sale';
    case ItemStatus.reserved:
      return 'Reserved';
    case ItemStatus.sold:
      return 'Sold';
  }
}

Color statusColor(ItemStatus s) {
  switch (s) {
    case ItemStatus.onSale:
      return const Color(0xFFFF6F0F);
    case ItemStatus.reserved:
      return Colors.green;
    case ItemStatus.sold:
      return Colors.grey;
  }
}
