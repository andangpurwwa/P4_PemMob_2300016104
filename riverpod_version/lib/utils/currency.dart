// Tugas 3 — Helper format Rupiah (satu tempat, dipakai di semua halaman)
import 'package:intl/intl.dart';

final NumberFormat _rupiah = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp ',
  decimalDigits: 0,
);

/// Contoh: formatRupiah(10000000) -> "Rp 10.000.000"
String formatRupiah(num value) => _rupiah.format(value);
