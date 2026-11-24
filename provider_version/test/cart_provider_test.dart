import 'package:flutter_test/flutter_test.dart';
import 'package:state_management_demo/models/item.dart';
import 'package:state_management_demo/providers/cart_provider.dart';
import 'package:state_management_demo/utils/currency.dart';

void main() {
  const laptop = Item(name: 'Laptop', price: 10000000);
  const mouse = Item(name: 'Mouse', price: 200000);

  late CartProvider cart;

  setUp(() {
    cart = CartProvider();
  });

  test('keranjang awalnya kosong', () {
    expect(cart.items, isEmpty);
    expect(cart.totalPrice, 0);
  });

  test('addItem menambah item, total, dan jumlah', () {
    cart.addItem(laptop);
    cart.addItem(mouse);

    expect(cart.items.length, 2);
    expect(cart.totalPrice, 10200000);
  });

  test('pendengar diberi tahu saat state berubah', () {
    var calls = 0;
    cart.addListener(() => calls++);

    cart.addItem(laptop);
    cart.removeItem(laptop);

    expect(calls, 2);
  });

  test('removeItem menghapus satu item dan memperbarui total', () {
    cart.addItem(laptop);
    cart.addItem(mouse);

    cart.removeItem(laptop);

    expect(cart.items, [mouse]);
    expect(cart.totalPrice, 200000);
  });

  test('removeItem pada item duplikat hanya menghapus satu kemunculan', () {
    cart.addItem(mouse);
    cart.addItem(mouse);

    cart.removeItem(mouse);

    expect(cart.items.length, 1);
  });

  test('removeItem untuk item yang tidak ada tidak mengubah state', () {
    cart.addItem(laptop);
    var calls = 0;
    cart.addListener(() => calls++);

    cart.removeItem(mouse);

    expect(cart.items.length, 1);
    expect(calls, 0);
  });

  test('clearCart mengosongkan keranjang', () {
    cart.addItem(laptop);
    cart.clearCart();

    expect(cart.items, isEmpty);
    expect(cart.totalPrice, 0);
  });

  test('state tidak bisa diubah dari luar', () {
    cart.addItem(laptop);
    expect(() => cart.items.add(mouse), throwsUnsupportedError);
  });

  test('formatRupiah memakai pemisah titik', () {
    final hasil = formatRupiah(10000000);
    expect(hasil, startsWith('Rp'));
    expect(hasil, contains('10.000.000'));
  });
}
