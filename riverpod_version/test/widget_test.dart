import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:state_management_demo/main.dart';

void main() {
  testWidgets('Tambah barang lalu checkout mengosongkan keranjang',
      (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    await tester.tap(find.byIcon(Icons.add).first); // tambah Laptop
    await tester.pumpAndSettle(); // animasi SnackBar muncul
    await tester.pump(const Duration(seconds: 5)); // tunggu SnackBar hilang
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    expect(find.text('Laptop'), findsOneWidget);
    await tester.tap(find.text('Checkout'));
    await tester.pump();
    expect(find.text('Keranjang kosong'), findsOneWidget);
  });

  testWidgets('Hapus item di keranjang mengosongkan daftar dan badge hilang',
      (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    // Badge menampilkan jumlah barang di Katalog
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text('Keranjang kosong'), findsOneWidget);
  });
}
