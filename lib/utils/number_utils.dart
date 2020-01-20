import 'package:intl/intl.dart';

String formatNumber(dynamic nb) {
  try {
    return NumberFormat("#,###").format(nb);
  } catch (err) {
    return nb;
  }
}

String formatCurrency(dynamic nb) {
  if (!isNumeric('$nb')) {
    return nb;
  }
  return '\$${formatNumber(nb)}';
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
