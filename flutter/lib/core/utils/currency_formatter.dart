import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _format = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
  static final _formatDecimal = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  /// Format as $XXX (no decimals) — for display prices like "$250 / night"
  static String format(num amount) => _format.format(amount);

  /// Format as $XXX.XX — for price breakdowns
  static String formatDecimal(num amount) => _formatDecimal.format(amount);
}
