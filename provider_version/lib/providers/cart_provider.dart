// Langkah 3 & Tugas 1 — State Management (CartProvider)
import 'package:flutter/foundation.dart';
import '../models/item.dart';

class CartProvider extends ChangeNotifier {
  // Daftar item (private, hanya bisa diubah dari kelas ini)
  final List<Item> _items = [];

  // Getter untuk dibaca dari luar (tidak bisa diubah langsung)
  List<Item> get items => List.unmodifiable(_items);

  int get totalPrice => _items.fold(0, (sum, item) => sum + item.price);

  void addItem(Item item) {
    _items.add(item);
    notifyListeners(); // PENTING: memberi tahu UI bahwa data berubah
  }

  // Tugas 1 (Wajib) — Hapus per item
  void removeItem(Item item) {
    if (_items.remove(item)) {
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
