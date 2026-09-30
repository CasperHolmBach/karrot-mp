import 'package:flutter/material.dart';

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
      // TODO: remove the dummy item before submission (no pre-filled items).
      home: HomeScreen(
        items: [
          Item(
            id: 'dummy-1',
            title: 'iPhone 13',
            price: 450000,
            location: 'Heukseok-dong',
            createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
            category: 'Digital devices',
            description: 'Barely used, comes with a case.',
            likeCount: 12,
            chatCount: 5,
          ),
        ],
      ),
    );
  }
}
