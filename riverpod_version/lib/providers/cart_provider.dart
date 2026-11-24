// Tugas 4 — Refactoring ke Riverpod
// Pengganti CartProvider (ChangeNotifier). State berupa List<Item> yang
// immutable: setiap perubahan membuat list baru, bukan mengubah list lama.
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/item.dart';

class CartNotifier extends Notifier<List<Item>> {
  // Nilai awal state: keranjang kosong.
  @override
  List<Item> build() => const [];

  void addItem(Item item) {
    // Menugaskan state baru otomatis memberi tahu semua pendengar,
    // jadi tidak perlu memanggil notifyListeners().
    state = List.unmodifiable([...state, item]);
  }

  // Seperti List.remove: hanya menghapus kemunculan pertama.
  void removeItem(Item item) {
    final index = state.indexOf(item);
    if (index == -1) return;
    state = List.unmodifiable([...state]..removeAt(index));
  }

  void clearCart() {
    state = const [];
  }
}

// Provider utama: dibaca lewat ref.watch(cartProvider) dan diubah lewat
// ref.read(cartProvider.notifier).
final cartProvider =
    NotifierProvider<CartNotifier, List<Item>>(CartNotifier.new);

// Provider turunan: dihitung ulang otomatis saat cartProvider berubah.
final cartTotalProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).fold(0, (sum, item) => sum + item.price);
});

final cartCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).length;
});
