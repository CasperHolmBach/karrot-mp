import 'package:flutter/material.dart';

import 'data/bump_store.dart';
import 'data/item_store.dart';
import 'data/like_store.dart';
import 'models/item.dart';
import 'screens/home_screen.dart';

const Color kAccent = Color(0xFFFF6F0F);

void main() {
  runApp(const KarrotApp());
}

class KarrotApp extends StatelessWidget {
  const KarrotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karrot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kAccent, primary: kAccent),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kAccent,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const _HomeLoader(),
    );
  }
}

// Loads items.json, likes and bumps, then hands the list to HomeScreen.
class _HomeLoader extends StatefulWidget {
  const _HomeLoader();

  @override
  State<_HomeLoader> createState() => _HomeLoaderState();
}

class _HomeLoaderState extends State<_HomeLoader> {
  List<Item> _items = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final items = await ItemStore().load();
      final liked = await LikeStore().load();
      final bumps = await BumpStore().load();
      for (final item in items) {
        item.isLiked = liked.contains(item.id);
      }
      if (mounted) setState(() => _items = sortByBump(items, bumps));
    } catch (e) {
      debugPrint('Could not load items: $e');
    }
  }

  @override
  Widget build(BuildContext context) => HomeScreen(items: _items);
}
