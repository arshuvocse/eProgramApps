
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../repositories/item_repository.dart';

class ItemViewModel extends ChangeNotifier {
  final ItemRepository _repository = ItemRepository();

  List<Item> _items = [];
  List<Item> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      _items = await _repository.getItems();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
