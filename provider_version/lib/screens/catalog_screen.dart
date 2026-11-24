// Langkah 5, Tugas 2 (Badge), Tugas 3 (Format Rupiah) — Halaman Katalog
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
import '../providers/cart_provider.dart';
import '../utils/currency.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  static const List<Item> catalog = [
    Item(name: 'Laptop', price: 10000000),
    Item(name: 'Mouse', price: 200000),
    Item(name: 'Keyboard', price: 500000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Barang'),
        actions: [
          // Tugas 2 (Wajib) — Badge jumlah barang
          Consumer<CartProvider>(
            builder: (context, cart, child) => IconButton(
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              icon: Badge(
                isLabelVisible: cart.items.isNotEmpty,
                label: Text('${cart.items.length}'),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: catalog.length,
        itemBuilder: (context, index) {
          final item = catalog[index];
          return ListTile(
            title: Text(item.name),
            // Tugas 3 (Wajib) — Format Rupiah
            subtitle: Text(formatRupiah(item.price)),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                context.read<CartProvider>().addItem(item);
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
