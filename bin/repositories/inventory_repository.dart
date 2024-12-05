import 'dart:convert';
import 'dart:io';
import '../models/vegetable.dart';

class InventoryRepository {
  final String filePath = 'database/inventory.json';

  Future<List<Vegetable>> loadInventory() async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return [];
      final data = jsonDecode(await file.readAsString()) as List;
      return data.map((e) => Vegetable(
        id: e['id'],
        name: e['name'],
        pricePerKg: e['pricePerKg'],
        availableQuantity: e['availableQuantity'],
        category: e['category'],
        expiryDate: DateTime.parse(e['expiryDate']),
      )).toList();
    } catch (e) {
      throw Exception('Error loading inventory: $e');
    }
  }

  Future<void> saveInventory(List<Vegetable> inventory) async {
    try {
      final file = File(filePath);
      final data = inventory.map((v) => {
        'id': v.id,
        'name': v.name,
        'pricePerKg': v.pricePerKg,
        'availableQuantity': v.availableQuantity,
        'category': v.category,
        'expiryDate': v.expiryDate.toIso8601String(),
      }).toList();
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      throw Exception('Error saving inventory: $e');
    }
  }
}
