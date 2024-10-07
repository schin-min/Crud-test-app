import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktop_clone/Api/api_service.dart';
import '../models/item.dart';

// StateNotifier for managing items
class ItemNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  final ApiService apiService;

  ItemNotifier(this.apiService) : super(const AsyncValue.loading()) {
    fetchItems();
  }

  // Fetch items from Crudcrud API
  Future<void> fetchItems() async {
    try {
      final items = await apiService.fetchItems();
      state = AsyncValue.data(items);
    } catch (e) {
      state = AsyncValue.error(e,StackTrace.current);
    }
  }

  // Create a new item
  Future<void> createItem(String name) async {
    try {
      final newItem = await apiService.createItem(name);
      state = AsyncValue.data([...state.value!, newItem]);
    } catch (e) {
      state = AsyncValue.error(e,StackTrace.current);
    }
  }

  // Update an item
  Future<void> updateItem(String id, String name) async {
    try {
      await apiService.updateItem(id, name);
      state = AsyncValue.data(state.value!.map((item) {
        if (item.id == id) {
          return Item(id: id, name: name);
        }
        return item;
      }).toList());
    } catch (e) {
      state = AsyncValue.error(e,StackTrace.current);
    }
  }

  // Delete an item
  Future<void> deleteItem(String id) async {
    try {
      await apiService.deleteItem(id);
      state = AsyncValue.data(
          state.value!.where((item) => item.id != id).toList());
    } catch (e) {
      state = AsyncValue.error(e,StackTrace.current);
    }
  }
}

// Provider for ItemNotifier
final itemProvider =
    StateNotifierProvider<ItemNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemNotifier(ApiService());
});
