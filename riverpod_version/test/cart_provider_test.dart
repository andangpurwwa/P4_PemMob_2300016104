import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management_demo/models/item.dart';
import 'package:state_management_demo/providers/cart_provider.dart';
import 'package:state_management_demo/utils/currency.dart';

void main() {
  const laptop = Item(name: 'Laptop', price: 10000000);
  const mouse = Item(name: 'Mouse', price: 200000);

  late ProviderContainer container;

  CartNotifier notifier() => container.read(cartProvider.notifier);
  List<Item> items() => container.read(cartProvider);

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  test('keranjang awalnya kosong', () {
    expect(items(), isEmpty);
    expect(container.read(cartTotalProvider), 0);
    expect(container.read(cartCountProvider), 0);
  });

  test('addItem menambah item, total, dan jumlah', () {
    notifier().addItem(laptop);
    notifier().addItem(mouse);

    expect(items().length, 2);
    expect(container.read(cartTotalProvider), 10200000);
    expect(container.read(cartCountProvider), 2);
  });

  test('pendengar diberi tahu saat state berubah', () {
    var calls = 0;
    container.listen(cartProvider, (previous, next) => calls++);

    notifier().addItem(laptop);
    notifier().removeItem(laptop);

    expect(calls, 2);
  });

  test('removeItem menghapus satu item dan memperbarui total', () {
    notifier().addItem(laptop);
    notifier().addItem(mouse);

    notifier().removeItem(laptop);

    expect(items(), [mouse]);
    expect(container.read(cartTotalProvider), 200000);
  });

  test('removeItem pada item duplikat hanya menghapus satu kemunculan', () {
    notifier().addItem(mouse);
    notifier().addItem(mouse);

    notifier().removeItem(mouse);

    expect(items().length, 1);
  });

  test('removeItem untuk item yang tidak ada tidak mengubah state', () {
    notifier().addItem(laptop);
    var calls = 0;
    container.listen(cartProvider, (previous, next) => calls++);

    notifier().removeItem(mouse);

    expect(items().length, 1);
    expect(calls, 0);
  });

  test('clearCart mengosongkan keranjang', () {
    notifier().addItem(laptop);
    notifier().clearCart();

    expect(items(), isEmpty);
    expect(container.read(cartTotalProvider), 0);
  });

  test('state tidak bisa diubah dari luar', () {
    notifier().addItem(laptop);
    expect(() => items().add(mouse), throwsUnsupportedError);
  });

  test('formatRupiah memakai pemisah titik', () {
    final hasil = formatRupiah(10000000);
    expect(hasil, startsWith('Rp'));
    expect(hasil, contains('10.000.000'));
  });
}
