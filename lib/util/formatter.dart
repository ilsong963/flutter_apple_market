import 'package:intl/intl.dart';

class Formatter {
  static final NumberFormat _currencyFormat = NumberFormat("#,###");

  static String formatPrice(int price) {
    return _currencyFormat.format(price);
  }

  static String formatMultiline(String text) {
    return text.replaceAll(r'\n', '\n');
  }
}
