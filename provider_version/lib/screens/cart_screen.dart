// Langkah 6, Tugas 1 (Hapus Item), Tugas 3 (Format Rupiah) — Halaman Keranjang
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../utils/currency.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Saya')),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: cart.items.isEmpty
                    ? const Center(child: Text('Keranjang kosong'))
                    : ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text(formatRupiah(item.price)),
                            // Tugas 1 (Wajib) — Tombol hapus (ikon tempat sampah)
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: 'Hapus ${item.name}',
                              onPressed: () => cart.removeItem(item),
                            ),
                          );
                        },
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: ${formatRupiah(cart.totalPrice)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FilledButton(
                      onPressed: cart.items.isEmpty ? null : cart.clearCart,
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
