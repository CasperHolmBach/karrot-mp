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

  // TODO: factory Item.fromJson(Map<String, dynamic> j)
  // TODO: Map<String, dynamic> toJson()
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
