import 'package:intl/intl.dart';

class Formatter {
  static final NumberFormat _currencyFormat = NumberFormat("#,###");

  static String formatPrice(int price) {
    return _currencyFormat.format(price);
  }
}
