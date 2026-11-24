// Tugas 4 — Versi Riverpod: ProviderScope menggantikan ChangeNotifierProvider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/cart_screen.dart';
import 'screens/catalog_screen.dart';

void main() {
  // ProviderScope menyimpan state semua provider (pengganti ChangeNotifierProvider).
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const CatalogScreen(),
      routes: {
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
