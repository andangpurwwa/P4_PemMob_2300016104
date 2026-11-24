# Praktikum 4 - Tugas 4 (Nilai Tambahan): Versi Riverpod

Aplikasi keranjang belanja yang sama dengan versi Provider, tetapi state
management-nya ditulis ulang memakai **Riverpod** (`flutter_riverpod`).
Fitur identik: katalog, keranjang, hapus per item, badge jumlah barang,
format Rupiah, dan Checkout.

## Menjalankan

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

## Pemetaan Provider -> Riverpod

| Provider | Riverpod |
|---|---|
| `class CartProvider extends ChangeNotifier` | `class CartNotifier extends Notifier<List<Item>>` |
| `notifyListeners()` | menugaskan `state = ...` (otomatis memberi tahu pendengar) |
| `ChangeNotifierProvider` di `main.dart` | `ProviderScope` di `main.dart` |
| `Consumer<CartProvider>` / `context.watch` | `ConsumerWidget` / `Consumer` + `ref.watch` |
| `context.read<CartProvider>().addItem(x)` | `ref.read(cartProvider.notifier).addItem(x)` |
| getter `totalPrice` di dalam kelas | `cartTotalProvider` (provider turunan) |
| `items.length` di badge | `cartCountProvider` (provider turunan) |

## Struktur

```
lib/
|- main.dart                    # ProviderScope
|- models/item.dart
|- providers/cart_provider.dart # CartNotifier + cartProvider, cartTotalProvider, cartCountProvider
|- screens/catalog_screen.dart  # ConsumerWidget, ref.read, badge dengan Consumer
|- screens/cart_screen.dart     # ConsumerWidget, ref.watch
`- utils/currency.dart          # formatRupiah()
test/
|- cart_provider_test.dart      # unit test (ProviderContainer)
`- widget_test.dart             # widget test (ProviderScope)
```
