class Report {
  final DateTime date;
  final double totalSales;
  final int totalOrders;

  Report({
    required this.date,
    required this.totalSales,
    required this.totalOrders,
  });

  @override
  String toString() {
    return 'Report(date: $date, totalSales: $totalSales, totalOrders: $totalOrders)';
  }
}
