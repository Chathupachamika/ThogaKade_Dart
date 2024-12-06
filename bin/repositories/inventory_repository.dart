import '../models/vegetable.dart';
import '../database/DBConnection.dart';

class InventoryRepository {
  final DBConnection _dbConnection = DBConnection.getInstance();

  // Load inventory from the in-memory database
  Future<List<Vegetable>> loadInventory() async {
    return _dbConnection.readAll().map((data) {
      return Vegetable(
        id: data['id'],
        name: data['name'],
        pricePerKg: data['pricePerKg'],
        availableQuantity: data['availableQuantity'],
        category: data['category'],
        expiryDate: DateTime.parse(data['expiryDate']),
      );
    }).toList();
  }

  // Save updated inventory to the in-memory database
  Future<void> saveInventory(List<Vegetable> inventory) async {
    for (var vegetable in inventory) {
      await updateVegetable(vegetable);
    }
  }

  // Add a new vegetable to the in-memory database
  Future<void> addVegetable(Vegetable vegetable) async {
    _dbConnection.create({
      'id': vegetable.id,
      'name': vegetable.name,
      'pricePerKg': vegetable.pricePerKg,
      'availableQuantity': vegetable.availableQuantity,
      'category': vegetable.category,
      'expiryDate': vegetable.expiryDate.toIso8601String(),
    });
  }

  // Update an existing vegetable in the in-memory database
  Future<void> updateVegetable(Vegetable vegetable) async {
    _dbConnection.update(
      vegetable.id,
      {
        'id': vegetable.id,
        'name': vegetable.name,
        'pricePerKg': vegetable.pricePerKg,
        'availableQuantity': vegetable.availableQuantity,
        'category': vegetable.category,
        'expiryDate': vegetable.expiryDate.toIso8601String(),
      },
    );
  }

  // Remove vegetable from the in-memory database
  Future<void> removeVegetable(String id) async {
    _dbConnection.delete(id);
  }
}
