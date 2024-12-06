import '../models/vegetable.dart';
import '../repositories/inventory_repository.dart';

class InventoryManager {
  final InventoryRepository _repository = InventoryRepository();

  Future<List<Vegetable>> getInventory() async {
    return await _repository.loadInventory();
  }

  Future<void> addVegetable(Vegetable vegetable) async {
    await _repository.addVegetable(vegetable);
  }

  Future<void> updateStock(String id, double quantity) async {
    final inventory = await _repository.loadInventory();
    final vegetable = inventory.firstWhere((v) => v.id == id);
    vegetable.availableQuantity += quantity;
    await _repository.saveInventory(inventory);
  }

  Future<void> removeVegetable(String id) async {
    await _repository.removeVegetable(id);
  }
}
