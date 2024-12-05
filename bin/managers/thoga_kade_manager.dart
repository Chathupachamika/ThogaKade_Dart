import '../models/vegetable.dart';
import '../repositories/inventory_repository.dart';

abstract class ThogaKadeState {}

class LoadingState extends ThogaKadeState {}

class LoadedState extends ThogaKadeState {
  final List<Vegetable> inventory;
  LoadedState(this.inventory);
}

class ErrorState extends ThogaKadeState {
  final String message;
  ErrorState(this.message);
}

class ThogaKadeManager {
  ThogaKadeState _state = LoadingState();
  final InventoryRepository _repository = InventoryRepository();

  ThogaKadeState get state => _state;

  Future<void> loadInventory() async {
    _state = LoadingState();
    try {
      final inventory = await _repository.loadInventory();
      _state = LoadedState(inventory);
    } catch (e) {
      _state = ErrorState('Failed to load inventory: $e');
    }
  }

  Future<void> addVegetable(Vegetable vegetable) async {
    if (_state is LoadedState) {
      final inventory = List<Vegetable>.from((_state as LoadedState).inventory)
        ..add(vegetable);
      await _repository.saveInventory(inventory);
      _state = LoadedState(inventory);
    }
  }
}
