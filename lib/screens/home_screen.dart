import 'package:flutter/material.dart';

import '../models/item.dart';
import '../widgets/item_list_view.dart';
import 'item_detail_screen.dart';
import 'write_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Item> items;

  const HomeScreen({super.key, required this.items});

  // The spec pins HomeScreen as a StatelessWidget, so the changing feed
  // (add / delete / bump / like) lives in _HomeView below.
  @override
  Widget build(BuildContext context) => _HomeView(items: items);
}

class _HomeView extends StatefulWidget {
  final List<Item> items;

  const _HomeView({required this.items});

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  late final List<Item> _items = List.of(widget.items);
  final Map<String, DateTime> _bumpedAt =
      {}; // TODO: persist (Bump · Shared Pref)

  Future<void> _openDetail(Item item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ItemDetailScreen(item: item)),
    );
    setState(() {}); // show a like toggled on the detail screen
  }

  Future<void> _openWrite() async {
    final item = await Navigator.push<Item>(
      context,
      MaterialPageRoute(builder: (_) => const WriteScreen()),
    );
    if (item != null) setState(() => _items.insert(0, item));
  }

  void _toggleLike(Item item) {
    setState(() => item.isLiked = !item.isLiked);
  }

  Future<void> _showContextMenu(Item item) async {
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          for (final label in ['Bump up', 'Edit', 'Delete', 'Share'])
            ListTile(
              title: Text(label),
              onTap: () => Navigator.pop(context, label),
            ),
        ],
      ),
    );
    if (!mounted) return;
    if (choice == 'Bump up') _showBumpDialog(item);
    if (choice == 'Delete') setState(() => _items.remove(item));
    // Edit / Share: just close the menu.
  }

  Future<void> _showBumpDialog(Item item) async {
    final bump = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bump to top'),
        content: Text("Bump '${item.title}' to the top of the list?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
        ],
      ),
    );
    if (bump != true) return; // No / tap outside: change nothing
    setState(() {
      _items.remove(item);
      _items.insert(0, item);
      _bumpedAt[item.id] = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text('Heukseok-dong', overflow: TextOverflow.ellipsis),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: ItemListView(
        items: _items,
        onItemTap: _openDetail,
        onItemLongPress: _showContextMenu,
        onLikeTap: _toggleLike,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openWrite,
        icon: const Icon(Icons.add),
        label: const Text('Sell'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'My',
          ),
        ],
      ),
    );
  }
}
