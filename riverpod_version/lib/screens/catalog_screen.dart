// Langkah 5 — Halaman Katalog
// Memakai ref.read(...notifier) karena hanya memanggil addItem,
// tanpa perlu dibangun ulang saat data berubah.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/item.dart';
import '../providers/cart_provider.dart';
import '../utils/currency.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  static const List<Item> catalog = [
    Item(name: 'Laptop', price: 10000000),
    Item(name: 'Mouse', price: 200000),
    Item(name: 'Keyboard', price: 500000),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Barang'),
        actions: [
          // Badge hanya mendengarkan cartCountProvider (jumlah barang),
          // jadi hanya ikon ini yang dibangun ulang saat jumlah berubah.
          Consumer(
            builder: (context, ref, child) {
              final count = ref.watch(cartCountProvider);
              return IconButton(
                onPressed: () => Navigator.pushNamed(context, '/cart'),
                icon: Badge(
                  isLabelVisible: count > 0,
                  label: Text('$count'),
                  child: const Icon(Icons.shopping_cart),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: catalog.length,
        itemBuilder: (context, index) {
          final item = catalog[index];
          return ListTile(
            title: Text(item.name),
            // Tugas 3 — Format Rupiah lewat helper formatRupiah().
            subtitle: Text(formatRupiah(item.price)),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                ref.read(cartProvider.notifier).addItem(item);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.name} ditambahkan!')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
