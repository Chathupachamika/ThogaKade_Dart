import '../models/report.dart';

class ReportService {
  final List<Report> _reports = [];

  void generateReport(DateTime date, double totalSales, int totalOrders) {
    final report = Report(date: date, totalSales: totalSales, totalOrders: totalOrders);
    _reports.add(report);
  }

  List<Report> getReports() {
    return _reports;
  }
}
