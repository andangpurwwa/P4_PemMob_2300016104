// Halaman Keranjang (versi Riverpod)
// ConsumerWidget memberi akses ke `ref`. ref.watch membuat halaman ini
// dibangun ulang otomatis saat keranjang berubah.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';
import '../utils/currency.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider); // mendengarkan isi keranjang
    final total = ref.watch(cartTotalProvider); // mendengarkan total harga
    final cart = ref.read(cartProvider.notifier); // hanya untuk memanggil aksi

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Saya')),
      body: Column(
        children: [
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Keranjang kosong'))
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(formatRupiah(item.price)),
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
                  'Total: ${formatRupiah(total)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                FilledButton(
                  onPressed: items.isEmpty ? null : cart.clearCart,
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
