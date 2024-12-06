import 'dart:io';
import '../managers/thoga_kade_manager.dart';
import '../managers/inventory_manager.dart';
import '../models/vegetable.dart';
import '../utils/validators.dart';

class CommandHandler {
  final ThogaKadeManager _manager = ThogaKadeManager();
  final InventoryManager _inventoryManager = InventoryManager();
  int _idCounter = 1; // For generating sequential IDs

  Future<void> displayMenu() async {
    while (true) {
      print('\n-------------------------------------');
      print('|      Welcome to Thoga Kade !      |');
      print('-------------------------------------\n');
      print('1. View Inventory');
      print('2. Add to Stock');
      print('3. Update Stock');
      print('4. Remove from Stock');
      print('5. Exit');
      stdout.write('Choose an option: ');

      final input = stdin.readLineSync();
      switch (input) {
        case '1':
          await _viewInventory();
          break;
        case '2':
          await _addVegetable();
          break;
        case '3':
          await _updateStock();
          break;
        case '4':
          await _removeVegetable();
          break;
        case '5':
          print('Goodbye!');
          exit(0);
        default:
          print('Invalid option. Please try again.');
      }
    }
  }

  Future<void> _viewInventory() async {
    try {
      final inventory = await _inventoryManager.getInventory();
      if (inventory.isEmpty) {
        print('No vegetables in inventory.');
      } else {
        print('\nInventory:\n');
        print(
            '-------------------------------------------------------------------------');
        print(
            '| ID     | Name       |  Price/kg  | Quantity | Category  | Expiry Date |');
        print(
            '-------------------------------------------------------------------------');
        for (var veg in inventory) {
          print(
              '| ${veg.id.padRight(6)} | ${veg.name.padRight(10)} | Rs.${veg.pricePerKg.toStringAsFixed(2).padLeft(7)} | ${veg.availableQuantity.toStringAsFixed(2).padLeft(8)} | ${veg.category.padRight(9)} | ${veg.expiryDate.toIso8601String().substring(0, 10)}  |');
        }
        print(
            '-------------------------------------------------------------------------');
      }
    } catch (e) {
      print('Error viewing inventory: $e');
    }
  }

  Future<void> _addVegetable() async {
    try {
      stdout.write('Enter vegetable name: ');
      final name = stdin.readLineSync()!;
      if (!Validators.isValidVegetableName(name)) {
        print('Invalid name. Must be at least 3 characters.');
        return;
      }

      stdout.write('Enter price per kg: ');
      final price = double.parse(stdin.readLineSync()!);

      stdout.write('Enter quantity: ');
      final quantity = double.parse(stdin.readLineSync()!);
      if (!Validators.isValidQuantity(quantity)) {
        print('Invalid quantity. Must be greater than 0.');
        return;
      }

      stdout.write('Enter category (leafy, root, fruit): ');
      final category = stdin.readLineSync()!;

      stdout.write('Enter expiry date (yyyy-mm-dd): ');
      final expiryDate = DateTime.parse(stdin.readLineSync()!);

      final id = _generateVegetableId();

      final vegetable = Vegetable(
        id: id,
        name: name,
        pricePerKg: price,
        availableQuantity: quantity,
        category: category,
        expiryDate: expiryDate,
      );

      await _inventoryManager.addVegetable(vegetable);
      print('Vegetable added successfully with ID: $id');
    } catch (e) {
      print('Error adding vegetable: $e');
    }
  }

  Future<void> _updateStock() async {
    try {
      stdout.write('Enter vegetable ID: ');
      final id = stdin.readLineSync()!;

      stdout.write('Enter quantity to update: ');
      final quantity = double.parse(stdin.readLineSync()!);

      await _inventoryManager.updateStock(id, quantity);
      print('Stock updated successfully.');
    } catch (e) {
      print('Error updating stock: $e');
    }
  }

  Future<void> _removeVegetable() async {
    try {
      stdout.write('Enter vegetable ID to remove: ');
      final id = stdin.readLineSync()!;
      await _inventoryManager.removeVegetable(id);
      print('Vegetable removed successfully.');
    } catch (e) {
      print('Error removing vegetable: $e');
    }
  }

  String _generateVegetableId() {
    final id = 'C${_idCounter.toString().padLeft(3, '0')}';
    _idCounter++;
    return id;
  }
}
