class Formatters {
  static String formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static String formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
