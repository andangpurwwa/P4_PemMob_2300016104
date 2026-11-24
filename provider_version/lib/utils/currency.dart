// Tugas 3 — Format Rupiah
import 'package:intl/intl.dart';

String formatRupiah(int amount) {
  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(amount);
}
