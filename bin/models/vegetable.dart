class Vegetable {
  final String id;
  final String name;
  final double pricePerKg;
  double availableQuantity;
  final String category; // leafy, root, or fruit
  final DateTime expiryDate;

  Vegetable({
    required this.id,
    required this.name,
    required this.pricePerKg,
    required this.availableQuantity,
    required this.category,
    required this.expiryDate,
  });

  bool isExpired() => DateTime.now().isAfter(expiryDate);

  @override
  String toString() {
    return 'Vegetable(id: $id, name: $name, pricePerKg: $pricePerKg, quantity: $availableQuantity, category: $category, expiryDate: $expiryDate)';
  }
}
