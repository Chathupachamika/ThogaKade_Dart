import 'dart:io';
import '../managers/thoga_kade_manager.dart';
import '../managers/inventory_manager.dart';
import '../models/vegetable.dart';

class CommandHandler {
  final ThogaKadeManager _manager = ThogaKadeManager();
  final InventoryManager _inventoryManager = InventoryManager();

  void displayMenu() {
    print('Welcome to Thoga Kade!');
    print('1. View Inventory');
    print('2. Add Vegetable');
    print('3. Update Stock');
    print('4. Remove Vegetable');
    print('5. Exit');
    _getUserInput();
  }

  void _getUserInput() {
    stdout.write('Choose an option: ');
    final input = stdin.readLineSync();
    switch (input) {
      case '1':
        _viewInventory();
        break;
      case '2':
        _addVegetable();
        break;
      case '3':
        _updateStock();
        break;
      case '4':
        _removeVegetable();
        break;
      case '5':
        exit(0);
      default:
        print('Invalid option. Try again.');
        _getUserInput();
    }
  }

  Future<void> _viewInventory() async {
    final inventory = await _inventoryManager.getInventory();
    print('Inventory:');
    inventory.forEach(print);
  }

  Future<void> _addVegetable() async {
    stdout.write('Enter vegetable name: ');
    final name = stdin.readLineSync()!;
    stdout.write('Enter price per kg: ');
    final price = double.parse(stdin.readLineSync()!);
    stdout.write('Enter quantity: ');
    final quantity = double.parse(stdin.readLineSync()!);
    stdout.write('Enter category (leafy, root, fruit): ');
    final category = stdin.readLineSync()!;
    stdout.write('Enter expiry date (yyyy-mm-dd): ');
    final expiryDate = DateTime.parse(stdin.readLineSync()!);

    final vegetable = Vegetable(
      id: DateTime.now().toString(),
      name: name,
      pricePerKg: price,
      availableQuantity: quantity,
      category: category,
      expiryDate: expiryDate,
    );

    await _inventoryManager.addVegetable(vegetable);
    print('Vegetable added successfully.');
  }

  Future<void> _updateStock() async {
    stdout.write('Enter vegetable ID: ');
    final id = stdin.readLineSync()!;
    stdout.write('Enter quantity to update: ');
    final quantity = double.parse(stdin.readLineSync()!);

    await _inventoryManager.updateStock(id, quantity);
    print('Stock updated successfully.');
  }

  Future<void> _removeVegetable() async {
    stdout.write('Enter vegetable ID to remove: ');
    final id = stdin.readLineSync()!;
    await _inventoryManager.removeVegetable(id);
    print('Vegetable removed successfully.');
  }
}
