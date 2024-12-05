class Order {
  final String orderId;
  final Map<String, double> items; // Map<VegetableID, Quantity>
  final double totalAmount;
  final DateTime timestamp;

  Order({
    required this.orderId,
    required this.items,
    required this.totalAmount,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'Order(orderId: $orderId, totalAmount: $totalAmount, timestamp: $timestamp)';
  }
}
